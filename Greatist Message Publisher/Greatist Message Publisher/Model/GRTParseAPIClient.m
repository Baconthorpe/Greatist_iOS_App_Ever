//
//  GRTParseAPIClient.m
//  Greatist Message Publisher
//
//  Created by Ezekiel Abuhoff on 4/9/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "GRTParseAPIClient.h"
#import "AFNetworking.h"

@interface GRTParseAPIClient ()

@property (strong, nonatomic) AFHTTPSessionManager *manager;
@property (strong, nonatomic) NSString *baseURLString;
@property (strong, nonatomic) NSString *restAPIKey;
@property (strong, nonatomic) NSString *appID;

@end

@implementation GRTParseAPIClient

#pragma mark - Lazy Instantiation

- (NSString *) baseURLString
{
    return @"https://api.parse.com/1/";
}

- (NSString *) restAPIKey
{
    return @"74yK4IEW4G3bbWu8DCZ2ZOxhzXZnshMBvjq79OPG";
}

- (NSString *) appID
{
    return @"K10PcfKibqynmF6Z2LMsmlZGCzrvEki1HNxj5g6f";
}

- (AFHTTPSessionManager *) manager
{
    if (!_manager)
    {
        _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:self.baseURLString]];
        _manager.requestSerializer=[AFHTTPRequestSerializer serializer];
        
        [_manager.requestSerializer setValue:self.restAPIKey forHTTPHeaderField:@"X-Parse-REST-API-Key"];
        [_manager.requestSerializer setValue:self.appID forHTTPHeaderField:@"X-Parse-Application-Id"];
    }
    
    return _manager;
}

#pragma mark - GET Methods

- (void) getRelevantPostsWithCompletion:(void (^)(NSArray *))completion
{
    [self.manager GET:@"classes/Post" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
    {
        NSLog(@"%@",responseObject);
        
        NSArray *relevantPosts = (NSArray *)responseObject;
        
        completion(relevantPosts);
    } failure:^(NSURLSessionDataTask *task, NSError *error)
    {
        NSLog(@"%@",error);
    }];
}

#pragma mark - POST Methods

@end
