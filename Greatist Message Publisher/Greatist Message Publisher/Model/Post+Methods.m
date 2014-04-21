//
//  Post+Methods.m
//  Greatist Message Publisher
//
//  Created by Ezekiel Abuhoff on 4/2/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "Post+Methods.h"

@implementation Post (Methods)

+ (instancetype) postWithContent: (NSString *)content
                          author: (User *)user
                         section: (Section *)section
                       responses: (NSString *)responses
                       inContext: (NSManagedObjectContext *)context
{
    Post *newPost = [NSEntityDescription insertNewObjectForEntityForName:@"Post" inManagedObjectContext:context];
    
    if (newPost)
    {
        newPost.content = content;
        newPost.timeStamp = [NSDate date];
        newPost.isFlagged = [NSNumber numberWithBool:NO];
        
        newPost.responses = responses;
        newPost.section = section;
        newPost.user = user;

    }
    
    return newPost;
}

+ (instancetype) postWithContent: (NSString *)content
                        objectId: (NSString *)objectId
                          author: (User *)user
                         section: (Section *)section
                       responses: (NSString *)responses
                       timeStamp: (NSDate *)timeStamp
                       isFlagged: (NSNumber *)isFlagged
                       inContext: (NSManagedObjectContext *)context
{
    Post *newPost = [NSEntityDescription insertNewObjectForEntityForName:@"Post" inManagedObjectContext:context];
    
    if (newPost)
    {
        newPost.content = content;
        newPost.objectId = objectId;
        newPost.timeStamp = timeStamp;
        newPost.isFlagged = isFlagged;
        
        newPost.responses = responses;
        newPost.section = section;
        newPost.user = user;
    }
    
    return newPost;
}

+ (instancetype) postWithContent: (NSString *)content
                       inContext: (NSManagedObjectContext *)context
{
    Post *newPost = [Post postWithContent:content author:nil section:nil responses:nil inContext:context];
    
    return newPost;
}

+ (instancetype) uniquePostWithContent: (NSString *)content
                              objectId: (NSString *)objectId
                                author: (User *)user
                               section: (Section *)section
                             responses: (NSString *)responses
                             timeStamp: (NSDate *)timeStamp
                             isFlagged: (NSNumber *)isFlagged
                             inContext: (NSManagedObjectContext *)context
{
    NSFetchRequest *postSearch = [NSFetchRequest fetchRequestWithEntityName:@"Post"];
    NSPredicate *idCheck = [NSPredicate predicateWithFormat:@"content==%@",content];
    postSearch.predicate = idCheck;
    NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"content" ascending:NO];
    postSearch.sortDescriptors = @[sortByName];
    
    NSArray *arrayOfMatches = [context executeFetchRequest:postSearch error:nil];
    
    if ([arrayOfMatches count] == 0)
    {
        return [Post postWithContent:content objectId:objectId author:user section:section responses:responses timeStamp:timeStamp isFlagged:isFlagged inContext:context];
    }
    
    return arrayOfMatches[0];
}

- (NSDictionary *) responseDictionaryForPost
{
    NSError *error;
    NSData *responseData = [self.responses dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:responseData
                                                                       options:kNilOptions
                                                                         error:&error];
    if (&error) {
        NSLog(@"Error parsing response for post: %@", error);
        return @{};
    }
    return responseDictionary;
}


@end
