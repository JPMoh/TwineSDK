//
//  TWRScanManager.h
//  
//
//  Created by John Mohler on 6/20/16.
//  Copyright © 2016 The Wireless Registry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TWRScanManager : NSObject

/*
 *  URL to upload scan results to at WR
 */

@property (nonatomic, strong) NSURL *uploadURL;

/*
 *  @return reference to the app's single scan manager
 */

+ (instancetype)sharedManager;

/*
 *  @returns TRUE if a scan is kicked off, FALSE if we can't scan right now
 */


- (void)scan;

/*
 *  @returns TRUE if a scan is currently in progress
 */

- (void)stopUpdating;

- (BOOL)isScanning;

/*
 * @checks NSUserDefaults for time of previous post.  If time difference between then and now exceeds 15 minutes scan is called from shared instance of TWRManager.
 */

- (void)scanIfNoRecentScans;

@end
