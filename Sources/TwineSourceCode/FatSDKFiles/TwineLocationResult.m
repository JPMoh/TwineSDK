//
//  LocationResult.m
//  TwineObjectiveCSDK
//
//  Created by John Mohler on 10/14/16.
//  Copyright © 2016 John Mohler. All rights reserved.
//

#import "TwineLocationResult.h"

@interface TwineLocationResult()
        
    @end

@implementation TwineLocationResult

- (NSDictionary*)composeResult {
    
    NSMutableDictionary *jsonDict = [NSMutableDictionary dictionary];
    
    jsonDict[@"ai"] = @"4";
    jsonDict[@"dv"] = [[NSBundle mainBundle] bundleIdentifier];
    jsonDict[@"dt"] = self.adId;
    jsonDict[@"la"] = self.latitude;
    jsonDict[@"ln"] = self.longitude;
    jsonDict[@"ha"] = self.horizontalAccuracy;
    jsonDict[@"lm"] = @"fn";
    jsonDict[@"lt"] = self.fGOrBg;
    jsonDict[@"ts"] = self.timePoint;

    return jsonDict;
};
    @end
