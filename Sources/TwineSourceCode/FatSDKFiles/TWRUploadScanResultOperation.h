//
//  TWRUploadScanResultOperation.h
//  
//
//  Created by John Mohler on 6/20/16.
//  Copyright © 2016 The Wireless Registry. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TWRScanResult;

@interface TWRUploadScanResultOperation : NSOperation

- (instancetype)initWithUploadURL:(NSURL *)url scanResult:(TWRScanResult *)result;

@end
