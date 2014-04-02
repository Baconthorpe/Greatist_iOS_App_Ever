//
//  Response+Methods.h
//  Greatist Message Publisher
//
//  Created by Ezekiel Abuhoff on 4/2/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "Response.h"

@interface Response (Methods)

+ (instancetype) responseWithContent: (NSString *)content
                                post: (Post *)post
                              author: (User *)user
                           inContext: (NSManagedObjectContext *)context;

+ (instancetype) responseWithContent: (NSString *)content
                           inContext: (NSManagedObjectContext *)context;

@end
