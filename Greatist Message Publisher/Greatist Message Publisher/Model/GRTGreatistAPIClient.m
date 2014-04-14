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
@property (strong,nonatomic)  NSString *accessToken;


@end

@implementation GRTGreatistAPIClient

const NSString *clientID = @"3g890ydsg980yseg984qgabe4343";
const NSString *secret = @"awronatvw49nbveaspn08besy5p98ynavtbn3t78oa5u";



//- (NSString *)accessToken
//{
//    if (!accessToken) {
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        accessToken = [defaults objectForKey:@"Basic token_encoded"];
//    }
//    return accessToken;
//}

- (AFHTTPSessionManager *)sessionManager
{
    if (!_sessionManager) {
        _sessionManager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:@" http://greatist.com"]];
    }
    return _sessionManager;
}

//- (void) postForAccessTokenWithCompletion:(void (^)(NSDictionary *))completion
//{
//    NSString *greatistURL = @"http://greatist.com/oauth2/token";
//    NSURL *url = [NSURL URLWithString:greatistURL];
//    
//    NSString *clientIDWithSecret = [NSString stringWithFormat:@"%@:%@",clientID, secret];
//    NSData *data = [NSData dataFromBase64String:clientIDWithSecret];
//    NSString *convertedString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    
//    AFHTTPRequestOperationManager *opManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
//    
//    [opManager.requestSerializer setValue:convertedString forHTTPHeaderField:@"Authorization"];
//    
//    [opManager POST:@"" parameters:@{@"grant_type": @"client_credentials"} success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@",responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@",error);
//    }];
//}

- (void) postForAccessTokenWithCompletion:(void (^)(NSDictionary *))completion
{
    NSString *greatistURL = @"http://greatist.com/oauth2/token";
    NSURL *url = [NSURL URLWithString:greatistURL];
    
    NSString *clientIDWithSecret = [NSString stringWithFormat:@"%@:%@",clientID, secret];
    NSData *data = [NSData dataFromBase64String:clientIDWithSecret];
    NSString *convertedString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    AFHTTPRequestOperationManager *opManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
    
    [opManager.requestSerializer setValue:convertedString forHTTPHeaderField:@"Authorization"];
    
    convertedString = @"Basic M2c4OTB5ZHNnOTgweXNlZzk4NHFnYWJlNDM0Mzphd3JvbmF0dnc0OW5idmVhc3BuMDhiZXN5NXA5 OHluYXZ0Ym4zdDc4b2E1dQ==";
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL: [NSURL URLWithString:@"http://greatist.com/oauth2/token"]];
    
    [manager.requestSerializer setValue:convertedString forHTTPHeaderField:@"Authorization"];
    
    [manager POST:@"" parameters:@{@"grant_type":@"client_credentials"} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSLog(@"This is a dictionary?");
            self.accessToken = responseObject[@"access_token"];
            NSLog(@"%@", self.accessToken);
            
            completion(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)getArticlesWithCompletion:(void (^)(NSDictionary *))completion
{    
    NSString *key = [NSString stringWithFormat:@"Bearer %@",self.accessToken];
    
//    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:@"http://greatist.com/api/articles_since?"]];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    
    [manager.requestSerializer setValue:key forHTTPHeaderField:@"Authorization"];
    [manager GET:@"http://greatist.com/api/articles_since?"
      parameters: nil
         success:^(NSURLSessionDataTask *task, id responseObject) {
             if ([responseObject isKindOfClass:[NSDictionary class]])
             {
                 NSDictionary *responseDictionary = responseObject;
                 completion(responseDictionary);
                 NSLog(@"%@",responseDictionary);
                            }
         } failure:^(NSURLSessionDataTask *task, NSError *error) {
             NSLog(@"%@",error);
         }];
}

- (void)retrieveArticlesWithCompletion:(void (^)(NSDictionary *))completion
{
    [self postForAccessTokenWithCompletion:^(NSDictionary *tokenDictionary) {
        [self getArticlesWithCompletion:^(NSDictionary *articlesDictionary) {
            completion(articlesDictionary);
        }];
    }];
}



@end
