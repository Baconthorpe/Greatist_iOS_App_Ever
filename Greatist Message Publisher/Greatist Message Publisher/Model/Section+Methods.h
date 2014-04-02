//
//  Section+Methods.h
//  Greatist Message Publisher
//
//  Created by Ezekiel Abuhoff on 4/2/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "Section.h"

@interface Section (Methods)


+ (instancetype) sectionWithName: (NSString *)name
                       inContext: (NSManagedObjectContext *)context;


@end
