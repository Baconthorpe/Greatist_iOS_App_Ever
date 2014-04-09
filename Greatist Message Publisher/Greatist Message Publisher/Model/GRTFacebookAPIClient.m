//
//  GRTFacebookAPI.m
//  Greatist Message Publisher
//
//  Created by Leonard Li on 4/9/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "GRTFacebookAPIClient.h"

@implementation GRTFacebookAPIClient

+ (void)facebookLoginWithCompletion:(void (^)(NSArray *facebookFriends))completion
{
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook];
    
    NSDictionary *options = @{
                              ACFacebookAppIdKey:@"382299055241534",
                              ACFacebookPermissionsKey: @[@"email", @"read_friendlists", @"basic_info"],
                              ACFacebookAudienceKey:ACFacebookAudienceFriends
                              };
    
    [accountStore requestAccessToAccountsWithType:accountType
                                               options:options completion:^(BOOL granted, NSError *error) {
       if (granted)
       {
           NSLog(@"Permission Granted");
           NSArray *accounts = [accountStore accountsWithAccountType:accountType];
           
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
                   NSLog(@"name: %@", friend[@"id"]);
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
