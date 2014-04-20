//
//  ResponseOption+Methods.m
//  Greatist Message Publisher
//
//  Created by Leonard Li on 4/11/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "ResponseOption+Methods.h"

@implementation ResponseOption (Methods)

+ (instancetype) responseoptionWithContent: (NSString *)content
                                 inContext: (NSManagedObjectContext *)context
{
    ResponseOption *newResponseOption = [NSEntityDescription insertNewObjectForEntityForName:@"ResponseOption" inManagedObjectContext:context];
    
    if (newResponseOption)
    {
        newResponseOption.content = content;
    }
    return newResponseOption;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"ResponseOption Desc: %@", self.content];
}

+ (instancetype) uniqueResponseOptionWithContent: (NSString *)content
                                       inContext: (NSManagedObjectContext *)context
{
    NSFetchRequest *responseOptionSearch = [NSFetchRequest fetchRequestWithEntityName:@"ResponseOption"];
    NSPredicate *idCheck = [NSPredicate predicateWithFormat:@"content==%@",content];
    responseOptionSearch.predicate = idCheck;
    NSSortDescriptor *sortByContent = [NSSortDescriptor sortDescriptorWithKey:@"content" ascending:NO];
    responseOptionSearch.sortDescriptors = @[sortByContent];
    
    NSArray *arrayOfMatches = [context executeFetchRequest:responseOptionSearch error:nil];
    
    if ([arrayOfMatches count] == 0)
    {
        return [ResponseOption responseoptionWithContent:content inContext:context];
    }
    
    return arrayOfMatches[0];
}

@end
