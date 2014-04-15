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

+ (instancetype) uniqueSectionWithName: (NSString *)name
                             inContext: (NSManagedObjectContext *)context
{
    NSFetchRequest *sectionSearch = [NSFetchRequest fetchRequestWithEntityName:@"Section"];
    NSPredicate *idCheck = [NSPredicate predicateWithFormat:@"name==%@",name];
    sectionSearch.predicate = idCheck;
    NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:NO];
    sectionSearch.sortDescriptors = @[sortByName];
    
    NSArray *arrayOfMatches = [context executeFetchRequest:sectionSearch error:nil];
    
    if ([arrayOfMatches count] == 0)
    {
        return [Section sectionWithName:name inContext:context];
    }
    
    return arrayOfMatches[0];
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
