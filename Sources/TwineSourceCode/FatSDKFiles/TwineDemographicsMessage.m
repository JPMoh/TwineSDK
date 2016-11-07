//
//  DemographicsMessage.m
//  TwineObjectiveCSDK
//
//  Created by John Mohler on 10/14/16.
//  Copyright © 2016 John Mohler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TwineDemographicsMessage.h"
#import "TwineUtil.h"
#import "TwineDemographicsResult.h"

@interface TwineDemographicsMessage()

@end

@implementation TwineDemographicsMessage

NSString * const twineDemographicsURL = @"https://yxdulxejyd.execute-api.us-west-2.amazonaws.com/dev";
NSString * const twineDemographicsPreferencesKey = @"demographicsEndpoint";

-(void)send:(NSString*)gender birthDay:(NSString*)birthDay birthYear: (NSString*)birthYear age: (NSString*)age ageRange: (NSString*)ageRange {
    
    TwineUtil *util;
    TwineDemographicsResult *demographicsResult;
    demographicsResult = [[TwineDemographicsResult alloc] init];
    util = [[TwineUtil alloc] init];

    demographicsResult.adId = [util getIDFA];
    demographicsResult.gender = gender;
    demographicsResult.birthday = birthDay;
    demographicsResult.birthyear = birthYear;
    demographicsResult.ageRange = ageRange;
    demographicsResult.age = age;
    demographicsResult.timePoint =[NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSince1970]];
    NSDictionary* resultDict= [demographicsResult composeResult];
   
    NSString* endPoint = [util getEndpoint:twineDemographicsURL preferencesKey:twineDemographicsPreferencesKey];
    [util postJSON:resultDict endPoint:endPoint];
    
}


-(void)sendGender:(NSString*)gender  {

    [self send:gender birthDay:@"" birthYear:@"" age:@"" ageRange:@""];
}


-(void)sendBirthDay:(NSString*)birthDay  {
    
    [self send:@"" birthDay:birthDay birthYear:@"" age:@"" ageRange:@""];
}


-(void)sendBirthYear:(NSString*)birthYear  {
    
    [self send:@"" birthDay:@"" birthYear:birthYear age:@"" ageRange:@""];
}


-(void)sendAgeRange:(NSString*)ageRange  {
    
    [self send:@"" birthDay:@"" birthYear:@"" age:@"" ageRange:ageRange];
}


-(void)sendAge:(NSString*)age  {
    
    [self send:@"" birthDay:@"" birthYear:@"" age:age ageRange:@""];
}




@end

