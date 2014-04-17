
//
//  GRTDataStore.m
//  Greatist Message Publisher
//
//  Created by Ezekiel Abuhoff on 4/2/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "GRTDataStore.h"
#import "User+Methods.h"
#import "Post+Methods.h"
#import "Response+Methods.h"
#import "Section+Methods.h"
#import "GRTParseAPIClient.h"
#import "GRTFacebookAPIClient.h"


@interface GRTDataStore ()

@property (strong, nonatomic) GRTParseAPIClient *parseAPIClient;
@property (strong, nonatomic) GRTFacebookAPIClient *facebookAPIClient;

@end

@implementation GRTDataStore

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

#pragma mark - Lazy Instantiation

- (NSFetchedResultsController *) postFRController
{
    if (!_postFRController)
    {
        NSFetchRequest *postFetch = [[NSFetchRequest alloc] initWithEntityName:@"Post"];
        postFetch.fetchBatchSize = 20;
        
        NSSortDescriptor *postDate = [[NSSortDescriptor alloc] initWithKey:@"timeStamp" ascending:NO];
        postFetch.sortDescriptors = @[postDate];
        
        [NSFetchedResultsController deleteCacheWithName:@"postCache"];
        _postFRController = [[NSFetchedResultsController alloc] initWithFetchRequest:postFetch managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"postCache"];
        
        [_postFRController performFetch:nil];
    }
    
    return _postFRController;
}

#pragma mark - Singleton Method

+ (instancetype) sharedDataStore
{
    static GRTDataStore *_shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[GRTDataStore alloc] init];
    });
    
    if (_shared)
    {
        _shared.parseAPIClient = [[GRTParseAPIClient alloc] init];
        _shared.facebookAPIClient = [[GRTFacebookAPIClient alloc] init];
    }
    
    return _shared;
}

#pragma mark - Core Data stack

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Greatist_Message_Publisher" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Greatist_Message_Publisher.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - Basic Data Fetches

- (User *) retrieveUserByUniqueID: (NSString *)uniqueID
{
    NSFetchRequest *userFetch = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    NSSortDescriptor *usersAlphabetical = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    userFetch.sortDescriptors = @[usersAlphabetical];
    NSPredicate *uniqueIDPredicate = [NSPredicate predicateWithFormat:@"uniqueID==%@",uniqueID];
    userFetch.predicate = uniqueIDPredicate;
    
    return [self.managedObjectContext executeFetchRequest:userFetch error:nil][0];
}


- (void) fetchValidResponses
{
    [self.parseAPIClient getValidResponsesWithCompletion:^(NSArray *responseOptionArray) {
        NSMutableArray *responsesOptions = [NSMutableArray new];
        for (NSDictionary *responseOption in responseOptionArray) {
            ResponseOption *newResponseOption = [ResponseOption responseoptionWithContent:responseOption[@"content"] inContext:self.managedObjectContext];
            [responsesOptions addObject:newResponseOption];
        }
        self.validResponses = responsesOptions;
    }];
}

- (NSDictionary *) dictionaryOfSections
{
    NSFetchRequest *sectionFetch = [NSFetchRequest fetchRequestWithEntityName:@"Section"];
    NSSortDescriptor *nameSort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:NO];
    sectionFetch.sortDescriptors = @[nameSort];
    
    NSArray *fetchResults = [self.managedObjectContext executeFetchRequest:sectionFetch error:nil];
    
    NSMutableDictionary *dictionaryToReturn = [NSMutableDictionary new];
    for (Section *section in fetchResults) {
        NSDictionary *sectionEntry = @{section.name:section};
        [dictionaryToReturn addEntriesFromDictionary:sectionEntry];
    }
    
    return dictionaryToReturn;
}


#pragma mark - Startup

- (void) starterData
{
    NSFetchRequest *sectionFetch = [NSFetchRequest fetchRequestWithEntityName:@"Section"];
    
    if ([[self.managedObjectContext executeFetchRequest:sectionFetch error:nil] count] == 0)
    {
        Section *fitness = [Section sectionWithName:@"Fitness" inContext:self.managedObjectContext];
        Section *health = [Section sectionWithName:@"Health" inContext:self.managedObjectContext];
        Section *happiness = [Section sectionWithName:@"Happiness" inContext:self.managedObjectContext];
        
        User *anne = [User userUniqueWithFacebookID:@"1084710028" inContext:self.managedObjectContext];
        User *zeke = [User userUniqueWithFacebookID:@"1341420545" inContext:self.managedObjectContext];
        User *liz = [User userUniqueWithFacebookID:@"798534605" inContext:self.managedObjectContext]; //update me
        User *len = [User userUniqueWithFacebookID:@"798534605" inContext:self.managedObjectContext];
        
        Post *anneOne = [Post postWithContent:@"I joined a gym today!"
                                       author:anne
                                      section:fitness
                                    responses:nil 
                                    inContext:self.managedObjectContext];
        
        Post *zekeOne = [Post postWithContent:@"I have a love/hate relationship with gluten."
                                       author:zeke
                                      section:health
                                    responses:nil
                                    inContext:self.managedObjectContext];
        
        
        Post *lizOne = [Post postWithContent:@"I love the WOD article!"
                                      author:zeke
                                     section:happiness
                                   responses:nil
                                   inContext:self.managedObjectContext];

        Post *anotherPost = [Post postWithContent:@"beep beep beep!"
                                           author:zeke
                                          section:fitness
                                        responses:nil
                                        inContext:self.managedObjectContext];
        Post *arPost = [Post postWithContent:@"beep beep beep!"
                                          author:zeke
                                         section:health
                                       responses:nil
                                       inContext:self.managedObjectContext];
        
        [self saveContext];
    }
    
}

- (void) testParseGET
{
    [self.parseAPIClient getRelevantPostsWithCompletion:^(NSArray *responseArray) {
//        NSLog(@"getRelevantPostsWithCompletion: %@",responseArray);
    }];
}

- (void) testParsePOST
{
//    [self.parseAPIClient postPostWithContent:@"I did stuff and stuff." section:@"grow" latitude:10.0 longitude:10.0 userID:@"oiou534iou345o"];
}

#pragma mark - Online Functionality

- (void) createUserWithFacebookID: (NSString *)facebookID
{
    
}

- (void) createPostWithContent: (NSString *)content
                     inSection: (Section *)section
{
    
}

- (void) getRecentPosts
{
    
}

- (void) getSocialPosts
{
    
}


@end
