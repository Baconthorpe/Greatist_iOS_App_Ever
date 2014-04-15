//
//  GRTFacebookAPI.m
//  Greatist Message Publisher
//
//  Created by Leonard Li on 4/9/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "GRTFacebookAPIClient.h"
#import <FacebookSDK/FacebookSDK.h>
#import "GRTFacebookLoginViewController.h"

@interface GRTFacebookAPIClient ()
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


#pragma mark - Facebook Login Helper Methods

- (BOOL)isUserFacebookCached
{
    if ([FBSession activeSession].state == FBSessionStateCreatedTokenLoaded) {
        return YES;
    }
    return NO;
}

- (void)verifyUserFacebookCachedInViewController:(UIViewController *)parentVC
{
    // Whenever a person opens the app, check for a cached session
    if ([FBSession activeSession].state == FBSessionStateCreatedTokenLoaded) {
        
        // If there's one, just open the session silently, without showing the user the login UI
        [FBSession openActiveSessionWithReadPermissions:@[@"basic_info"]
                                           allowLoginUI:NO
                                      completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
                                          // Handler for session state changes
                                          // This method will be called EACH time the session state changes,
                                          // also for intermediate states and NOT just when the session open
                                          //[self sessionStateChanged:session state:state error:error];
                                      }];
    }
    else
    {
        GRTFacebookLoginViewController *facebookLoginVC = [[GRTFacebookLoginViewController alloc] init];
        [parentVC presentViewController:facebookLoginVC animated:NO completion:nil];
    }
}


#pragma mark - Facebook Friend Methods

- (void)getFriendIDsWithCompletion:(void(^)(NSArray *))completion
{
    FBRequest* friendsRequest = [FBRequest requestWithGraphPath:@"me/friends" parameters:nil HTTPMethod:@"GET"];
    [friendsRequest startWithCompletionHandler: ^(FBRequestConnection *connection,
                                                  NSDictionary* result,
                                                  NSError *error) {
        NSArray* friends = [result objectForKey:@"data"];
        NSLog(@"Found: %lu friends", (unsigned long)friends.count);
        
        NSMutableArray *friendIDs = [NSMutableArray new];
        
        for (NSDictionary<FBGraphUser>* friend in friends) {
            //NSLog(@"I have a friend named %@ with id %@", friend.name, friend.id);
            [friendIDs addObject:friend.id];
        }
        
        completion(friendIDs);
    }];
}

@end
