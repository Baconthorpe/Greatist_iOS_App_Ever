//
//  GRTImporter.m
//  Greatist Message Publisher
//
//  Created by Ezekiel Abuhoff on 4/2/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "GRTImporter.h"
#import "Post+Methods.h"
#import "Response+Methods.h"

@implementation GRTImporter

+ (NSDictionary *) responsesDictionaryOfPost: (Post *)post
{
    NSSet *responses = post.responses;
    NSMutableDictionary *tempResponses = [NSMutableDictionary new];
    NSMutableSet *uniqueContentStrings = [NSMutableSet new];
    
    for (Response *response in responses)
    {
//        [uniqueContentStrings addObject:response.responseOption.content];
    }
    
    for (NSString *contentString in uniqueContentStrings)
    {
        NSDictionary *entryOfThisContent = @{contentString:@([post countOfResponsesWithContent:contentString])};
        [tempResponses addEntriesFromDictionary:entryOfThisContent];
    }
    
    return tempResponses;
}



@end
