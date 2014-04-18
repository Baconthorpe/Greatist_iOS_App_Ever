//
//  Post+Methods.h
//  Greatist Message Publisher
//
//  Created by Ezekiel Abuhoff on 4/2/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "Post.h"

@interface Post (Methods)

+ (instancetype) postWithContent: (NSString *)content
                          author: (User *)user
                         section: (Section *)section
                       responses: (NSSet *)responses
                       inContext: (NSManagedObjectContext *)context;

+ (instancetype) postWithContent: (NSString *)content
                          author: (User *)user
                         section: (Section *)section
                       responses: (NSSet *)responses
                       timeStamp: (NSDate *)timeStamp
                       inContext: (NSManagedObjectContext *)context;

+ (instancetype) postWithContent: (NSString *)content
                       inContext: (NSManagedObjectContext *)context;

- (NSInteger) countOfResponsesWithContent: (NSString *)responseContent;

+ (instancetype) uniquePostWithContent: (NSString *)content
                                author: (User *)user
                               section: (Section *)section
                             responses: (NSSet *)responses
                             timeStamp: (NSDate *)timeStamp
                             inContext: (NSManagedObjectContext *)context;

@end