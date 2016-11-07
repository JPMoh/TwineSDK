//
//  IdentityMessage.h
//  TwineObjectiveCSDK
//
//  Created by John Mohler on 10/14/16.
//  Copyright © 2016 John Mohler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TwineIdentityMessage;

@interface TwineIdentityMessage : NSObject

extern NSString * const twineIdentityURL;
extern NSString * const twineIdentityPreferencesKey;
-(void)send:(NSString*)email phoneNumber:(NSString*)phoneNumber;
-(void)sendEmail:(NSString*)email;
-(void)sendPhone:(NSString*)phone;

@end
