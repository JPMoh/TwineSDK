
#import <XCTest/XCTest.h>
#import "UIKit/UIKit.h"
#import <Foundation/Foundation.h>
#import "TwineLocationManager.h"
#import "TwineUtil.h"

@interface TwineUtilTests : XCTestCase
@property (nonatomic, strong) NSURLSessionConfiguration *urlSessionConfig;

@end

@implementation TwineUtilTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) createMockDeviceResultObject {
    
}

- (void) createMockDemographicsResultObject {
    
}
- (void) createMockEventResultObject {
    
}
- (void) createMockIdentityResultObject {
    
}
- (void) testCreateMockLocationResultObject {
       
    NSMutableDictionary *testDict = [[NSMutableDictionary alloc] init]; // Don't always need this
    // Note you can't use setObject: forKey: if you are using NSDictionary
    [testDict setObject:@"" forKey:@"ai"];
    [testDict setObject:[[NSBundle mainBundle] bundleIdentifier] forKey:@"dv"];
    [testDict setObject:@"4" forKey:@"dt"];
    [testDict setObject:@"" forKey:@"la"];
    [testDict setObject:@"" forKey:@"ln"];
    [testDict setObject:@"fn" forKey:@"lm"];
    [testDict setObject:@"" forKey:@"ha"];
    [testDict setObject:@"" forKey:@"lt"];
    [testDict setObject:@"" forKey:@"ts"];

    TwineUtil *util = [[TwineUtil alloc] init];

    NSString* endPoint = [util getEndpoint:twineLocationURL preferencesKey:twineLocationPreferencesKey];
    [self postJSON:testDict endPoint:endPoint];

}

- (void)postJSON:(NSDictionary *)jsonDictionary endPoint:(NSString *)endPoint {

    
    XCTAssertEqualObjects(endPoint, @"https://28ull615gk.execute-api.us-west-2.amazonaws.com/dev");

    self.urlSessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSError *error = nil;
    NSURL *url = [[NSURL alloc] initWithString:endPoint];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary options:NSJSONWritingPrettyPrinted error:&error];
   NSURLSession *session = [NSURLSession sessionWithConfiguration:self.urlSessionConfig];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"0Trxr8UTuo44lJbVIlfTp7RYGemeqqkoa40LG3JB" forHTTPHeaderField:@"x-api-key"];
    request.HTTPMethod = @"POST";
    
    NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request
                                                               fromData:jsonData
                                                      completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

                                                          NSMutableDictionary * innerJson = [[NSMutableDictionary alloc] init];
                                                          if (error) {
                                                              NSLog(@"Upload error: %@", [error localizedDescription]);
                                                              NSLog(@"%@", response);
                                                              
                                                          } else {
                                                              innerJson = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                                              
                                                              NSURLResponse* response = response;
                                                              NSDictionary* headers = [(NSHTTPURLResponse *)response allHeaderFields];
                                                              NSLog(@"Headers dictionary %@", headers);
                                                              NSLog(@"%@", response);
                                                              NSLog(@"%@", innerJson);
                                                              
                                                          }

                                                      }];
    
    [uploadTask resume];
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end






