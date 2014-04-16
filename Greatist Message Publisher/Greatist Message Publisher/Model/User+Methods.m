//
//  User+Methods.m
//  Greatist Message Publisher
//
//  Created by Ezekiel Abuhoff on 4/2/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "User+Methods.h"

@implementation User (Methods)

+ (instancetype) userWithName: (NSString *)name
                     uniqueID: (NSString *)uniqueID
                    inContext: (NSManagedObjectContext *)context
{
    User *newUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
    
    if (newUser)
    {
        newUser.name = name;
        newUser.uniqueID = uniqueID;
    }
    
    return newUser;
}

+ (instancetype) uniqueUserWithName: (NSString *)name
                           uniqueID: (NSString *)uniqueID
                          inContext: (NSManagedObjectContext *)context
{
    NSFetchRequest *userSearch = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    NSPredicate *idCheck = [NSPredicate predicateWithFormat:@"uniqueID==%@",uniqueID];
    userSearch.predicate = idCheck;
    NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:NO];
    userSearch.sortDescriptors = @[sortByName];
    
    NSArray *arrayOfMatches = [context executeFetchRequest:userSearch error:nil];
    
    if ([arrayOfMatches count] == 0)
    {
        return [User userWithName:name uniqueID:uniqueID inContext:context];
    }
    
    return arrayOfMatches[0];
}

@end
