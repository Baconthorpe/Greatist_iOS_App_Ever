//
//  Response+Methods.m
//  Greatist Message Publisher
//
//  Created by Ezekiel Abuhoff on 4/2/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "Response+Methods.h"

@implementation Response (Methods)

+ (instancetype) responseWithContent: (NSString *)content
                                post: (Post *)post
                              author: (User *)user
                           inContext: (NSManagedObjectContext *)context
{
    Response *newResponse = [NSEntityDescription insertNewObjectForEntityForName:@"Response" inManagedObjectContext:context];
    
    if (newResponse)
    {
        newResponse.content = content;
        newResponse.post = post;
        newResponse.user = user;
        newResponse.timeStamp = [NSDate date];
    }
    
    return newResponse;
}

+ (instancetype) responseWithContent: (NSString *)content
                           inContext: (NSManagedObjectContext *)context
{
    Response *newResponse = [Response responseWithContent:content post:nil author:nil inContext:context];
    
    return newResponse;
}

@end
