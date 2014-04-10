//
//  GRTGreatistAPIClient.m
//  Greatist Message Publisher
//
//  Created by Elizabeth Choy on 4/10/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "GRTGreatistAPIClient.h"
#import <AFNetworking/AFNetworking.h>
#import <NSData+Base64/NSData+Base64.h>

@interface GRTGreatistAPIClient ()
@property (nonatomic) AFHTTPSessionManager *sessionManager;

@end

@implementation GRTGreatistAPIClient

const NSString *clientID = @"3g890ydsg980yseg984qgabe4343";
const NSString *secret = @"awronatvw49nbveaspn08besy5p98ynavtbn3t78oa5u";
const NSString *accessToken= @"Basic token_encoded";

- (NSString *)accessToken
{
    if (!accessToken) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        accessToken = [defaults objectForKey:@"Basic token_encoded"];
    }
    return accessToken;
}

- (AFHTTPSessionManager *)sessionManager
{
    if (!_sessionManager) {
        _sessionManager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:@" http://greatist.com"]];
    }
    return _sessionManager;
}

- (void) getAccessTokenWithCompletion:(void (^)(NSDictionary *))completion
{
    NSString *urlString = [NSString stringWithFormat:@"/oauth2/token"];
    
    NSString *clientIDWithSecret = [NSString stringWithFormat:@"%@:%@",clientID, secret];
    NSData *data = [NSData dataFromBase64String:clientIDWithSecret];
    NSString *convertedString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    return [self.sessionManager GET:urlString
                         parameters:nil
                            success:^(NSURLSessionDataTask *task, id responseObject)
    {
                                if ([responseObject isKindOfClass:[NSArray class]])
                                {
                                NSArray *responseArray = responseObject;
                                    completion(responseArray);
                                }
                            }
                            failure:^(NSURLSessionDataTask *task, NSError *error) {
                                NSLog(@"%@",error);
                            }];

}

- (NSURLSessionDataTask *)getArticlesWithCompletion:(void (^)(NSArray *))completion
{
    NSString *urlString = [NSString stringWithFormat:@"/oauth2/token=%@", accessToken];
    
    NSData *data = [NSData dataFromBase64String:urlString];
    NSString *convertedString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    return [self.sessionManager GET:urlString
                         parameters:nil
                            success:^(NSURLSessionDataTask *task, id responseObject) {
                                if ([responseObject isKindOfClass:[NSArray class]]) {
                                    NSArray *responseArray = responseObject;
                                    completion(responseArray);
                                }
    }
                            failure:^(NSURLSessionDataTask *task, NSError *error) {
                                NSLog(@"%@",error);
                            }];
}



@end
