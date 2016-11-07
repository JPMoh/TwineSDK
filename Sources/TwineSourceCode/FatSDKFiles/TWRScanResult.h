//
//  TWRScanResult.h
//  
//
//  Created by John Mohler on 6/20/16.
//  Copyright © 2016 The Wireless Registry. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TWRBLEPeripheralResult;

@interface TWRScanResult : NSOperation

@property (nonatomic, strong) NSArray *bleDevices;
@property (nonatomic, strong) NSDate *scanTime;
@property (nonatomic, copy) NSString *wifiSSID;
@property (nonatomic, copy) NSString *idfa;
@property (nonatomic, copy) NSString *deviceInfo;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *appName;
@property (nonatomic, copy) NSNumber *latitude;
@property (nonatomic, copy) NSNumber *longitude;
    

- (NSString *)displayText;
- (NSString *)displayJSON;
- (NSData *)resultJSON;
- (void)addBleDevice:(TWRBLEPeripheralResult *)device;

@end
