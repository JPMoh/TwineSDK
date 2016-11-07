//
//  EventMessage.m
//  TwineObjectiveCSDK
//
//  Created by John Mohler on 10/14/16.
//  Copyright © 2016 John Mohler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TwineEventMessage.h"
#import "TwineUtil.h"
#import "TwineEventResult.h"

@interface TwineEventMessage()

@end

@implementation TwineEventMessage

NSString * const twineEventURL = @"https://lo1dh955ug.execute-api.us-west-2.amazonaws.com/dev";
NSString * const twineEventPreferencesKey = @"behavioralEndpoint";

-(void)send:(NSString*)event detail:(NSString*)detail {
    
    TwineUtil *util;
    TwineEventResult *eventResult;

    eventResult = [[TwineEventResult alloc] init];
    util = [[TwineUtil alloc] init];
    
    eventResult.adId = [util getIDFA];
    eventResult.eventName = event;
    eventResult.eventDetail = detail;
    eventResult.timePoint = [NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSince1970]];
    
    NSDictionary* resultDict= [eventResult composeResult];
    NSString* endPoint = [util getEndpoint:twineEventURL preferencesKey:twineEventPreferencesKey];

    [util postJSON:resultDict endPoint:endPoint];

}

@end

