////
////
////
#import "TwineSignalManager.h"
#import "UIKit/UIKit.h"
#import "TWRScanManager.h"

static NSString* const kTWRBeaconUUID = @"04DBA2F2-DDB8-4107-9C4A-7CC41F30C059";
static NSString* const kUploadURLString = @"https://pie.wirelessregistry.com/observation/";

@interface TwineSignalManager()

@property (nonatomic, strong) TWRScanManager *scanManager;

@end

@implementation TwineSignalManager

+ (instancetype)sharedManager {
    static TwineSignalManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init {
    
    if (self = [super init]) {
        _scanManager = [TWRScanManager sharedManager];
        _scanManager.uploadURL = [NSURL URLWithString:kUploadURLString];
        _allowLocationScan = true;
    }
    
    return self;
}


- (void)scanNow {
    
    [self.scanManager scan];

}

- (void)stopUpdating {
    
    [self.scanManager stopUpdating];
    
}



#pragma mark - TWR Configuration

- (void)configureWithToken:(NSString *)token appName:(NSString *)appName {
    _token = token;
    _appName = appName;
}

- (void)setAllowLocationScan:(BOOL)allowLocationScan {
    _allowLocationScan = allowLocationScan;
}


@end
