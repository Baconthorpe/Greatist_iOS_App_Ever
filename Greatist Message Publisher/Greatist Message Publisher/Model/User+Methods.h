//
//  User+Methods.h
//  Greatist Message Publisher
//
//  Created by Ezekiel Abuhoff on 4/2/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "User.h"

@interface User (Methods)

+ (instancetype) userWithName: (NSString *)name
                     uniqueID: (NSString *)uniqueID
                    inContext: (NSManagedObjectContext *)context;

+ (instancetype) userWithFacebookID: (NSString *)facebookID
                          inContext: (NSManagedObjectContext *)context;

+ (instancetype) uniqueUserWithName: (NSString *)name
                           uniqueID: (NSString *)uniqueID
                          inContext: (NSManagedObjectContext *)context;

+ (instancetype) uniqueUserWithFacebookID: (NSString *)facebookID
                                inContext: (NSManagedObjectContext *)context;

+ (instancetype) uniqueUserWithID: (NSString *)uniqueID
                        inContext:(NSManagedObjectContext *)context;

@end
