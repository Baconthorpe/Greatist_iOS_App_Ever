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
            NSLog(@"Parse User JSON Serialization Error: %@", error);
        }
        completionBlock(userDictionary[@"results"]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Parse Get User Error: %@",error);
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
        NSLog(@"Parse User Post Response Object: %@",responseObject);
        completion(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Parse User Post Error: %@",error);
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
        NSLog(@"Parse User Post Response Object: %@",responseObject);
        completion(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Parse User Post Error: %@",error);
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
            NSLog(@"Parse Get FriendPosts JSON Serialization Error: %@", error);
        }
        completionBlock(responseDictionary[@"result"]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Parse Get FriendPosts (Post) Error: %@",error);
    }];
    
    [newOp start];
}

- (void) getPostForPostID:(NSString *)postObjectID
           withCompletion:(void (^)(NSDictionary *))completion
{
    NSLog(@"%@", postObjectID);
    NSString *parsePostURL = [NSString stringWithFormat:@"https://api.parse.com/1/classes/GRTPost/%@", postObjectID];
    NSURL *url = [NSURL URLWithString:parsePostURL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:self.restAPIKey forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    [request addValue:self.appID forHTTPHeaderField:@"X-Parse-Application-Id"];
    
    AFHTTPRequestOperation *newOp = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    request.HTTPMethod = @"GET";
    
    [newOp setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error = nil;
        NSDictionary *postDictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        if (error) {
            NSLog(@"Parse Get Responses For Post JSON Serialization Error: %@", error);
        }
        completion(postDictionary);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Parse Get Responses For Post Error: %@",error);
    }];
    
    [newOp start];
}

- (void) postPostWithContent: (NSString *)content
                     section: (NSString *)section
                   responses: (NSString *)responseDictionaryString
              userFacebookID: (NSString *)userFacebookID
              withCompletion: (void (^)(NSDictionary *))completion
{

    NSString *parseDatabaseURL = @"https://api.parse.com/1/classes/GRTPost";
    NSURL *url = [NSURL URLWithString:parseDatabaseURL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:self.restAPIKey forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    [request addValue:self.appID forHTTPHeaderField:@"X-Parse-Application-Id"];
    
    AFHTTPRequestOperation *newOp = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    NSString *json = [NSString stringWithFormat:@"{\"userFacebookID\":\"%@\",\"content\":\"%@\",\"section\":\"%@\",\"responses\":\"%@\",\"isFlagged\":false}",userFacebookID,content,section,responseDictionaryString];
    
    request.HTTPBody = [json dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"POST";
    
    [newOp setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSLog(@"Parse Post Response: %@",responseDictionary);
        completion(responseDictionary);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Parse Post Response Error: %@",error);
    }];
    
    [newOp start];
}

- (void) flagPostID:(NSString *)postObjectID
{
    NSString *parsePostURL = [NSString stringWithFormat:@"https://api.parse.com/1/classes/GRTPost/%@", postObjectID];
    NSURL *url = [NSURL URLWithString:parsePostURL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:self.restAPIKey forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    [request addValue:self.appID forHTTPHeaderField:@"X-Parse-Application-Id"];
    
    AFHTTPRequestOperation *newOp = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    NSString *json = @"{\"isFlagged\":true}";
    request.HTTPBody = [json dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"PUT";
    
    [newOp setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Parse Flag successful. Update Post Response: %@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Parse Flag unsuccessful. Update Post Error:%@",error);
    }];
    
    [newOp start];
    
}

#pragma mark - GRTResponse Helper Methods

- (void) getValidResponsesWithCompletion:(void (^)(NSArray *))completion
{
    [self.manager GET:@"classes/GRTResponseOption" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSArray *responseDictionaries = responseObject[@"results"];
         completion(responseDictionaries);
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         NSLog(@"Parse Get Valid Responses Error: %@",error);
     }];
}




- (void) updatePostID:(NSString *)postObjectID
        withResponses:(NSString *)responseString
       withCompletion:(void (^)(NSString *))completion
{
    NSString *parsePostURL = [NSString stringWithFormat:@"https://api.parse.com/1/classes/GRTPost/%@", postObjectID];
    NSURL *url = [NSURL URLWithString:parsePostURL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:self.restAPIKey forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    [request addValue:self.appID forHTTPHeaderField:@"X-Parse-Application-Id"];
    
    AFHTTPRequestOperation *newOp = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    NSString *json = [NSString stringWithFormat:@"{\"responses\":\"%@\"}",responseString];
    request.HTTPBody = [json dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"PUT";
    
    [newOp setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        completion(responseDictionary[@"updatedAt"]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Parse Update Post Error:%@",error);
    }];
    
    [newOp start];
    
}

@end
