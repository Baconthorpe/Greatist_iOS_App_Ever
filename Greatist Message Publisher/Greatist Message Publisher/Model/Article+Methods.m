//
//  Article+Methods.m
//  Greatist Message Publisher
//
//  Created by Ezekiel Abuhoff on 4/14/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "Article+Methods.h"

@implementation Article (Methods)

+ (instancetype)articleWithTitle:(NSString *)title
                         Created:(NSDate *)created
                    pictureLarge:(NSString *)pictureLarge
                             Nid:(NSString *)nid
                       inContext:(NSManagedObjectContext *)context
{
    Article *newArticle = [NSEntityDescription insertNewObjectForEntityForName:@"Article" inManagedObjectContext:context];
    
    if (newArticle)
    {
        newArticle.title = title;
        newArticle.created = created;
        newArticle.pictureLarge = pictureLarge;
        newArticle.nid = nid;
    }
    
    return newArticle;
}

@end
