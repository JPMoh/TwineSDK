//
//  DemographicsResult.m
//  TwineObjectiveCSDK
//
//  Created by John Mohler on 10/14/16.
//  Copyright © 2016 John Mohler. All rights reserved.
//

#import "TwineDemographicsResult.h"

@interface TwineDemographicsResult()

@end

@implementation TwineDemographicsResult

- (NSDictionary*)composeResult {
    
    NSMutableDictionary *jsonDict = [NSMutableDictionary dictionary];
    
    jsonDict[@"dt"] = self.adId;
    jsonDict[@"dv"] = [[NSBundle mainBundle] bundleIdentifier];
    jsonDict[@"ai"] = @"4";
    jsonDict[@"g"] = self.gender;
    jsonDict[@"lg"] = self.language;
    jsonDict[@"bd"] = self.birthday;
    jsonDict[@"by"] = self.birthyear;
    jsonDict[@"ag"] = self.age;
    jsonDict[@"ar"] = self.ageRange;
    jsonDict[@"ts"] = self.timePoint;
    

    
    return jsonDict;
};
@end
