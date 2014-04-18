//
//  GRTDataManager.h
//  Greatist Message Publisher
//
//  Created by Leonard Li on 4/16/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GRTParseAPIClient.h"
#import "GRTFacebookAPIClient.h"
#import "GRTDataStore.h"

@interface GRTDataManager : NSObject
@property (strong, nonatomic) GRTParseAPIClient *parseAPIClient;
@property (strong, nonatomic) GRTFacebookAPIClient *facebookAPIClient;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) GRTDataStore *dataStore;

// Init Methods
+ (instancetype)sharedManager;
- (instancetype)init;
- (instancetype)initWithParseAPIClient:(GRTParseAPIClient *)parseClient
                     FacebookAPIClient:(GRTFacebookAPIClient *)facebookClient
                  ManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
                             DataStore:(GRTDataStore *)dataStore;
- (void) getInitialData;

// User Methods
- (User *) getCurrentUser;
- (void) setCurrentUser:(User *)user;
- (void) fetchUsersWithCompletion:(void (^)(NSArray *users))completionBlock;
- (void) createNewUserWithFacebookID:(NSString *)facebookIDString;

// Post Methods
- (void) getPostsBasedOnFacebookID;

- (void) getPostsBasedOnFacebookFriends;
- (void) postPostAndSaveIfSuccessfulForContent: (NSString *)content
                                     inSection: (Section *)section;
// Response Methods
- (void) getValidResponses;

@end
