//
//  Article+Methods.m
//  Greatist Message Publisher
//
//  Created by Ezekiel Abuhoff on 4/14/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "Article+Methods.h"

@implementation Article (Methods)

+ (instancetype) articleWithHeadline: (NSString *)headline
                             section: (Section *)section
                           inContext: (NSManagedObjectContext *)context
{
    Article *newArticle = [NSEntityDescription insertNewObjectForEntityForName:@"Article" inManagedObjectContext:context];
    
    if (newArticle)
    {
        newArticle.headline = headline;
        newArticle.section = section;
    }
    
    return newArticle;
}

@end
