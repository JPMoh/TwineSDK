//
//  Created by John Mohler on 10/28/16.
//  Copyright © 2016 JP Mohler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TwineDemographicsMessage.h"
#import "TwineDemographicsResult.h"
#import "TwineUtil.h"

@interface TwineDemographicsResultTests : XCTestCase

@end

@implementation TwineDemographicsResultTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testJsonComposition {
    
    TwineDemographicsResult *twineDemographicsResult = [[TwineDemographicsResult alloc] init];;
    
    twineDemographicsResult.adId = @"";
    twineDemographicsResult.gender = @"";
    twineDemographicsResult.language = @"";
    twineDemographicsResult.age = @"";
    twineDemographicsResult.ageRange = @"";
    twineDemographicsResult.birthday = @"";
    twineDemographicsResult.birthyear = @"";
    twineDemographicsResult.timePoint = @"";

    NSDictionary *jsonDict = [twineDemographicsResult composeResult];
    
    NSMutableDictionary *testDict = [[NSMutableDictionary alloc] init]; // Don't always need this
    // Note you can't use setObject: forKey: if you are using NSDictionary
    [testDict setObject:@"" forKey:@"ai"];
    [testDict setObject:[[NSBundle mainBundle] bundleIdentifier] forKey:@"dv"];
    [testDict setObject:@"4" forKey:@"dt"];
    [testDict setObject:@"fn" forKey:@"by"];
    [testDict setObject:@"" forKey:@"g"];
    [testDict setObject:@"" forKey:@"lg"];
    [testDict setObject:@"" forKey:@"bd"];
    [testDict setObject:@"" forKey:@"ag"];
    [testDict setObject:@"" forKey:@"ar"];
    [testDict setObject:@"" forKey:@"ts"];
    
    XCTAssertEqualObjects(jsonDict, testDict);
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
