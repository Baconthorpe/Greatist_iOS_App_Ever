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


@end
