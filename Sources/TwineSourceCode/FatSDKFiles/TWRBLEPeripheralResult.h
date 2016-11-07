//
//  TWRBLEPeripheralResult.h
//  
//
//  Created by John Mohler on 6/20/16.
//  Copyright © 2016 The Wireless Registry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TWRBLEPeripheralResult : NSObject

@property(nonatomic, assign) NSInteger RSSI;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, strong) NSUUID *identifier;

- (instancetype)initWithID:(NSUUID *)identifier name:(NSString *)name rssi:(NSInteger)RSSI;

@end
