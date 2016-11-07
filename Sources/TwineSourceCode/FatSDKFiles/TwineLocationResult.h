//
//  LocationResult.h
//  TwineObjectiveCSDK
//
//  Created by John Mohler on 10/14/16.
//  Copyright © 2016 John Mohler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TwineLocationResult;

@interface TwineLocationResult : NSObject
    
    @property (nonatomic, copy) NSString *adId;
    @property (nonatomic, copy) NSString *timePoint;
    @property (nonatomic, copy) NSString *longitude;
    @property (nonatomic, copy) NSString *latitude;
    @property (nonatomic, copy) NSString *horizontalAccuracy;
    @property (nonatomic, copy) NSString *fGOrBg;
    
- (NSDictionary*)composeResult;
    
    @end
