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


#pragma mark - User Helper Methods
- (User *)getCurrentUser
{
    return self.dataStore.currentUser;
}

- (void) setCurrentUser:(User *)user
{
    self.dataStore.currentUser = user;
}

- (void) fetchUsersWithCompletion:(void (^)(NSArray *users))completionBlock
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
{
    [self.parseAPIClient postUserWithFacebookID:facebookIDString Completion:nil];
    [User userUniqueWithFacebookID:facebookIDString inContext:self.dataStore.managedObjectContext];
}

#pragma mark - Post Helper Methods

- (void) getPostsBasedOnFacebookFriends
{
    [self.facebookAPIClient getFriendIDsWithCompletion:^(NSArray *facebookFriendIDs) {
        [self.parseAPIClient getPostsWithFriendIDs:facebookFriendIDs
                                    WithCompletion:^(NSArray *posts) {
            [self interpretArrayOfPostDictionaries:posts];
            [self.dataStore saveContext];
        }];
    }];
}


- (void) postPostAndSaveIfSuccessfulForContent: (NSString *)content
                                     inSection: (Section *)section
{
    [self.parseAPIClient postPostWithContent:content
                                     section:section.name
                                userObjectId:nil
                              userFacebookID:self.dataStore.currentUser.facebookID
                              withCompletion:^(NSDictionary *postResponse) {
      
      [Post uniquePostWithContent:content
                           author:self.dataStore.currentUser
                          section:section
                        responses:nil
                        timeStamp:[NSDate date]
                        inContext:self.managedObjectContext];
      
      [self.dataStore saveContext];
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
    
    Post *newPost = [Post uniquePostWithContent:postDictionary[@"content"] author:nil section:section responses:nil timeStamp:createdAtDate inContext:self.managedObjectContext];
    
    return newPost;
}

@end
