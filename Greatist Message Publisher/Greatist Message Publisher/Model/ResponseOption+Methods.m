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
    return [NSString stringWithFormat:@"ResponseOption: %@", self.content];
}
@end
