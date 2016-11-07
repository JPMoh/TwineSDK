//
//  TWRScanResult.m
//  
//
//  Created by John Mohler on 6/20/16.
//  Copyright © 2016 The Wireless Registry. All rights reserved.
//

#import "TWRScanResult.h"
#import "TWRBLEPeripheralResult.h"

@interface TWRScanResult()

@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) NSMutableDictionary *bleDeviceDict;

@end

@implementation TWRScanResult

- (instancetype)init {
    self = [super init];
    if (self) {
        _bleDeviceDict = [NSMutableDictionary dictionary];
        _bleDevices = [NSMutableArray array];
    }
    
    return self;
}

- (void)addBleDevice:(TWRBLEPeripheralResult *)device {
    if (![self.bleDeviceDict objectForKey:device.identifier]) {
        self.bleDeviceDict[device.identifier] = device;
        self.bleDevices = [self.bleDeviceDict allValues];
    }
}

- (NSString *)displayText {
    NSString *result = [NSString stringWithFormat:@"Scan Time: %f\n%@\n%@\n", [self.scanTime timeIntervalSince1970], self.deviceInfo, self.idfa];
    
    if (self.wifiSSID) {
        result = [NSString stringWithFormat:@"%@%@\n", result, self.wifiSSID];
    } else {
        result = [NSString stringWithFormat:@"%@No Wifi Connection\n", result];
    }
    
    // This version of SDK is NOT collecting location - always unknown.
    result = [NSString stringWithFormat:@"%@Location Unknown\n", result];
    
    if ([self.bleDevices count] > 0) {
        result = [NSString stringWithFormat:@"%@\nBLE DEVICES:\n", result];
    }
    for (TWRBLEPeripheralResult *p in self.bleDevices) {
        result = [NSString stringWithFormat:@"%@%@ (%ld)\n", result, p.name, (long)p.RSSI];
    }
    
    return result;
}

- (NSData *)resultJSON {
    NSParameterAssert(self.token);
    
    NSMutableDictionary *jsonDict = [NSMutableDictionary dictionary];
    jsonDict[@"ids"] = @[ [NSString stringWithFormat:@"ios_ifa^%@", self.idfa] ];
    jsonDict[@"token"] = [self getDefault:@"twineToken"];
    
    
    // This version of SDK is NOT collecting locaiton - always 0, 0
    jsonDict[@"lat"] = self.latitude;
    jsonDict[@"lon"] = self.longitude;
    
    jsonDict[@"timepoint"] = [NSString stringWithFormat:@"%ld", (long)[self.scanTime timeIntervalSince1970]];
    
    NSMutableArray *metaArr = [NSMutableArray array];
    [metaArr  addObject:@"sdk:ios-objc-1_0"];
    [metaArr addObject:[NSString stringWithFormat:@"device:%@", self.deviceInfo]];
    [metaArr addObject:[NSString stringWithFormat:@"app:%@", self.appName]];
    [metaArr addObject:[NSString stringWithFormat:@"tag:%@", [self getDefault:@"twineTag"]]];

    if (self.wifiSSID && ![self.wifiSSID isEqualToString:@"No Connection"]) {
        [metaArr addObject:[NSString stringWithFormat:@"cWIFI:%@", self.wifiSSID]];
    }
    jsonDict[@"metadata"] = metaArr;
    
    NSMutableArray *observed = [NSMutableArray array];
    for (TWRBLEPeripheralResult *p in self.bleDevices) {
        [observed addObject:@{ @"name" : [NSString stringWithFormat:@"%@|%@", p.name, p.identifier.UUIDString],
                               @"tech" : @"ble",
                               @"rssi" : [NSNumber numberWithInteger:p.RSSI]
                               }];
    }
    
    jsonDict[@"observed"] = observed;
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict options:NSJSONWritingPrettyPrinted error:&error];
    if (!jsonData) {
        NSLog(@"Error serializing JSON: %@", error);
        return nil;
    }
    
    return jsonData;
    
}

- (NSString*)getDefault:(NSString *) defaultKey {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = @"";
    
    if ([defaults objectForKey:defaultKey] != nil) {
        
        if([[defaults objectForKey:defaultKey] isKindOfClass:[NSString class]]) {
            
            token = [defaults objectForKey:defaultKey];
        }
    }
    
    return token;
}

- (NSString *)displayJSON {
    NSData *jsonData = [self resultJSON];
    return [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
}

@end
