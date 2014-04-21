//
//  GRTDataManager.m
//  Greatist Message Publisher
//
//  Created by Leonard Li on 4/16/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "GRTDataManager.h"

@implementation GRTDataManager

#pragma mark - Private Default Helper Methods

+ (GRTParseAPIClient *)defaultParseClient
{
    return [GRTParseAPIClient sharedClient];
}

+ (GRTFacebookAPIClient *)defaultFacebookClient
{
    return [GRTFacebookAPIClient sharedClient];
}

+ (NSManagedObjectContext *)defaultManagedObjectContext
{
    return [GRTDataStore sharedDataStore].managedObjectContext;
}

+ (GRTDataStore *)defaultDataStore
{
    return [GRTDataStore sharedDataStore];
}


#pragma mark - Init Helper Methods

+ (instancetype)sharedManager {
   
    return [[self alloc] init];
}

- (instancetype)init
{
    return [self initWithParseAPIClient:[[self class] defaultParseClient]
                      FacebookAPIClient:[[self class] defaultFacebookClient]
                   ManagedObjectContext:[[self class] defaultManagedObjectContext]
                              DataStore:[[self class] defaultDataStore]];
}

- (instancetype)initWithParseAPIClient:(GRTParseAPIClient *)parseClient
                     FacebookAPIClient:(GRTFacebookAPIClient *)facebookClient
                  ManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
                             DataStore:(GRTDataStore *)dataStore
{
    
    static GRTDataManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [super init];
        if (_sharedManager) {
            _parseAPIClient = parseClient;
            _facebookAPIClient = facebookClient;
            _managedObjectContext = managedObjectContext;
            _dataStore = dataStore;
        }
    });

    return _sharedManager;
}

- (void) getInitialData
{
    [[GRTDataManager sharedManager] getValidResponses];
}

#pragma mark - User Helper Methods
- (User *)getCurrentUser
{
    return self.dataStore.currentUser;
}

- (void) setCurrentUser:(User *)user
{
    self.dataStore.currentUser = user;
}

- (void) getUsersWithCompletion:(void (^)(NSArray *users))completionBlock
{
    [self.parseAPIClient getUsersWithCompletion:^(NSArray *users) {
        NSMutableArray *usersArray = [NSMutableArray new];
        for (NSDictionary *user in users) {
            User *newUser = [User userWithFacebookID:user[@"facebookID"] inContext:self.dataStore.managedObjectContext];
            [usersArray addObject:newUser];
        }
        completionBlock(usersArray);
    }];
}

- (void) createNewUserWithFacebookID:(NSString *)facebookIDString
                      withCompletion:(void (^)(BOOL isSuccessful))completion
{
    [self.parseAPIClient postUserWithFacebookID:facebookIDString Completion:nil];
    [User userUniqueWithFacebookID:facebookIDString inContext:self.dataStore.managedObjectContext];
    completion(YES);
}

#pragma mark - Post Helper Methods

- (void) getPostsBasedOnFacebookFriends
{
    [self.facebookAPIClient getFriendIDsWithCompletion:^(NSArray *facebookFriendIDs) {
        NSMutableArray *friendsPlusMeArray = [NSMutableArray arrayWithArray:facebookFriendIDs];
        [friendsPlusMeArray addObject:self.dataStore.currentUser.facebookID];
        [friendsPlusMeArray addObject:@"-1"];
        [self.parseAPIClient getPostsWithFriendIDs:friendsPlusMeArray
                                    WithCompletion:^(NSArray *posts) {
            [self interpretArrayOfPostDictionaries:posts];
            [self.dataStore saveContext];
        }];
    }];
}


- (void) postPostAndSaveIfUnique: (NSString *)content
                                     inSection: (Section *)section
                                 withResponses: (NSString *)responseDictionaryString
                                withCompletion: (void (^)(NSDictionary *postResponse))completion
{
    NSString *postContent = [content stringByReplacingOccurrencesOfString:@"'" withString:@"’"];
    
    [self.parseAPIClient postPostWithContent:postContent
                                     section:section.name
                                   responses:responseDictionaryString
                              userFacebookID:self.dataStore.currentUser.facebookID
                              withCompletion:^(NSDictionary *postResponse) {
      if (postResponse) {
          NSDate *createdAtDate = [self dateFromString:postResponse[@"createdAt"]];
          
          [Post uniquePostWithContent:postContent
                             objectId:postResponse[@"objectId"]
                               author:self.dataStore.currentUser
                              section:section
                            responses:responseDictionaryString
                            timeStamp:createdAtDate
                            isFlagged:@0
                            inContext:self.managedObjectContext];
          
          [self.dataStore saveContext];
          completion(postResponse);
      }
    }];
}

