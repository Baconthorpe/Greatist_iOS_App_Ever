//
//  GRTDataManager.m
//  Greatist Message Publisher
//
//  Created by Leonard Li on 4/16/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "GRTDataManager.h"

@implementation GRTDataManager

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
        _sharedManager = [[GRTDataManager alloc] init];
        if (_sharedManager) {
            _parseAPIClient = parseClient;
            _facebookAPIClient = facebookClient;
            _managedObjectContext = managedObjectContext;
            _dataStore = dataStore;
        }
    });

    return _sharedManager;
}

#pragma mark - Import Methods

- (Post *) interpretPostFromDictionary: (NSDictionary *)postDictionary
{
    User *user = [User uniqueUserWithID:postDictionary[@"UserID"] inContext:self.managedObjectContext];
    
    Section *section = [Section uniqueSectionWithName:postDictionary[@"section"] inContext:self.managedObjectContext];
    
    Post *newPost = [Post uniquePostWithContent:postDictionary[@"content"] author:user section:section responses:nil timeStamp:nil inContext:self.managedObjectContext];
    
    
    
    return newPost;
}

- (void) interpretArrayOfPostDictionaries: (NSArray *)arrayOfPostDictionaries
{
    for (NSDictionary *postDictionary in arrayOfPostDictionaries) {
        [self interpretPostFromDictionary:postDictionary];
    }
    
    [self.dataStore saveContext];
}

- (void) postPostAndSaveIfSuccessfulForContent: (NSString *)content
                                     inSection: (Section *)section
{
    [self.parseAPIClient postPostWithContent:content
                                     section:section.name
                                    latitude:0.0
                                   longitude:0.0
                                      userID:nil
                              withCompletion:^(NSDictionary *result) {
                                  [Post uniquePostWithContent:content
                                                       author:nil
                                                      section:section
                                                    responses:nil
                                                    timeStamp:[NSDate date]
                                                    inContext:self.managedObjectContext];
                                  
                                  [self.dataStore saveContext];
                              }];
}


@end
