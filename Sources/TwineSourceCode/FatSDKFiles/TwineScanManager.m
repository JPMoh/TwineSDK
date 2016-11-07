
#import <Foundation/Foundation.h>
#import "TwineScanManager.h"
#import <UIKit/UIKit.h>
#import <sys/utsname.h>
#import <CoreLocation/CoreLocation.h>
#import "TwineUtil.h"
#import "TwineLocationResult.h"
#import "TwineDeviceResult.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

#define SCAN_SECS 8
#define MIN_SECS_BETWEEN_LOCATION_SCANS 1200
#define MIN_SECS_BETWEEN_DEVICE_SCANS 86400

@interface TwineScanManager() <CLLocationManagerDelegate>

    @property (assign) BOOL scanInProgress;
    @property (assign) BOOL allowLocationScan;
    @property (nonatomic, strong) NSURL *wrPostURL;
    @property (nonatomic, strong) NSURLSessionConfiguration *wrSessionConfig;
    @property (nonatomic, strong) NSOperationQueue *scanOperationQueue;
    @property (nonatomic, strong) NSMutableArray *scansToUpload;
    @property (nonatomic, strong) NSDate *lastScanAt;
    @property (nonatomic, strong) CLLocationManager *clManager;
    @end

@implementation TwineScanManager

NSString * const twineLocationURL = @"https://28ull615gk.execute-api.us-west-2.amazonaws.com/dev";
NSString * const twineLocationPreferencesKey = @"locationEndpoint";
NSString * const twineDeviceURL = @"https://s6emqs9sr9.execute-api.us-west-2.amazonaws.com/dev";
NSString * const twineDevicePreferencesKey = @"dHHCEndpoint";

+ (instancetype)sharedManager {
    static TwineScanManager *instance = nil;
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

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
    {
        
        [self sendLocationIfNoRecentScans:newLocation.coordinate.latitude longitude:newLocation.coordinate.longitude horizontalAccuracy:newLocation.horizontalAccuracy];
        [self sendDeviceCharacteristicsIfNoRecentScans];


        
    }
    
- (void)sendLocation:(double)latitude longitude:(double)longitude horizontalAccuracy:(double)horizontalAccuracy {
    
    TwineUtil *util;
    TwineLocationResult *locationResult;
    
    locationResult = [[TwineLocationResult alloc] init];
    util = [[TwineUtil alloc] init];

    locationResult.latitude = [NSString stringWithFormat:@"%lf", latitude];
    locationResult.longitude = [NSString stringWithFormat:@"%lf", longitude];
    locationResult.horizontalAccuracy = [NSString stringWithFormat:@"%lf", horizontalAccuracy];
    locationResult.timePoint =[NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSince1970]];

    if ([self runningInForeground]) {
        
        locationResult.fGOrBg = @"fg";
    }
    else {
        locationResult.fGOrBg = @"bg";
    } 

    locationResult.adId = [util getIDFA];
    
    NSDictionary* resultDict= [locationResult composeResult];
    NSString* endPoint = [util getEndpoint:twineLocationURL preferencesKey:twineLocationPreferencesKey];

    [util postJSON:resultDict endPoint:endPoint];

    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MMMM dd, yyyy (EEEE) HH:mm:ss z Z"];
    NSDate *now = [NSDate date];
    NSString *nsstr = [format stringFromDate:now];
    
    NSArray *resultsArray = [NSArray arrayWithObjects: nsstr,locationResult.adId, locationResult.latitude, locationResult.longitude, locationResult.horizontalAccuracy, nil];
    
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:resultsArray forKey:@"Result"];
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"twineLocationScanDone"
     object:nil
     userInfo:userInfo];

    //set new "last location scan" date
    NSDate *date = [NSDate date];
    [[NSUserDefaults standardUserDefaults] setObject:date forKey:@"TwineLocationLastScanTime"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}


