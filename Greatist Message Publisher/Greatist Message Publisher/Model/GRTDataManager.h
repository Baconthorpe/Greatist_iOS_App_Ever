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
- (void) getUsersWithCompletion:(void (^)(NSArray *users))completionBlock;
- (void) createNewUserWithFacebookID:(NSString *)facebookIDString
                      withCompletion:(void (^)(BOOL isSuccessful))completion;

// Post Methods
- (void) getPostsBasedOnFacebookFriends;
- (void) postPostAndSaveIfUnique: (NSString *)content
                       inSection: (Section *)section
                   withResponses: (NSString *)responseDictionaryString
                  withCompletion: (void (^)(NSDictionary *postResponse))completion;
- (void) flagPost:(Post *)post;

// Response Methods
- (void) getValidResponses;
- (void) getUpdatedResponsesForPostID:(NSString *)postObjectID
                       withCompletion:(void (^)(NSDictionary *postDictionary))completion;
- (void) incrementResponse:(NSString *)responseOptionString
                 forPostID:(NSString *)postObjectID
            withCompletion:(void (^)(NSString *updatedAt))completion;
@end
