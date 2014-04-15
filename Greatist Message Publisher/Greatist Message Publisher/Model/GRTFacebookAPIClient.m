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

- (ACAccountStore *)accountStore
{
    if (!_accountStore)
    {
        _accountStore = [[ACAccountStore alloc] init];
    }
    
    return _accountStore;
}

// Should probably be refactored as an instance method with accountStore as a property
- (void)facebookLoginWithCompletion:(void (^)(NSArray *facebookFriends))completion
{
    self.accountStore = [[ACAccountStore alloc] init];
    
    ACAccountType *accountType = [self.accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook];
    
    NSDictionary *options = @{
                              ACFacebookAppIdKey:@"382299055241534",
                              ACFacebookPermissionsKey: @[@"email", @"read_friendlists", @"basic_info"],
                              ACFacebookAudienceKey:ACFacebookAudienceFriends
                              };
    
    [self.accountStore requestAccessToAccountsWithType:accountType
                                               options:options completion:^(BOOL granted, NSError *error) {
                                                   if (granted)
                                                   {
                                                       NSLog(@"Permission Granted");
                                                       NSArray *accounts = [self.accountStore accountsWithAccountType:accountType];
                                                       
                                                       ACAccount *fbaccount = (ACAccount *)[accounts lastObject];
                                                       
                                                       SLRequest *friendsListRequest = [SLRequest requestForServiceType:SLServiceTypeFacebook
                                                                                                          requestMethod:SLRequestMethodGET
                                                                                                                    URL:[[NSURL alloc] initWithString:@"https://graph.facebook.com/me/friends"] parameters:nil];
                                                       friendsListRequest.account = fbaccount;
                                                       [friendsListRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                                                           
                                                           // Parse response JSON
                                                           NSError *jsonError = nil;
                                                           NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseData
                                                                                                                options:NSJSONReadingAllowFragments
                                                                                                                  error:&jsonError];
                                                           NSMutableArray *fetchedFriends = [NSMutableArray new];
                                                           for (NSDictionary *friend in data[@"data"]) {
                                                               [fetchedFriends addObject:friend[@"id"]];
                                                           }
                                                           completion(fetchedFriends);
                                                       }];
                                                       
                                                   }
                                                   else
                                                   {
                                                       NSLog(@"Permission denied");
                                                       NSLog(@"%@", error);
                                                   }
                                               }];
}

@end
