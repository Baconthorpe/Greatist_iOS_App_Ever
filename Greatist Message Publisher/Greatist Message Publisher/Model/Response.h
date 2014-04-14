//
//  Response.h
//  Greatist Message Publisher
//
//  Created by Leonard Li on 4/11/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Post, ResponseOption, User;

@interface Response : NSManagedObject

@property (nonatomic, retain) Post *post;
@property (nonatomic, retain) User *user;
@property (nonatomic, retain) ResponseOption *responseOption;

@end
