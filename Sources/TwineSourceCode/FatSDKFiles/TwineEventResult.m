//
//  EventResult.m
//  TwineObjectiveCSDK
//
//  Created by John Mohler on 10/14/16.
//  Copyright © 2016 John Mohler. All rights reserved.
//

#import "TwineEventResult.h"

@interface TwineEventResult()

@end

@implementation TwineEventResult

- (NSDictionary*)composeResult {

    NSMutableDictionary *jsonDict = [NSMutableDictionary dictionary];

    jsonDict[@"ai"] = @"4";
    jsonDict[@"dv"] = [[NSBundle mainBundle] bundleIdentifier];
    jsonDict[@"dt"] = self.adId;
    jsonDict[@"ue"] = self.eventName;
    jsonDict[@"ed"] = self.eventDetail;
    jsonDict[@"ts"] = self.timePoint;
    
    return jsonDict;
};
@end
