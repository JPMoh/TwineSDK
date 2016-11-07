//
//  PostTask.h
//  TwineObjectiveCSDK
//
//  Created by John Mohler on 10/13/16.
//  Copyright © 2016 John Mohler. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface TwineUtil : NSObject

- (void)postJSON:(NSDictionary *)jsonDictionary endPoint:(NSString *)endPoint;
- (void)changeEndpoints:(NSMutableDictionary *)callBackDictionary;

- (NSString*)getEndpoint:(NSString*)endPoint preferencesKey:(NSString*)preferencesKey;
- (NSString *)getIDFA;
- (NSString *)isTracking;
- (NSString*)getToken;

@end
