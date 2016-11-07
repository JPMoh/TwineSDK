//
//  TWRWifiScanOperation.m
//  
//  Copyright © 2016 The Wireless Registry. All rights reserved.


#import "TWRWifiScanOperation.h"
#import "TWRScanResult.h"

@import SystemConfiguration.CaptiveNetwork;

@implementation TWRWifiScanOperation

- (instancetype)initWithResult:(TWRScanResult *)result {
    if (self = [super init]) {
        _result = result;
    }
    return self;
}

- (void)main {
    @try {
        NSLog(@"Start WifiScanOp");
        NSArray *interfaceNames = CFBridgingRelease(CNCopySupportedInterfaces());
            
        NSDictionary *ssidInfo;
        NSString *connectedWiFiSSID = @"No Connection";
        for (NSString *interfaceName in interfaceNames) {
            if ([self isCancelled]) {
                break;
            }
            ssidInfo = CFBridgingRelease(CNCopyCurrentNetworkInfo((__bridge CFStringRef)interfaceName));
            connectedWiFiSSID = (ssidInfo) ? ssidInfo[@"SSID"] : @"No Connection";
            NSLog(@"%s: %@ => %@", __func__, interfaceName, ssidInfo);
        }
            
        self.result.wifiSSID = connectedWiFiSSID;
    }
    @catch(NSException *e) {
        NSLog(@"Error on TWRDeviceScanOperation: %@", e);
        self.result.wifiSSID = @"No Connection";
    }
}

@end
