//
//  GRTDataStore.h
//  Greatist Message Publisher
//
//  Created by Ezekiel Abuhoff on 4/2/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User+Methods.h"
#import "Post+Methods.h"
#import "Response+Methods.h"
#import "ResponseOption+Methods.h"
#import "Section+Methods.h"
#import "UIColor+Helpers.h"

@interface GRTDataStore : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong, nonatomic) NSFetchedResultsController *postFRController;
@property (strong, nonatomic) NSFetchedResultsController *articleFRController;

@property (strong, nonatomic) NSArray *facebookFriends;
@property (strong, nonatomic) NSArray *validResponses;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

+ (instancetype) sharedDataStore;

- (void) starterData;
- (NSArray *) fetchPostsForCurrentUser;
- (void) fetchArticles;
- (void) fetchValidResponses;

- (void) testParseGET;
- (void) testParsePOST;

- (void) testGreatistGET;
- (void) testGreatistPOST;

@end
