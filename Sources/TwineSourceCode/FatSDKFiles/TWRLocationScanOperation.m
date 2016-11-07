//
//  TWRLocationScanOperation.m
//  ObserverAppWithFiles
//
//  Created by John Mohler on 6/20/16.
//  Copyright © 2016 The Wireless Registry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TWRLocationScanOperation.h"
#import <CoreLocation/CoreLocation.h>
#import "TWRBLEPeripheralResult.h"
#import "TWRScanResult.h"

@interface TWRLocationScanOperation() <CLLocationManagerDelegate>

@property (assign) NSUInteger scanLength;

@property (nonatomic, strong) CLLocationManager *clManager;

@end

@implementation TWRLocationScanOperation

- (instancetype)initWithResult:(TWRScanResult *)result scanTime:(NSUInteger)seconds {
    if (self = [super init]) {
        _result = result;
        _scanLength = seconds;
        _clManager = [[CLLocationManager alloc] init];
    }
    
    return self;
}

-(void)main {
    @try {
        [self startLocationScan];
        [NSThread sleepForTimeInterval:self.scanLength];
    }
    @catch (NSException *e) {
        NSLog(@"Error on TWRDeviceScanOperation: %@", e);
        self.result = nil;
    }
}

- (void)startLocationScan {
    NSLog(@"Location Scan Op started");
    self.clManager.delegate = self;
    self.clManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.clManager requestAlwaysAuthorization];
    [self.clManager startUpdatingLocation];
    
    NSTimer *stopTimer = [NSTimer timerWithTimeInterval:self.scanLength
                                                 target:self
                                               selector:@selector(stopScan:)
                                               userInfo:nil
                                                repeats:NO];
    [[NSRunLoop mainRunLoop] addTimer:stopTimer forMode:NSDefaultRunLoopMode];
}

-(void)keepAliveMain:(NSTimer *)timer {
    NSLog(@"keep alive timer");
    if ([self isCancelled]) {
        NSLog(@"cancelled, we should do something");
    }
}

#pragma mark - CBCentralManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        self.result.latitude = [[NSNumber alloc] initWithDouble:currentLocation.coordinate.latitude];
        self.result.longitude = [[NSNumber alloc] initWithDouble:currentLocation.coordinate.longitude];
    }
    
    // Stop Location Manager
    [self.clManager stopUpdatingLocation];
    
}

- (void)stopScan:(id)sender {
    NSLog(@"stopScan fired");
    [self.clManager stopUpdatingLocation];
}

@end