- (void) flagPost:(Post *)post
   withCompletion:(void (^)(NSDictionary *))completion
{
    [self.parseAPIClient flagPostID:post.objectId withCompletion:^(NSDictionary *response) {
        post.isFlagged = @1;
        completion(response);
    }];
}

#pragma mark - Response Helper Methods
- (void) getValidResponses
{
    [self.parseAPIClient getValidResponsesWithCompletion:^(NSArray *responseOptionArray) {
        NSMutableArray *responsesOptions = [NSMutableArray new];
        for (NSDictionary *responseOption in responseOptionArray) {
            ResponseOption *newResponseOption = [ResponseOption responseoptionWithContent:responseOption[@"content"] inContext:self.managedObjectContext];
            [responsesOptions addObject:newResponseOption];
        }
        self.dataStore.validResponses = responsesOptions;
    }];
}

- (void) getUpdatedResponsesForPostID:(NSString *)postObjectID
              withCompletion:(void (^)(NSDictionary *postDictionary))completion
{
    
    [self.parseAPIClient getPostForPostID:postObjectID withCompletion:^(NSDictionary *postDictionary) {
        [self.dataStore setSelectedResponsesFromJSONString:postDictionary[@"responses"]];
        completion(postDictionary);
    }];
}
- (void) incrementResponse:(NSString *)responseOptionString
                 forPostID:(NSString *)postObjectID
                withCompletion:(void (^)(NSString *updatedAt))completion
{
    
    NSString *responseOption = [responseOptionString stringByReplacingOccurrencesOfString:@"\\\"" withString:@"\""];
    [self getUpdatedResponsesForPostID:postObjectID
               withCompletion:^(NSDictionary *postDictionary) {
        NSInteger newResponseCount = [[self.dataStore.selectedResponses valueForKey:responseOption] integerValue] + 1;
        [self.dataStore.selectedResponses setValue:@(newResponseCount) forKeyPath:responseOptionString];
       
        [self.parseAPIClient updatePostID:postObjectID
                           withResponses:[self.dataStore getSelectedResponsesAsJSONString]
                          withCompletion:^(NSString *updatedAt) {
            completion(updatedAt);
        }];
    }];
}

#pragma mark - Helper Methods
-(NSDate *)dateFromString:(NSString *)string
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormatter setLocale:locale];
    [dateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSS'Z'"];
    NSTimeInterval interval = 5 * 60 * 60;
    
    NSDate *date1 = [dateFormatter dateFromString:string];
    date1 = [date1 dateByAddingTimeInterval:interval];
    if(!date1) date1= [NSDate date];
    
    return date1;
}

#pragma mark - Import Helper Methods
- (void) interpretArrayOfPostDictionaries: (NSArray *)arrayOfPostDictionaries
{
    for (NSDictionary *postDictionary in arrayOfPostDictionaries) {
        [self createLocalPostFromDictionary:postDictionary];
    }
}

- (Post *) createLocalPostFromDictionary: (NSDictionary *)postDictionary
{
    Section *section = [Section uniqueSectionWithName:postDictionary[@"section"] inContext:self.managedObjectContext];
    
    NSDate *createdAtDate = [self dateFromString:postDictionary[@"createdAt"]];
    
    NSLog(@"isFlagged for this post: %@",postDictionary[@"isFlagged"]);
    
    Post *newPost = [Post uniquePostWithContent:postDictionary[@"content"]
                                       objectId:postDictionary[@"objectId"]
                                         author:nil section:section
                                      responses:postDictionary[@"responses"]
                                      timeStamp:createdAtDate
                                      isFlagged:postDictionary[@"isFlagged"]
                                      inContext:self.managedObjectContext];
    NSLog(@"Core Data New Post: %@", newPost);
    return newPost;
}

@end
