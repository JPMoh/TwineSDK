//
//  EventResult.h
//  TwineObjectiveCSDK
//
//  Created by John Mohler on 10/14/16.
//  Copyright © 2016 John Mohler. All rights reserved.
//
#import <Foundation/Foundation.h>

@class TwineEventResult;

@interface TwineEventResult : NSObject

@property (nonatomic, copy) NSString *adId;
@property (nonatomic, copy) NSString *eventName;
@property (nonatomic, copy) NSString *eventDetail;
@property (nonatomic, copy) NSString *timePoint;


- (NSDictionary*)composeResult;

@end


