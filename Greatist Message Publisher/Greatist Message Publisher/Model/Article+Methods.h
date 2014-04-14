//
//  Article+Methods.h
//  Greatist Message Publisher
//
//  Created by Ezekiel Abuhoff on 4/14/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "Article.h"

@interface Article (Methods)

+ (instancetype) articleWithTitle: (NSString *)title
                          Created: (NSDate *)created
                     pictureLarge: (NSString *)pictureLarge
                              Nid: (NSString *)nid
                        inContext: (NSManagedObjectContext *)context;



@end
