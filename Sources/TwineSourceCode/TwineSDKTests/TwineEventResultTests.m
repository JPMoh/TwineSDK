//
//  TwineEventMessageTests.m
//  TwineSDK
//
//  Created by John Mohler on 10/28/16.
//  Copyright © 2016 JP Mohler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TwineEventMessage.h"
#import "TwineEventResult.h"
#import "TwineUtil.h"

@interface TwineEventResultTests : XCTestCase

@end

@implementation TwineEventResultTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testJsonComposition {

    TwineEventResult *twineEventResult = [[TwineEventResult alloc] init];;
    
    twineEventResult.adId = @"";
    twineEventResult.eventName = @"";
    twineEventResult.eventDetail = @"";
    twineEventResult.timePoint = @"";
    
    NSDictionary *jsonDict = [twineEventResult composeResult];
    
    NSMutableDictionary *testDict = [[NSMutableDictionary alloc] init]; // Don't always need this
    // Note you can't use setObject: forKey: if you are using NSDictionary
    [testDict setObject:@"" forKey:@"ai"];
    [testDict setObject:[[NSBundle mainBundle] bundleIdentifier] forKey:@"dv"];
    [testDict setObject:@"4" forKey:@"dt"];
    [testDict setObject:@"" forKey:@"ue"];
    [testDict setObject:@"" forKey:@"ed"];
    [testDict setObject:@"" forKey:@"ts"];
    
    XCTAssertEqualObjects(jsonDict, testDict);

}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
