//
//  LocationManager.h
//  TwineObjectiveCSDK
//
//  Created by John Mohler on 10/14/16.
//  Copyright © 2016 John Mohler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TwineScanManager : NSObject

extern NSString * const twineLocationURL;
extern NSString * const twineDeviceURL;
extern NSString * const twineLocationPreferencesKey;
extern NSString * const twineDevicePreferencesKey;


    /*
     *  URL to upload scan results to at WR
     */

+ (instancetype)sharedManager;

    /*
     *  @return reference to the app's single scan manager
     */
- (void)sendDevice;
- (void)sendLocationIfNoRecentScans:(double)latitude longitude:(double)longitude horizontalAccuracy:(double)horizontalAccuracy;
- (void)sendDeviceCharacteristicsIfNoRecentScans;
- (BOOL)runningInForeground;
- (void)stopUpdating;
    /*
     *  @returns TRUE if a scan is currently in progress
     */
    
- (void)sendLocation:(double)latitude longitude:(double)longitude horizontalAccuracy:(double)horizontalAccuracy;

    /*
     * @checks NSUserDefaults for time of previous post.  If time difference between then and now exceeds 15 minutes scan is called from shared instance of TWRManager.
     */
    
    @end
