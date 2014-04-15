//
//  GRTFacebookAPI.m
//  Greatist Message Publisher
//
//  Created by Leonard Li on 4/9/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "GRTFacebookAPIClient.h"
#import <FacebookSDK/FacebookSDK.h>

@interface GRTFacebookAPIClient ()

@property (strong, nonatomic) ACAccountStore *accountStore;
@end

@implementation GRTFacebookAPIClient

+ (instancetype)sharedClient {
    static GRTFacebookAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[GRTFacebookAPIClient alloc] init];
    });
    
    return _sharedClient;
}

- (void)getFriendIDsWithCompletion:(void(^)(NSArray *))completion
{
    FBRequest* friendsRequest = [FBRequest requestWithGraphPath:@"me/friends" parameters:nil HTTPMethod:@"GET"];
    [friendsRequest startWithCompletionHandler: ^(FBRequestConnection *connection,
                                                  NSDictionary* result,
                                                  NSError *error) {
        NSArray* friends = [result objectForKey:@"data"];
        NSLog(@"Found: %i friends", friends.count);
        
        NSMutableArray *friendIDs = [NSMutableArray new];
        
        for (NSDictionary<FBGraphUser>* friend in friends) {
            //NSLog(@"I have a friend named %@ with id %@", friend.name, friend.id);
            [friendIDs addObject:friend.id];
        }
        
        completion(friendIDs);
    }];
}

@end
