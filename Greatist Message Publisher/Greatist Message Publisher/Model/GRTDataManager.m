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

+ (instancetype)sharedManager {
   
    return [[self alloc] init];
}

- (instancetype)init
{
    return [self initWithParseAPIClient:[[self class] defaultParseClient]
                      FacebookAPIClient:[[self class] defaultFacebookClient]
                   ManagedObjectContext:[[self class] defaultManagedObjectContext]];
}

- (instancetype)initWithParseAPIClient:(GRTParseAPIClient *)parseClient
                     FacebookAPIClient:(GRTFacebookAPIClient *)facebookClient
                  ManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    
    static GRTDataManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [super init];
        if (_sharedManager) {
            _parseAPIClient = parseClient;
            _facebookAPIClient = facebookClient;
            _managedObjectContext = managedObjectContext;
        }
    });

    return _sharedManager;
}

#pragma mark - User Helper Methods

- (void) createNewUserWithName:(NSString *)nameString
                    FacebookID:(NSString *)facebookIDString
{
    [self.parseAPIClient postUserWithName:nameString
                               FacebookID:facebookIDString];
}


@end
