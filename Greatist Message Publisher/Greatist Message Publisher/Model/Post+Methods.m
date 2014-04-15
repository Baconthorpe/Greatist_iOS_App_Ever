//
//  Post+Methods.m
//  Greatist Message Publisher
//
//  Created by Ezekiel Abuhoff on 4/2/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "Post+Methods.h"
#import "Response+Methods.h"

@implementation Post (Methods)

+ (instancetype) postWithContent: (NSString *)content
                          author: (User *)user
                         section: (Section *)section
                       responses: (NSSet *)responses
                       inContext: (NSManagedObjectContext *)context
{
    Post *newPost = [NSEntityDescription insertNewObjectForEntityForName:@"Post" inManagedObjectContext:context];
    
    if (newPost)
    {
        newPost.content = content;
        newPost.user = user;
        newPost.section = section;
        newPost.responses = responses;
        newPost.timeStamp = [NSDate date];
    }
    
    return newPost;
}

+ (instancetype) postWithContent: (NSString *)content
                          author: (User *)user
                         section: (Section *)section
                       responses: (NSSet *)responses
                       timeStamp: (NSDate *)timeStamp
                       inContext: (NSManagedObjectContext *)context
{
    Post *newPost = [NSEntityDescription insertNewObjectForEntityForName:@"Post" inManagedObjectContext:context];
    
    if (newPost)
    {
        newPost.content = content;
        newPost.user = user;
        newPost.section = section;
        newPost.responses = responses;
        newPost.timeStamp = timeStamp;
    }
    
    return newPost;
}

+ (instancetype) postWithContent: (NSString *)content
                       inContext: (NSManagedObjectContext *)context
{
    Post *newPost = [Post postWithContent:content author:nil section:nil responses:nil inContext:context];
    
    return newPost;
}

- (NSInteger) countOfResponsesWithContent: (NSString *)responseContent
{
    NSPredicate *preciseContentSearch = [NSPredicate predicateWithFormat:@"content==%@",responseContent];
    NSSet *setOfMatches = [self.responses filteredSetUsingPredicate:preciseContentSearch];
    
    return [setOfMatches count];
}

- (NSDictionary *) dictionaryOfResponses
{
    NSMutableDictionary *dictionaryToReturn = [NSMutableDictionary new];
    
    NSMutableSet *responseContents = [NSMutableSet new];
    
    for (Response *response in self.responses)
    {
//        [responseContents addObject:response.content];
    }
    
    for (NSString *responseContent in responseContents)
    {
        NSDictionary *entryForThisContent = @{responseContent: @([self countOfResponsesWithContent:responseContent])};
        [dictionaryToReturn addEntriesFromDictionary:entryForThisContent];
    }
    
    return dictionaryToReturn;
}

+ (instancetype) uniquePostWithContent: (NSString *)content
                                author: (User *)user
                               section: (Section *)section
                             responses: (NSSet *)responses
                             timeStamp: (NSDate *)timeStamp
                             inContext: (NSManagedObjectContext *)context
{
    NSFetchRequest *postSearch = [NSFetchRequest fetchRequestWithEntityName:@"Post"];
    NSPredicate *idCheck = [NSPredicate predicateWithFormat:@"user==%@ AND timeStamp",user,timeStamp];
    postSearch.predicate = idCheck;
    NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:NO];
    postSearch.sortDescriptors = @[sortByName];
    
    NSArray *arrayOfMatches = [context executeFetchRequest:postSearch error:nil];
    
    if ([arrayOfMatches count] == 0)
    {
        return [Post postWithContent:content author:user section:section responses:responses timeStamp:timeStamp inContext:context];
    }
    
    return arrayOfMatches[0];
}


@end
