//
//  Response.h
//  Greatist Message Publisher
//
//  Created by Ezekiel Abuhoff on 4/8/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Post, User;

@interface Response : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSDate * timeStamp;
@property (nonatomic, retain) Post *post;
@property (nonatomic, retain) User *user;

@end
