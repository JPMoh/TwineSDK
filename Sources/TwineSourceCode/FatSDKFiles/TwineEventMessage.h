//
//  EventMessage.h
//  TwineObjectiveCSDK
//
//  Created by John Mohler on 10/14/16.
//  Copyright © 2016 John Mohler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TwineEventMessage;

@interface TwineEventMessage : NSObject

extern NSString * const twineEventURL;
extern NSString * const twineEventPreferencesKey;


-(void)send:(NSString*)event detail:(NSString*)detail;

@end
