//
//  TWRDeviceScanOperation.h
//  wrScout
//
//  Created by Tony Lenzi on 4/12/16.
//  Copyright © 2016 Tacit Mobile. All rights reserved.
//
//  Gathers basic information about the device including IDFA, name, OS version, device type
//

#import <Foundation/Foundation.h>

@class TWRScanResult;

@interface TWRDeviceScanOperation : NSOperation

@property (strong) TWRScanResult *result;

- (instancetype)initWithResult:(TWRScanResult *)result;

@end