- (void)sendDevice {
    
    NSLog(@"Sending");
    TwineUtil *util;
    TwineDeviceResult *deviceResult;
    deviceResult = [[TwineDeviceResult alloc] init];
    util = [[TwineUtil alloc] init];

    deviceResult.adId = [util getIDFA];
    deviceResult.handsetModel = [self deviceName];
    deviceResult.osVersion = [[UIDevice currentDevice] systemVersion];
    deviceResult.tracking = [util isTracking];
    deviceResult.timePoint =[NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSince1970]];
    NSLocale *currentLocale = [NSLocale currentLocale];  // get the current locale.
    deviceResult.countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
    deviceResult.language = [[NSLocale preferredLanguages] objectAtIndex:0];

    
    CTTelephonyNetworkInfo *netinfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [netinfo subscriberCellularProvider];
    NSString *carrierName = [carrier carrierName];
    if (carrierName != nil) {
        deviceResult.wirelessCarrier = [carrier carrierName];
        deviceResult.wirelessRoamingCarrier = [carrier carrierName];

    }
    else {
        deviceResult.wirelessCarrier = @"Unknown";
        deviceResult.wirelessRoamingCarrier = @"Unknown";

    }

    NSDictionary* resultDict= [deviceResult composeResult];
    NSString* endPoint = [util getEndpoint:twineDeviceURL preferencesKey:twineDevicePreferencesKey];

    [util postJSON:resultDict endPoint:endPoint];
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MMMM dd, yyyy (EEEE) HH:mm:ss z Z"];
    NSDate *now = [NSDate date];
    NSString *nsstr = [format stringFromDate:now];

    NSArray *resultsArray = [NSArray arrayWithObjects: deviceResult.adId, deviceResult.osVersion, deviceResult.wirelessCarrier, deviceResult.countryCode, deviceResult.language, deviceResult.handsetModel,[[NSBundle mainBundle] bundleIdentifier] , [NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSince1970]], nsstr, nil];
    
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:resultsArray forKey:@"Result"];
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"twineDeviceScanDone"
     object:nil
     userInfo:userInfo];

    //set new "last location scan" date
    NSDate *date = [NSDate date];
    [[NSUserDefaults standardUserDefaults] setObject:date forKey:@"TwineDeviceLastScanTime"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}


- (void)sendLocationIfNoRecentScans:(double)latitude longitude:(double)longitude horizontalAccuracy:(double)horizontalAccuracy {
    
    NSDate *lastDateFromDefault = [NSDate date];
    NSDate *currentDate = [NSDate date];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults objectForKey:@"TwineLocationLastScanTime"] != nil) {
        
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"MMMM dd, yyyy (EEEE) HH:mm:ss z Z"];
        lastDateFromDefault = [defaults objectForKey:@"TwineLocationLastScanTime"];
        
        if ([currentDate timeIntervalSinceDate:lastDateFromDefault] > MIN_SECS_BETWEEN_LOCATION_SCANS) {
            
            NSDate *date = [NSDate date];
            [[NSUserDefaults standardUserDefaults] setObject:date forKey:@"TwineLocationLastScanTime"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self sendLocation:latitude longitude:longitude horizontalAccuracy:horizontalAccuracy];

        }

    }
    
    else {
     
        NSDate *date = [NSDate date];
        
        [[NSUserDefaults standardUserDefaults] setObject:date forKey:@"TwineLocationLastScanTime"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self sendLocation:latitude longitude:longitude horizontalAccuracy:horizontalAccuracy];
        
    }
    
}

- (void)sendDeviceCharacteristicsIfNoRecentScans {
    
    NSDate *lastDateFromDefault = [NSDate date];
    NSDate *currentDate = [NSDate date];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults objectForKey:@"TwineDeviceLastScanTime"] != nil) {
        
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"MMMM dd, yyyy (EEEE) HH:mm:ss z Z"];
        lastDateFromDefault = [defaults objectForKey:@"TwineDeviceLastScanTime"];
        
        if ([currentDate timeIntervalSinceDate:lastDateFromDefault] > MIN_SECS_BETWEEN_DEVICE_SCANS) {
            
            NSDate *date = [NSDate date];
            [[NSUserDefaults standardUserDefaults] setObject:date forKey:@"TwineDeviceLastScanTime"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self sendDevice];
            
        }
        
    }
    
    else {
        
        NSDate *date = [NSDate date];
        
        [[NSUserDefaults standardUserDefaults] setObject:date forKey:@"TwineDeviceLastScanTime"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self sendDevice];
        
        //send
        
    }
    
    
}

