//
//  IdentityResult.m
//  TwineObjectiveCSDK
//
//  Created by John Mohler on 10/14/16.
//  Copyright © 2016 John Mohler. All rights reserved.
//


#import "TwineIdentityResult.h"

@interface TwineIdentityResult()

@end

@implementation TwineIdentityResult

- (NSDictionary*)composeResult {
    
    NSMutableDictionary *jsonDict = [NSMutableDictionary dictionary];
    
    jsonDict[@"ai"] = @"4";
    jsonDict[@"dv"] = [[NSBundle mainBundle] bundleIdentifier];
    jsonDict[@"dt"] = self.adId;
    jsonDict[@"pcc"] = self.pcc;
    jsonDict[@"e"] = self.rawEmail;
    jsonDict[@"p"] = self.rawPhone;
    jsonDict[@"els1"] = self.lcEmailSHA1;
    jsonDict[@"elm5"] = self.lcEmailMD5;
    jsonDict[@"els2"] = self.lcEmailSHA256;
    jsonDict[@"eus1"] = self.ucEmailSHA1;
    jsonDict[@"eum5"] = self.ucEmailMD5;
    jsonDict[@"eus2"] = self.ucEmailSHA256;
    jsonDict[@"ps1"] = self.lcPhoneSHA1;
    jsonDict[@"pm5"] = self.lcPhoneMD5;
    jsonDict[@"ps2"] = self.lcPhoneSHA256;
    jsonDict[@"ts"] = self.timePoint;

    
    return jsonDict;
};
@end
