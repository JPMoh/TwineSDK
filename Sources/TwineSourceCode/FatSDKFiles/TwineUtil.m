

#import "UIKit/UIKit.h"
#import "TwineUtil.h"
#import <AdSupport/AdSupport.h>
#import <sys/utsname.h>


@interface TwineUtil()
    
    @property (nonatomic, strong) NSURLSessionConfiguration *urlSessionConfig;
    @property (nonatomic, strong) NSMutableArray *failedUploads;

    @end

@implementation TwineUtil
    
    - (void)postJSON:(NSDictionary *)jsonDictionary endPoint:(NSString *)endPoint {
    
        NSLog(@"starting post");
        NSLog(@"jsonDictionary: %@", jsonDictionary);

    self.urlSessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];

    NSError *error = nil;
    NSURL *url = [[NSURL alloc] initWithString:endPoint];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary options:NSJSONWritingPrettyPrinted error:&error];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:self.urlSessionConfig];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        
    
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:[self getToken] forHTTPHeaderField:@"x-api-key"];
    request.HTTPMethod = @"POST";

    NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request
                                                                   fromData:jsonData
                                                          completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                              if (error) {
                                                                  NSLog(@"Upload error: %@", [error localizedDescription]);
                                                                  NSLog(@"%@", response);

                                                              } else {
                                                                  NSMutableDictionary * innerJson = [NSJSONSerialization
                                                                                                     JSONObjectWithData:data options:kNilOptions error:&error];
                                                                  
                                                                  NSLog(@"%@", response);
                                                                  NSLog(@"%@", innerJson);

                                                                  
                                                              }
                                                          }];
        
        [uploadTask resume];
    
}
    
    - (NSString *)getIDFA {
        if(![[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]){
            return @"DO NOT TRACK";
        }
        
        NSUUID *advertisingIdentifier = [[ASIdentifierManager sharedManager] advertisingIdentifier];
        return advertisingIdentifier.UUIDString;
    }

- (NSString *)isTracking {
    if(![[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]){
        return @"1";
    }
    
    return @"0";
}


- (NSString*)getToken {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = @"";

    NSLog(@"getToken called");

    if ([defaults objectForKey:@"twineToken"] != nil) {
        
        NSLog(@"not nil");

        if([[defaults objectForKey:@"twineToken"] isKindOfClass:[NSString class]]) {
            
            NSLog(@"getToken token set");
            token = [defaults objectForKey:@"twineToken"];
        }
    }
    
    return token;
}

- (NSString*)getEndpoint:(NSString*)endPoint preferencesKey:(NSString*)preferencesKey {
    
    NSString* returnedEndPoint = endPoint;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults objectForKey:preferencesKey] != nil) {
        
        if([[defaults objectForKey:preferencesKey] isKindOfClass:[NSString class]]) {
            
            returnedEndPoint = [defaults objectForKey:preferencesKey];
            
        }
        
    }
    
    return returnedEndPoint;
}

- (void)changeEndpoints:(NSMutableDictionary *)callBackDictionary {
    
    NSArray *endpointKeyArray =  [[NSArray alloc] initWithObjects:@"behavioralEndpoint",@"dHHCEndpoint",@"demographicsEndpoint",
                     @"identityEndpoint",@"locationEndpoint",nil];

    if ([callBackDictionary objectForKey:@"settings"]) {
        
        if([callBackDictionary[@"settings"] isKindOfClass:[NSDictionary class]]){
            
            NSDictionary *settingsDictionary = callBackDictionary[@"settings"];
            
            for (NSString* endPointKey in endpointKeyArray) {

            if ([settingsDictionary objectForKey:endPointKey]) {
                
                if([settingsDictionary[endPointKey] isKindOfClass:[NSString class]]){
                    
                    NSString *endPoint = settingsDictionary[endPointKey];
                    [[NSUserDefaults standardUserDefaults] setObject:endPoint forKey:endPointKey];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                
            }
            }
            
        }
        }
    }

}


    @end