- (NSString*) deviceName
{
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString* code = [NSString stringWithCString:systemInfo.machine
                                        encoding:NSUTF8StringEncoding];
    
    static NSDictionary* deviceNamesByCode = nil;
    
    if (!deviceNamesByCode) {
        
        deviceNamesByCode = @{@"i386"      :@"Simulator",
                              @"x86_64"    :@"Simulator",
                              @"iPod1,1"   :@"iPod Touch",        // (Original)
                              @"iPod2,1"   :@"iPod Touch",        // (Second Generation)
                              @"iPod3,1"   :@"iPod Touch",        // (Third Generation)
                              @"iPod4,1"   :@"iPod Touch",        // (Fourth Generation)
                              @"iPod7,1"   :@"iPod Touch",        // (6th Generation)
                              @"iPhone1,1" :@"iPhone",            // (Original)
                              @"iPhone1,2" :@"iPhone",            // (3G)
                              @"iPhone2,1" :@"iPhone",            // (3GS)
                              @"iPad1,1"   :@"iPad",              // (Original)
                              @"iPad2,1"   :@"iPad 2",            //
                              @"iPad3,1"   :@"iPad",              // (3rd Generation)
                              @"iPhone3,1" :@"iPhone 4",          // (GSM)
                              @"iPhone3,3" :@"iPhone 4",          // (CDMA/Verizon/Sprint)
                              @"iPhone4,1" :@"iPhone 4S",         //
                              @"iPhone5,1" :@"iPhone 5",          // (model A1428, AT&T/Canada)
                              @"iPhone5,2" :@"iPhone 5",          // (model A1429, everything else)
                              @"iPad3,4"   :@"iPad",              // (4th Generation)
                              @"iPad2,5"   :@"iPad Mini",         // (Original)
                              @"iPhone5,3" :@"iPhone 5c",         // (model A1456, A1532 | GSM)
                              @"iPhone5,4" :@"iPhone 5c",         // (model A1507, A1516, A1526 (China), A1529 | Global)
                              @"iPhone6,1" :@"iPhone 5s",         // (model A1433, A1533 | GSM)
                              @"iPhone6,2" :@"iPhone 5s",         // (model A1457, A1518, A1528 (China), A1530 | Global)
                              @"iPhone7,1" :@"iPhone 6 Plus",     //
                              @"iPhone7,2" :@"iPhone 6",          //
                              @"iPhone8,1" :@"iPhone 6S",         //
                              @"iPhone8,2" :@"iPhone 6S Plus",    //
                              @"iPhone8,4" :@"iPhone SE",         //
                              @"iPhone9,1" :@"iPhone 7",          //
                              @"iPhone9,3" :@"iPhone 7",          //
                              @"iPhone9,2" :@"iPhone 7 Plus",     //
                              @"iPhone9,4" :@"iPhone 7 Plus",     //
                              
                              @"iPad4,1"   :@"iPad Air",          // 5th Generation iPad (iPad Air) - Wifi
                              @"iPad4,2"   :@"iPad Air",          // 5th Generation iPad (iPad Air) - Cellular
                              @"iPad4,4"   :@"iPad Mini",         // (2nd Generation iPad Mini - Wifi)
                              @"iPad4,5"   :@"iPad Mini",         // (2nd Generation iPad Mini - Cellular)
                              @"iPad4,7"   :@"iPad Mini",         // (3rd Generation iPad Mini - Wifi (model A1599))
                              @"iPad6,7"   :@"iPad Pro (12.9\")", // iPad Pro 12.9 inches - (model A1584)
                              @"iPad6,8"   :@"iPad Pro (12.9\")", // iPad Pro 12.9 inches - (model A1652)
                              @"iPad6,3"   :@"iPad Pro (9.7\")",  // iPad Pro 9.7 inches - (model A1673)
                              @"iPad6,4"   :@"iPad Pro (9.7\")"   // iPad Pro 9.7 inches - (models A1674 and A1675)
                              };
        
    }
    
    NSString* deviceName = [deviceNamesByCode objectForKey:code];
    
    if (!deviceName) {
        // Not found on database. At least guess main device type from string contents:
        
        if ([code rangeOfString:@"iPod"].location != NSNotFound) {
            deviceName = @"iPod Touch";
        }
        else if([code rangeOfString:@"iPad"].location != NSNotFound) {
            deviceName = @"iPad";
        }
        else if([code rangeOfString:@"iPhone"].location != NSNotFound){
            deviceName = @"iPhone";
        }
        else {
            deviceName = @"Unknown";
        }
    }
    
    return deviceName;
}

-(void) stopUpdating {
    
    [self.clManager stopUpdatingLocation];

}
-(BOOL) runningInForeground
{
    UIApplicationState state = [UIApplication sharedApplication].applicationState;
    return state == UIApplicationStateActive;
}
    
    
    @end
