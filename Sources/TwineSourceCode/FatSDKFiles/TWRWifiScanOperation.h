//
//  TWRWifiScanOperation.h
//  
//
//  Created by John Mohler on 6/20/16.
//  Copyright © 2016 The Wireless Registry. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TWRScanResult;

@interface TWRWifiScanOperation : NSOperation

@property (nonatomic, strong) TWRScanResult *result;

-(instancetype)initWithResult:(TWRScanResult *)result;


@end
