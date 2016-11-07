//
//  TWRManager.h
//  
//
//  Created by John Mohler on 6/20/16.
//  Copyright © 2016 The Wireless Registry. All rights reserved.
//
//  TWRManager manages all Wireless Registry SDK activities.
//  Only one manager will ever run in an app, use the sharedManager to get a reference to it.
//  You MUST configure a manager with a token and app name before calling a scan.
//

#import <Foundation/Foundation.h>

@interface TwineSignalManager : NSObject

@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *appName;
@property (nonatomic, assign) BOOL allowLocationScan;

/*
 *  @return reference to shared TWRManager used by the app
 */
+ (instancetype)sharedManager;

/*
 *  You MUST provide a WR issued token prior to scanning. This token is used when reporting results to WR.
 *  @param  token   provide your token from your Wireless Registry representative
 *  @param  appName provide the unique app bundle id (e.g., com.wirelessregisty.exampleapp)
 */
- (void)configureWithToken:(NSString *)token appName:(NSString *)appName;

/*
 *  Starts TWR SDK with periodic scans based on location changes
 *  @warning    manager must be configured with a token and app name prior to calling start
 */

/*
 *  Triggers a WR scan
 *  @warning    manager must be configured with a token and app name prior to scanning
 */
- (void)stopUpdating;
- (void)scanNow;

/*
 *  Triggers a WR scan and reports the user's location as provided
 *  @param  latitude    user's latitude at start of scan
 *  @param  longitude   user's longitude at start of scan
 *  @warning    manager must be configured with a token and app name prior to scanning
 */

@end
