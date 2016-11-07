//
//  TwineLocationManagerTests.m
//  TwineSDK
//
//  Created by John Mohler on 10/28/16.
//  Copyright © 2016 JP Mohler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TwineLocationManager.h"
#import "TwineLocationResult.h"

@interface TwineLocationResultTests : XCTestCase

@end

@implementation TwineLocationResultTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testJsonComposition {
    
    TwineLocationResult *twineLocationResult = [[TwineLocationResult alloc] init];;
    
    twineLocationResult.adId = @"";
    twineLocationResult.latitude = @"";
    twineLocationResult.longitude = @"";
    twineLocationResult.horizontalAccuracy = @"";
    twineLocationResult.fGOrBg = @"";
    twineLocationResult.timePoint = @"";
    NSDictionary *jsonDict = [twineLocationResult composeResult];
    
    NSMutableDictionary *testDict = [[NSMutableDictionary alloc] init]; // Don't always need this
    [testDict setObject:@"" forKey:@"ai"];
    [testDict setObject:[[NSBundle mainBundle] bundleIdentifier] forKey:@"dv"];
    [testDict setObject:@"4" forKey:@"dt"];
    [testDict setObject:@"" forKey:@"la"];
    [testDict setObject:@"" forKey:@"ln"];
    [testDict setObject:@"fn" forKey:@"lm"];
    [testDict setObject:@"" forKey:@"ha"];
    [testDict setObject:@"" forKey:@"lt"];
    [testDict setObject:@"" forKey:@"ts"];

    XCTAssertEqualObjects(jsonDict, testDict);
    // This is an exampl¨e of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testComposeJsonMethod {
    
    XCTAssertEqualObjects(@"hi",@"hi");
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}



@end
