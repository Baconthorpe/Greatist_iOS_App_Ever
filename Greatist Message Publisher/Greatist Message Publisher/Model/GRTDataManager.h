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

+ (instancetype)sharedManager;
- (instancetype)init;
- (instancetype)initWithParseAPIClient:(GRTParseAPIClient *)parseClient
                     FacebookAPIClient:(GRTFacebookAPIClient *)facebookClient
                  ManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

- (Post *) interpretPostFromDictionary: (NSDictionary *)postDictionary;
- (void) interpretArrayOfPostDictionaries: (NSArray *)arrayOfPostDictionaries;
- (void) postPostAndSaveIfSuccessfulForContent: (NSString *)content
                                     inSection: (Section *)section;

@end
