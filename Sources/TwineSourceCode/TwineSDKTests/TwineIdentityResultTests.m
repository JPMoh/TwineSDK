//
//  TwineIdentityMessageTests.m
//  TwineSDK
//
//  Created by John Mohler on 10/28/16.
//  Copyright © 2016 JP Mohler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TwineIdentityMessage.h"
#import "TwineIdentityResult.h"

@interface TwineIdentityResultTests : XCTestCase

@end

@implementation TwineIdentityResultTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testJsonComposition {
    
    TwineIdentityResult *twineIdentityResult = [[TwineIdentityResult alloc] init];;
    
    twineIdentityResult.adId = @"";
    twineIdentityResult.lcEmailMD5 = @"";
    twineIdentityResult.lcEmailSHA1 = @"";
    twineIdentityResult.lcEmailSHA256 = @"";
    twineIdentityResult.lcPhoneMD5 = @"";
    twineIdentityResult.lcPhoneSHA1 = @"";
    twineIdentityResult.lcPhoneSHA256 = @"";
    twineIdentityResult.timePoint = @"";
    
    NSDictionary *jsonDict = [twineIdentityResult composeResult];
    
    NSMutableDictionary *testDict = [[NSMutableDictionary alloc] init]; // Don't always need this
    // Note you can't use setObject: forKey: if you are using NSDictionary
    [testDict setObject:@"" forKey:@"ai"];
    [testDict setObject:[[NSBundle mainBundle] bundleIdentifier] forKey:@"dv"];
    [testDict setObject:@"4" forKey:@"dt"];
    [testDict setObject:@"" forKey:@"es1"];
    [testDict setObject:@"" forKey:@"em5"];
    [testDict setObject:@"" forKey:@"es2"];
    [testDict setObject:@"" forKey:@"ps1"];
    [testDict setObject:@"" forKey:@"pm5"];
    [testDict setObject:@"" forKey:@"ps2"];
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
