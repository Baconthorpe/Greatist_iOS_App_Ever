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

@end
