
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TWRScanManager.h"
#import "TwineSignalManager.h"
#import "TWRDeviceScanOperation.h"
#import "TWRWifiScanOperation.h"
#import "TWRBluetoothScanOperation.h"
#import "TWRScanResult.h"
#import "TWRUploadScanResultOperation.h"
#import "TWRLocationScanOperation.h"
#import <CoreLocation/CoreLocation.h>

#define SCAN_SECS 8
#define MIN_SECS_BETWEEN_SCANS 900

@interface TWRScanManager() <CLLocationManagerDelegate>

@property (assign) BOOL scanInProgress;
@property (assign) BOOL allowLocationScan;
@property (nonatomic, strong) NSURL *wrPostURL;
@property (nonatomic, strong) NSURLSessionConfiguration *wrSessionConfig;
@property (nonatomic, strong) NSOperationQueue *scanOperationQueue;
@property (nonatomic, strong) TWRScanResult *scanResult;
@property (nonatomic, strong) NSMutableArray *scansToUpload;
@property (nonatomic, strong) NSDate *lastScanAt;
@property (nonatomic, strong) CLLocationManager *clManager;

@end

@implementation TWRScanManager

+ (instancetype)sharedManager {
    static TWRScanManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        _scanOperationQueue = [[NSOperationQueue alloc] init];
        _scansToUpload = [NSMutableArray array];

        self.clManager = [[CLLocationManager alloc] init];
        self.clManager.delegate = self;
        self.clManager.desiredAccuracy = kCLLocationAccuracyBest;
        [self.clManager requestAlwaysAuthorization];
        [self.clManager startUpdatingLocation];
        [self.clManager startMonitoringSignificantLocationChanges];
         self.clManager.pausesLocationUpdatesAutomatically = NO;

    }
    
    return self;
}

#pragma mark - Memory Management

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - scanning

- (BOOL)isScanning {
    return self.scanInProgress;
}


- (void)scan {

    self.scanInProgress = YES;
    self.scanResult = [[TWRScanResult alloc] init];
    
    TWRDeviceScanOperation *devScanOp = [[TWRDeviceScanOperation alloc] initWithResult:self.scanResult];
    devScanOp.completionBlock = ^{
    };
    
    TWRWifiScanOperation *wifiScanOp = [[TWRWifiScanOperation alloc] initWithResult:self.scanResult];
    wifiScanOp.completionBlock = ^{
    };
    
    TWRBluetoothScanOperation *bleScanOp = [[TWRBluetoothScanOperation alloc] initWithResult:self.scanResult scanTime:SCAN_SECS];
    bleScanOp.completionBlock = ^{
    };
    
    TWRLocationScanOperation *locScanOp = [[TWRLocationScanOperation alloc] initWithResult:self.scanResult scanTime:SCAN_SECS];
    locScanOp.completionBlock = ^{
    };

    TWRUploadScanResultOperation *uploadOp = [[TWRUploadScanResultOperation alloc] initWithUploadURL:self.uploadURL
                                                                                          scanResult:self.scanResult];
    [uploadOp addDependency:devScanOp];
    [uploadOp addDependency:wifiScanOp];
    [uploadOp addDependency:bleScanOp];
    
    if ([TwineSignalManager sharedManager].allowLocationScan) {
    [uploadOp addDependency:locScanOp];
    [self.scanOperationQueue addOperation:locScanOp];
    }
    
    uploadOp.completionBlock = ^{
        self.scanInProgress = NO;
        self.lastScanAt = [NSDate date];
    };
    
    [self.scanOperationQueue addOperation:devScanOp];
    [self.scanOperationQueue addOperation:wifiScanOp];
    [self.scanOperationQueue addOperation:bleScanOp];
    [self.scanOperationQueue addOperation:uploadOp];
    
    self.scanResult.scanTime = [NSDate date];
    self.scanResult.token = [TwineSignalManager sharedManager].token;
    self.scanResult.appName = [TwineSignalManager sharedManager].appName;
    
    }

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{

    [[TWRScanManager sharedManager] scanIfNoRecentScans];
    
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil && [TwineSignalManager sharedManager].allowLocationScan) {
        self.scanResult.latitude = [[NSNumber alloc] initWithDouble:currentLocation.coordinate.latitude];
        self.scanResult.longitude = [[NSNumber alloc] initWithDouble:currentLocation.coordinate.longitude];
    }
    
}

- (void)scanIfNoRecentScans {
   
    NSDate *lastDateFromDefault = [NSDate date];
    NSDate *currentDate = [NSDate date];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
   
    if ([defaults objectForKey:@"TWRSDKLastScanTime"] != nil) {
        
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"MMMM dd, yyyy (EEEE) HH:mm:ss z Z"];
        lastDateFromDefault = [defaults objectForKey:@"TWRSDKLastScanTime"];
        
    }
    
    else {
        NSDate *date = [NSDate date];
        
        [[NSUserDefaults standardUserDefaults] setObject:date forKey:@"TWRSDKLastScanTime"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[TwineSignalManager sharedManager] scanNow];
        
        return;
    }
    
    if ([currentDate timeIntervalSinceDate:lastDateFromDefault] > MIN_SECS_BETWEEN_SCANS) {
        
        [[TwineSignalManager sharedManager] scanNow];
        NSDate *date = [NSDate date];
        [[NSUserDefaults standardUserDefaults] setObject:date forKey:@"TWRSDKLastScanTime"];
        [[NSUserDefaults standardUserDefaults] synchronize];

    }
    
}

- (void)stopUpdating {
    
    [self.clManager stopUpdatingLocation];
    
}

- (BOOL)shouldScanNow {
    NSDate *now = [NSDate date]
    ;
    if (!self.lastScanAt) {
        return YES;
    }
    
    return ([now timeIntervalSinceDate:self.lastScanAt] >= MIN_SECS_BETWEEN_SCANS );
}

- (void)uploadPastScans {
    for (TWRScanResult *r in self.scansToUpload) {
        TWRUploadScanResultOperation *op = [[TWRUploadScanResultOperation alloc] initWithUploadURL:self.uploadURL scanResult:r];
        [self.scanOperationQueue addOperation:op];
    }
}

@end
