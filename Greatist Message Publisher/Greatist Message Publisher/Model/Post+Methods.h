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
                       responses: (NSString *)responses
                       inContext: (NSManagedObjectContext *)context;

+ (instancetype) postWithContent: (NSString *)content
                        objectId: (NSString *)objectId
                          author: (User *)user
                         section: (Section *)section
                       responses: (NSString *)responses
                       timeStamp: (NSDate *)timeStamp
                       isFlagged: (NSNumber *)isFlagged
                       inContext: (NSManagedObjectContext *)context;

+ (instancetype) postWithContent: (NSString *)content
                       inContext: (NSManagedObjectContext *)context;

+ (instancetype) uniquePostWithContent: (NSString *)content
                              objectId: (NSString *)objectId
                                author: (User *)user
                               section: (Section *)section
                             responses: (NSString *)responses
                             timeStamp: (NSDate *)timeStamp
                             isFlagged: (NSNumber *)isFlagged
                             inContext: (NSManagedObjectContext *)context;

@end