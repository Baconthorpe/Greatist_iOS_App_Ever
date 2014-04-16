//
//  User+Methods.h
//  Greatist Message Publisher
//
//  Created by Ezekiel Abuhoff on 4/2/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "User.h"

@interface User (Methods)

+ (instancetype) userWithFacebookID: (NSString *)facebookID
                          inContext: (NSManagedObjectContext *)context;

+ (instancetype) userWithFacebookID: (NSString *)facebookID
                           ObjectId: (NSString *)objectId
                          inContext: (NSManagedObjectContext *)context;

+ (instancetype) userUniqueWithFacebookID: (NSString *)facebookID
                                 ObjectId: (NSString *)objectId
                                inContext: (NSManagedObjectContext *)context;

@end
