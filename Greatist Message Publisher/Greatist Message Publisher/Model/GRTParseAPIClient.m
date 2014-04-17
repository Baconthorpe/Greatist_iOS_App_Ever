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

+ (instancetype)sharedClient {
    static GRTParseAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[GRTParseAPIClient alloc] init];
    });
    
    return _sharedClient;
}


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
        NSArray *relevantPosts = (NSArray *)responseObject;
        
        completion(relevantPosts);
    } failure:^(NSURLSessionDataTask *task, NSError *error)
    {
        NSLog(@"Posts Error: %@",error);
    }];
}

- (void) getValidResponsesWithCompletion:(void (^)(NSArray *))completion
{
    [self.manager GET:@"classes/GRTResponseOption" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSArray *responseDictionaries = responseObject[@"results"];
         completion(responseDictionaries);
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         NSLog(@"Responses Error: %@",error);
     }];
}

#pragma mark - POST Methods

- (void) postPostWithContent: (NSString *)content
                     section: (NSString *)section
                    latitude: (CGFloat)latitude
                   longitude: (CGFloat)longitude
                      userID: (NSString *)userID
              withCompletion: (void (^)(NSDictionary *))completion
{
    NSString *parseDatabaseURL = @"https://api.parse.com/1/classes/Post";
    NSURL *url = [NSURL URLWithString:parseDatabaseURL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:self.restAPIKey forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    [request addValue:self.appID forHTTPHeaderField:@"X-Parse-Application-Id"];
    
    AFHTTPRequestOperation *newOp = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    NSString *json = [NSString stringWithFormat:@"{\"UserID\":\"%@\",\"Content\":\"%@\",\"section\":\"%@\",\"latStamp\":%f,\"lonStamp\":%f}",userID,content,section,latitude,longitude];
    request.HTTPBody = [json dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"POST";
    
    [newOp setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Post Response: %@",responseObject);
        completion(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Post Response Error: %@",error);
    }];
    
    [newOp start];
}

- (void) postResponseWithContent: (NSString *)content
                       timeStamp: (NSDate *)timeStamp
                          userID: (NSString *)userID
                            post: (NSString *)post
{
    NSString *parseDatabaseURL = @"https://api.parse.com/1/classes/Response";
    NSURL *url = [NSURL URLWithString:parseDatabaseURL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:self.restAPIKey forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    [request addValue:self.appID forHTTPHeaderField:@"X-Parse-Application-Id"];
    
    AFHTTPRequestOperation *newOp = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    NSString *json = [NSString stringWithFormat:@"{\"Content\":\"%@\",\"timeStamp\":\"%@\",\"userID\":\"%@\",\"post\":\"%@\"}",content,timeStamp,userID,post];
    request.HTTPBody = [json dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"POST";
    
    [newOp setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Post Response: %@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Post Response Error: %@",error);
    }];
    
    [newOp start];

}

- (void) updatePostID:(NSString *)postObjectID
        WithResponses:(NSArray *)responseArray
{
    
    NSString *parsePostURL = [NSString stringWithFormat:@"https://api.parse.com/1/classes/GRTPost/%@", postObjectID];
    NSURL *url = [NSURL URLWithString:parsePostURL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:self.restAPIKey forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    [request addValue:self.appID forHTTPHeaderField:@"X-Parse-Application-Id"];
    
    AFHTTPRequestOperation *newOp = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    NSString *json = [NSString stringWithFormat:@"{\"responses\":\"%@\"}",responseArray];
    request.HTTPBody = [json dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"PUT";
    
    [newOp setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Update Post Response: %@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Update Post Error:%@",error);
    }];
    
    [newOp start];
    
}

- (void) getResponsesForPostID:(NSString *)postObjectID
{
    NSString *parsePostURL = [NSString stringWithFormat:@"https://api.parse.com/1/classes/GRTPost/%@", postObjectID];
    NSURL *url = [NSURL URLWithString:parsePostURL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:self.restAPIKey forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    [request addValue:self.appID forHTTPHeaderField:@"X-Parse-Application-Id"];
    
    AFHTTPRequestOperation *newOp = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    request.HTTPMethod = @"GET";
    
    [newOp setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *postDictionary = responseObject;
        NSArray *postResponses = postDictionary[@"responses"];
        NSLog(@"Get Responses: %@", postResponses);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Get Responses Error: %@",error);
    }];
    
    [newOp start];
}



#pragma mark - GRTUser Helper Methods

- (void)getUsersWithCompletion:(void (^)(NSArray *))completionBlock
{
    NSString *parseUserURL = [NSString stringWithFormat:@"https://api.parse.com/1/classes/GRTUser"];
    NSURL *url = [NSURL URLWithString:parseUserURL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:self.restAPIKey forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    [request addValue:self.appID forHTTPHeaderField:@"X-Parse-Application-Id"];
    
    AFHTTPRequestOperation *newOp = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    request.HTTPMethod = @"GET";
    
    [newOp setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id userObject) {
        NSError *error = nil;
        NSDictionary *userDictionary = [NSJSONSerialization JSONObjectWithData:userObject options:NSJSONReadingAllowFragments error:&error];
        if (error) {
            NSLog(@"User JSON Serialization Error: %@", error);
        }
        completionBlock(userDictionary[@"results"]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Get User Error: %@",error);
    }];
    
    [newOp start];
}

- (void) postUserWithFacebookID:(NSString *)fbookID
                     Completion:(void (^)(NSDictionary *))completion
{
    NSString *parseDatabaseURL = @"https://api.parse.com/1/classes/GRTUser";
    NSURL *url = [NSURL URLWithString:parseDatabaseURL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:self.restAPIKey forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    [request addValue:self.appID forHTTPHeaderField:@"X-Parse-Application-Id"];
    
    AFHTTPRequestOperation *newOp = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    NSString *json = [NSString stringWithFormat:@"{\"facebookID\":\"%@\"}",fbookID];
    request.HTTPBody = [json dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"POST";
    
    [newOp setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"User Post Response Object: %@",responseObject);
        completion(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"User Post Error: %@",error);
    }];
    
    [newOp start];
}

- (void) postUserWithName:(NSString *)name
               FacebookID:(NSString *)fbookID
               Completion:(void (^)(NSDictionary *))completion
{
    NSString *parseDatabaseURL = @"https://api.parse.com/1/classes/GRTUser";
    NSURL *url = [NSURL URLWithString:parseDatabaseURL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:self.restAPIKey forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    [request addValue:self.appID forHTTPHeaderField:@"X-Parse-Application-Id"];
    
    AFHTTPRequestOperation *newOp = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    NSString *json = [NSString stringWithFormat:@"{\"name\":\"%@\",\"facebookID\":\"%@\"}",name, fbookID];
    request.HTTPBody = [json dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"POST";
    
    [newOp setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"User Post Response Object: %@",responseObject);
        completion(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"User Post Error: %@",error);
    }];
    
    [newOp start];
}

#pragma mark - GRTPost Helper Methods

- (void) getPostsWithFriendIDs:(NSArray *)friendsArray
                WithCompletion:(void (^)(NSArray *))completionBlock
{
    NSString *friendsArrayString = [friendsArray componentsJoinedByString:@"\",\""];
    
    NSString *parseFriendPostsURL = @"https://api.parse.com/1/functions/friendPosts";
    NSURL *url = [NSURL URLWithString:parseFriendPostsURL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:self.restAPIKey forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    [request addValue:self.appID forHTTPHeaderField:@"X-Parse-Application-Id"];
    
    AFHTTPRequestOperation *newOp = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    NSString *json = [NSString stringWithFormat:@"{\"facebook_ids_array\":[\"%@\"]}",friendsArrayString];
    request.HTTPBody = [json dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"POST";
    
    [newOp setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error = nil;
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        if (error) {
            NSLog(@"FriendPosts JSON Serialization Error: %@", error);
        }
        completionBlock(responseDictionary[@"result"]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"FriendPosts (Post) Error: %@",error);
    }];
    
    [newOp start];
}

@end
