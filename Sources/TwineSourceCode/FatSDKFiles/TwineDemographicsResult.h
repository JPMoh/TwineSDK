//
//  DemographicsResult.h
//  TwineObjectiveCSDK
//
//  Created by John Mohler on 10/14/16.
//  Copyright © 2016 John Mohler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TwineDemographicsResult;

@interface TwineDemographicsResult : NSOperation


@property (nonatomic, copy) NSString *adId;
@property (nonatomic, copy) NSString *timePoint;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, copy) NSString *birthyear;
@property (nonatomic, copy) NSString *age;
@property (nonatomic, copy) NSString *ageRange;
@property (nonatomic, copy) NSString *language;



- (NSDictionary*)composeResult;

@end

