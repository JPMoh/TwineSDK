//
//  TWRBluetoothScanOperation.m
//
//
//  Created by John Mohler on 6/20/16.
//  Copyright © 2016 The Wireless Registry. All rights reserved.
//

#import "TWRBluetoothScanOperation.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "TWRBLEPeripheralResult.h"
#import <UIKit/UIKIt.h>
#import "TWRScanResult.h"

@interface TWRBluetoothScanOperation() <CBCentralManagerDelegate>

@property (assign) NSUInteger scanLength;

@property (nonatomic, strong) CBCentralManager *cbManager;

@end

@implementation TWRBluetoothScanOperation

- (instancetype)initWithResult:(TWRScanResult *)result scanTime:(NSUInteger)seconds {
    if (self = [super init]) {
        _result = result;
        _scanLength = seconds;
        _cbManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:nil];

    }
    
    return self;
}

-(void)main {
    @try {
        [NSThread sleepForTimeInterval:self.scanLength];
    }
    @catch (NSException *e) {
        NSLog(@"Error on TWRDeviceScanOperation: %@", e);
        self.result = nil;
    }
}

- (void)startBluetoothScan {
    NSLog(@"Bluetooth Scan Op started");

    NSArray *services = [NSArray arrayWithObjects:[CBUUID UUIDWithString:@"180A"], [CBUUID UUIDWithString:@"180D"], [CBUUID UUIDWithString:@"FEED"], [CBUUID UUIDWithString:@"FEEC"], [CBUUID UUIDWithString:@"FEDD"], [CBUUID UUIDWithString:@"FEDC"], [CBUUID UUIDWithString:@"FED0"], [CBUUID UUIDWithString:@"FED1"], [CBUUID UUIDWithString:@"FED2"], [CBUUID UUIDWithString:@"FED3"], [CBUUID UUIDWithString:@"FED4"], [CBUUID UUIDWithString:@"FEC7"], [CBUUID UUIDWithString:@"FEC8"], [CBUUID UUIDWithString:@"FEC9"], [CBUUID UUIDWithString:@"FECA"], [CBUUID UUIDWithString:@"FECB"], [CBUUID UUIDWithString:@"FECC"], [CBUUID UUIDWithString:@"FECD"], [CBUUID UUIDWithString:@"FECE"],[CBUUID UUIDWithString:@"FECF"], nil];

    if ([self runningInForeground]) {
        [self.cbManager scanForPeripheralsWithServices: nil options:nil];

    }
    else {
        [self.cbManager scanForPeripheralsWithServices: services options:nil];

    }
    
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
    }
}


-(BOOL) runningInForeground
{
    UIApplicationState state = [UIApplication sharedApplication].applicationState;
    return state == UIApplicationStateActive;
}

#pragma mark - CBCentralManagerDelegate

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    if (central.state < CBCentralManagerStatePoweredOn) {
        NSLog(@"BT is not on/ready");
        
    } else {
        [self startBluetoothScan];
    }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI {
    if (peripheral.name) {
        [self.result addBleDevice:[[TWRBLEPeripheralResult alloc] initWithID:peripheral.identifier name:peripheral.name rssi:[RSSI integerValue]]];
    }
}

- (void)stopScan:(id)sender {
    [self.cbManager stopScan];
}


@end
