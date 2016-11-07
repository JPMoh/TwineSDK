//
//  TwineDeviceResult.m
//  TwineObjectiveCSDK
//
//  Created by John Mohler on 10/14/16.
//  Copyright © 2016 John Mohler. All rights reserved.
//

#import "TwineDeviceResult.h"

@interface TwineDeviceResult()

@end

@implementation TwineDeviceResult

- (NSDictionary*)composeResult {
    
    NSMutableDictionary *jsonDict = [NSMutableDictionary dictionary];
    
    jsonDict[@"ai"] = @"4";
    jsonDict[@"dv"] = [[NSBundle mainBundle] bundleIdentifier];
    jsonDict[@"dt"] = self.adId;
    jsonDict[@"hs"] = self.handsetModel;
    jsonDict[@"os"] = self.osVersion;
    jsonDict[@"wn"] = @"";
    jsonDict[@"wr"] = self.wirelessRoamingCarrier;
    jsonDict[@"wc"] = self.wirelessCarrier;
    jsonDict[@"cc"] = self.countryCode;
    jsonDict[@"tr"] = self.tracking;
    jsonDict[@"lg"] = self.language;
    jsonDict[@"ts"] = self.timePoint;
    
    return jsonDict;
};
@end
