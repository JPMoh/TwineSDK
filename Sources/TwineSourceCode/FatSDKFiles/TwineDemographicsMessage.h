//
//  DemographicsMessage.h
//  TwineObjectiveCSDK
//
//  Created by John Mohler on 10/14/16.
//  Copyright © 2016 John Mohler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TwineDemographicsMessage;

@interface TwineDemographicsMessage : NSObject

extern NSString * const twineDemographicsURL;
extern NSString * const twineDemographicsPreferencesKey;

-(void)send:(NSString*)gender birthDay:(NSString*)birthDay birthYear: (NSString*)birthYear age: (NSString*)age ageRange: (NSString*)ageRange;
-(void)sendGender:(NSString*)gender;
-(void)sendBirthDay:(NSString*)birthDay;
-(void)sendBirthYear:(NSString*)birthYear;
-(void)sendAgeRange:(NSString*)ageRange;
-(void)sendAge:(NSString*)age;


@end
