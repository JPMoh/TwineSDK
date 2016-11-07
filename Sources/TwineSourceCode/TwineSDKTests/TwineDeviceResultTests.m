//
//  TwineDeviceResultTests.m
//  TwineSDK
//
//  Created by John Mohler on 10/28/16.
//  Copyright © 2016 JP Mohler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TwineDeviceResult.h"
#import "TwineIdentityResult.h"

@interface TwineDeviceResultTests : XCTestCase

@end

@implementation TwineDeviceResultTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


- (void)testJsonComposition {
 
    TwineDeviceResult *twineDeviceResult = [[TwineDeviceResult alloc] init];;
    
    twineDeviceResult.adId = @"";
    twineDeviceResult.tracking = @"";
    twineDeviceResult.handsetModel = @"";
    twineDeviceResult.osVersion = @"";
    twineDeviceResult.wirelessCarrier = @"";
    twineDeviceResult.wirelessRoamingCarrier = @"";
    twineDeviceResult.countryCode = @"";
    twineDeviceResult.wirelessCarrier = @"";
    twineDeviceResult.timePoint = @"";
    
    NSDictionary *jsonDict = [twineDeviceResult composeResult];
    
    NSMutableDictionary *testDict = [[NSMutableDictionary alloc] init]; // Don't always need this
    // Note you can't use setObject: forKey: if you are using NSDictionary
    [testDict setObject:@"" forKey:@"ai"];
    [testDict setObject:[[NSBundle mainBundle] bundleIdentifier] forKey:@"dv"];
    [testDict setObject:@"4" forKey:@"dt"];
    [testDict setObject:@"" forKey:@"hs"];
    [testDict setObject:@"" forKey:@"os"];
    [testDict setObject:@"" forKey:@"wn"];
    [testDict setObject:@"" forKey:@"wr"];
    [testDict setObject:@"" forKey:@"wc"];
    [testDict setObject:@"" forKey:@"cc"];
    [testDict setObject:@"" forKey:@"tr"];
    [testDict setObject:@"" forKey:@"lg"];
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
