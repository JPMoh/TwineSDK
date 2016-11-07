//
//  IdentityResult.h
//  TwineObjectiveCSDK
//
//  Created by John Mohler on 10/14/16.
//  Copyright © 2016 John Mohler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TwineIdentityResult;

@interface TwineIdentityResult : NSObject

@property (nonatomic, copy) NSString *adId;
@property (nonatomic, copy) NSString *timePoint;
@property (nonatomic, copy) NSString *rawPhone;
@property (nonatomic, copy) NSString *rawEmail;
@property (nonatomic, copy) NSString *lcEmailSHA1;
@property (nonatomic, copy) NSString *lcEmailMD5;
@property (nonatomic, copy) NSString *lcEmailSHA256;
@property (nonatomic, copy) NSString *ucEmailSHA1;
@property (nonatomic, copy) NSString *ucEmailMD5;
@property (nonatomic, copy) NSString *ucEmailSHA256;
@property (nonatomic, copy) NSString *lcPhoneSHA1;
@property (nonatomic, copy) NSString *lcPhoneMD5;
@property (nonatomic, copy) NSString *lcPhoneSHA256;
@property (nonatomic, copy) NSString *ucPhoneSHA1;
@property (nonatomic, copy) NSString *ucPhoneMD5;
@property (nonatomic, copy) NSString *ucPhoneSHA256;
@property (nonatomic, copy) NSString *pcc;



- (NSDictionary*)composeResult;

@end
