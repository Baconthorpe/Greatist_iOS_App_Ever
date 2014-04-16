//
//  User+Methods.m
//  Greatist Message Publisher
//
//  Created by Ezekiel Abuhoff on 4/2/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "User+Methods.h"

@implementation User (Methods)

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

+ (instancetype) userWithFacebookID: (NSString *)facebookID
                           ObjectId: (NSString *)objectId
                          inContext: (NSManagedObjectContext *)context
{
    User *newUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
    
    if (newUser)
    {
        newUser.facebookID = facebookID;
        newUser.objectId = objectId;
    }
    
    return newUser;
}

+ (instancetype) userUniqueWithFacebookID: (NSString *)facebookID
                                 ObjectId: (NSString *)objectId
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
        return [User userWithFacebookID:facebookID ObjectId:objectId inContext:context];
    }
    
    return arrayOfMatches[0];
}


@end
