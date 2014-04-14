//
//  Response+Methods.m
//  Greatist Message Publisher
//
//  Created by Ezekiel Abuhoff on 4/2/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "Response+Methods.h"

@implementation Response (Methods)

+ (instancetype) responseWithResponseOption: (ResponseOption *)responseOption
                                post: (Post *)post
                              author: (User *)user
                           inContext: (NSManagedObjectContext *)context
{
    Response *newResponse = [NSEntityDescription insertNewObjectForEntityForName:@"Response" inManagedObjectContext:context];
    
    if (newResponse)
    {
        newResponse.responseOption = responseOption;
        newResponse.post = post;
        newResponse.user = user;
    }
    
    return newResponse;
}

+ (instancetype) responseWithResponseOption: (ResponseOption *)responseOption
                                  inContext: (NSManagedObjectContext *)context
{
    Response *newResponse = [Response responseWithResponseOption:responseOption post:nil author:nil inContext:context];
    
    return newResponse;
}

+ (instancetype) uniqueResponseWithResponseOption: (ResponseOption *)responseOption
                                             post: (Post *)post
                                           author: (User *)user
                                        inContext: (NSManagedObjectContext *)context
{
    NSFetchRequest *responseSearch = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    NSPredicate *idCheck = [NSPredicate predicateWithFormat:@"responseOption==%@ AND post==%@ AND user==%@",responseOption,post,user];
    responseSearch.predicate = idCheck;
    NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:NO];
    responseSearch.sortDescriptors = @[sortByName];
    
    NSArray *arrayOfMatches = [context executeFetchRequest:responseSearch error:nil];
    
    if ([arrayOfMatches count] == 0)
    {
        return [Response responseWithResponseOption:responseOption post:post author:user inContext:context];
    }
    
    return arrayOfMatches[0];

}
@end
