//
//  TwineDeviceResult.h
//  TwineObjectiveCSDK
//
//  Created by John Mohler on 10/14/16.
//  Copyright © 2016 John Mohler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TwineDeviceResult;

@interface TwineDeviceResult : NSObject

@property (nonatomic, copy) NSString *adId;
@property (nonatomic, copy) NSString *timePoint;
@property (nonatomic, copy) NSString *handsetModel;
@property (nonatomic, copy) NSString *osVersion;
@property (nonatomic, copy) NSString *wirelessRoamingCarrier;
@property (nonatomic, copy) NSString *wirelessCarrier;
@property (nonatomic, copy) NSString *countryCode;
@property (nonatomic, copy) NSString *tracking;
@property (nonatomic, copy) NSString *language;


- (NSDictionary*)composeResult;

@end


