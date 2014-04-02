//
//  Section+Methods.m
//  Greatist Message Publisher
//
//  Created by Ezekiel Abuhoff on 4/2/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "Section+Methods.h"

@implementation Section (Methods)


+ (instancetype) sectionWithName: (NSString *)name
                       inContext: (NSManagedObjectContext *)context
{
    Section *newSection = [NSEntityDescription insertNewObjectForEntityForName:@"Section" inManagedObjectContext:context];
    
    if (newSection)
    {
        newSection.name = name;
    }
    
    return newSection;
}

//- (instancetype) insertionInit
//{
//    
//}
//
//- (instancetype) insertionInitWithName: (NSString *)name
//                             inContext: (NSManagedObjectContext *)context
//{
//    Section *newSection = [NSEntityDescription insertNewObjectForEntityForName:@"Section" inManagedObjectContext:context];
//    
//    if (newSection)
//    {
//        
//    }
//}

@end
