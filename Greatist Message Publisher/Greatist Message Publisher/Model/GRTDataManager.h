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

+ (instancetype)sharedManager;
- (instancetype)init;
- (instancetype)initWithParseAPIClient:(GRTParseAPIClient *)parseClient
                     FacebookAPIClient:(GRTFacebookAPIClient *)facebookClient
                  ManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
                             DataStore:(GRTDataStore *)dataStore;

- (Post *) interpretPostFromDictionary: (NSDictionary *)postDictionary;
- (void) interpretArrayOfPostDictionaries: (NSArray *)arrayOfPostDictionaries;
- (void) postPostAndSaveIfSuccessfulForContent: (NSString *)content
                                     inSection: (Section *)section;

- (void) fetchUsersWithCompletion:(void (^)(NSArray *users))completionBlock;
- (void) createNewUserWithName:(NSString *)nameString
                    FacebookID:(NSString *)facebookIDString;

- (void) fetchPostsForFacebookFriends:(NSArray *)friendIDs
                       WithCompletion:(void (^)(NSArray *posts))completionBlock;
@end
