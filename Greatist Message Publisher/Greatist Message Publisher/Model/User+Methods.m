//
//  User+Methods.m
//  Greatist Message Publisher
//
//  Created by Ezekiel Abuhoff on 4/2/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "User+Methods.h"

@implementation User (Methods)

+ (instancetype) getUserWithFacebookID: (NSString *)facebookID
                             inContext: (NSManagedObjectContext *)context
{
    NSFetchRequest *userSearch = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    NSPredicate *idCheck = [NSPredicate predicateWithFormat:@"facebookID == %@",facebookID];
    userSearch.predicate = idCheck;
    NSSortDescriptor *sortByID = [NSSortDescriptor sortDescriptorWithKey:@"facebookID" ascending:YES];
    userSearch.sortDescriptors = @[sortByID];
    
    NSArray *arrayOfMatches = [context executeFetchRequest:userSearch error:nil];
    
    return arrayOfMatches[0];
}

+ (instancetype) userWithFacebookID: (NSString *)facebookID
                          inContext: (NSManagedObjectContext *)context
{
    User *newUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
    
    if (newUser)
    {
        newUser.facebookID = facebookID;
    }
    
    return newUser;
}

+ (instancetype) userUniqueWithFacebookID: (NSString *)facebookID
                                inContext: (NSManagedObjectContext *)context
{
    NSFetchRequest *userSearch = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    NSPredicate *idCheck = [NSPredicate predicateWithFormat:@"facebookID==%@",facebookID];
    userSearch.predicate = idCheck;
    NSSortDescriptor *sortByID = [NSSortDescriptor sortDescriptorWithKey:@"facebookID" ascending:YES];
    userSearch.sortDescriptors = @[sortByID];
    
    NSArray *arrayOfMatches = [context executeFetchRequest:userSearch error:nil];
    
    if ([arrayOfMatches count] == 0)
    {
        return [User userWithFacebookID:facebookID inContext:context];
    }
    
    return arrayOfMatches[0];
}

@end
