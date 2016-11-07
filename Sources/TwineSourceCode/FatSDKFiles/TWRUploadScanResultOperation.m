//
//  Created by John Mohler on 6/20/16.
//  Copyright © 2016 The Wireless Registry. All rights reserved.
//

#import "TWRUploadScanResultOperation.h"
#import "TwineSignalManager.h"
#import "UIKit/UIKit.h"
#import "TWRBLEPeripheralResult.h"
#import "TWRScanResult.h"
#import "TwineUtil.h"

@interface TWRUploadScanResultOperation()

@property (nonatomic, strong) TWRScanResult *scanResult;
@property (nonatomic, strong) NSURL *uploadURL;
@property (nonatomic, strong) NSURLSessionConfiguration *urlSessionConfig;
@property (nonatomic, strong) NSMutableArray *failedUploads;

@end

@implementation TWRUploadScanResultOperation

- (instancetype)initWithUploadURL:(NSURL *)url scanResult:(TWRScanResult *)result {
    if (self = [super init]) {
        _uploadURL = url;
        _scanResult = result;
    }
    
    return self;
}

- (void)main {
    NSParameterAssert(self.uploadURL);
    
    self.urlSessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.urlSessionConfig.HTTPAdditionalHeaders = @{@"content-type" : @"application/json; charset=utf-8"};

    NSURLSession *session = [NSURLSession sessionWithConfiguration:self.urlSessionConfig];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:self.uploadURL];
    request.HTTPMethod = @"POST";
   
    NSData *jsonData = [self.scanResult resultJSON];
    if (!jsonData) {
        NSLog(@"No JSON data received");
        return;
    }
    
    if (![self isCancelled]) {
        __weak TWRUploadScanResultOperation *weakSelf = self;
        NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request
                                                                   fromData:jsonData
                                                          completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                              
                                                              if (error) {
                                                                  NSLog(@"Upload error: %@", [error localizedDescription]);
                                                                  [weakSelf.failedUploads addObject:weakSelf.scanResult];
                                                              } else {
                                                                
                                                                  NSMutableDictionary * innerJson = [NSJSONSerialization
                                                                                                     JSONObjectWithData:data options:kNilOptions error:&error];
                                                                  
                                                                  NSLog(@"%@", innerJson);
                                                                  NSLog(@"%@", response);

                                                                  if ([self isSuccessReturned:innerJson]) {
                                                                      
                                                                      [self broadCastResult];
                                                                      [self changeEndpoints:innerJson];
                                                                      
                                                                  }

                                                              }
                                                          }];
        
        [uploadTask resume];
    }
}

- (BOOL)isSuccessReturned:(NSMutableDictionary *) returnedDict {
    
    if ([returnedDict objectForKey:@"success"]) {

        if  ([[NSString stringWithFormat:@"%@", [returnedDict objectForKey:@"success"]]  isEqual: @"1"]) {
            return true;
        }
    }
    return false;
}

- (void)changeEndpoints:(NSMutableDictionary *) returnedDict {
    
    TwineUtil *util = [[TwineUtil alloc] init];
    [util changeEndpoints:returnedDict];
    
}

- (void)broadCastResult {
    
    [self assignResultPropertiesDefaultIfNil];
    
    NSString *latLongString = [NSString stringWithFormat:@"%@%@/%@%@", @"lat:", [self.scanResult.latitude stringValue], @"long", [self.scanResult.longitude stringValue]];
    NSArray *resultsArray = [NSArray arrayWithObjects: self.scanResult.deviceInfo, self.scanResult.appName, self.scanResult.idfa, self.scanResult.wifiSSID, self.scanResult.bleDevices, self.scanResult.scanTime, latLongString, nil];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:resultsArray forKey:@"Result"];
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"scanDone"
     object:self
     userInfo:userInfo];
    
    NSDate *date = [NSDate date];
    [[NSUserDefaults standardUserDefaults] setObject:date forKey:@"TWRSDKLastScanTime"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

- (void)assignResultPropertiesDefaultIfNil {

    if (self.scanResult.deviceInfo == nil) {
        self.scanResult.deviceInfo = @"";
    }
    if (self.scanResult.appName == nil) {
        self.scanResult.appName = @"";

    }
    if (self.scanResult.idfa == nil) {
        self.scanResult.idfa = @"";

    }
    if (self.scanResult.wifiSSID == nil) {
        self.scanResult.wifiSSID = @"";
    }
    if (self.scanResult.bleDevices == nil) {
        [self.scanResult addBleDevice:[[TWRBLEPeripheralResult alloc] initWithID:[[NSUUID alloc] initWithUUIDString:@"A5D59C2F-FE68-4BE7-B318-95029619C759"] name:@"test-signal-name" rssi:-1]];
    }
    if (self.scanResult.latitude == nil) {
        self.scanResult.latitude = [[NSNumber alloc] initWithDouble:0.0];
    }
    if (self.scanResult.longitude == nil) {
        self.scanResult.longitude = [[NSNumber alloc] initWithDouble:0.0];
    }

}


@end
