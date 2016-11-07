//
//  TWRBLEPeripheralResult.m
//  
//
//  Created by John Mohler on 6/20/16.
//  Copyright © 2016 The Wireless Registry. All rights reserved.
//

#import "TWRBLEPeripheralResult.h"

@implementation TWRBLEPeripheralResult

- (instancetype)initWithID:(NSUUID *)identifier name:(NSString *)name rssi:(NSInteger)RSSI {
    self = [super init];
    if (self) {
        _identifier = identifier;
        _name = name;
        _RSSI = RSSI;
    }
    
    return self;
}

@end


