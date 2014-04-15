//
//  ResponseOption+Methods.h
//  Greatist Message Publisher
//
//  Created by Leonard Li on 4/11/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "ResponseOption.h"

@interface ResponseOption (Methods)

+ (instancetype) responseoptionWithContent: (NSString *)content
                                 inContext: (NSManagedObjectContext *)context;

+ (instancetype) uniqueResponseOptionWithContent: (NSString *)content
                                       inContext: (NSManagedObjectContext *)context;

@end
