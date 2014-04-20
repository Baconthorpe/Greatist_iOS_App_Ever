//
//  Post.h
//  Greatist Message Publisher
//
//  Created by Leonard Li on 4/19/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ResponseOption, Section, User;

@interface Post : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSNumber * isFlagged;
@property (nonatomic, retain) NSString * objectId;
@property (nonatomic, retain) NSString * originType;
@property (nonatomic, retain) NSDate * timeStamp;
@property (nonatomic, retain) NSString * responses;
@property (nonatomic, retain) NSSet *responseOptions;
@property (nonatomic, retain) Section *section;
@property (nonatomic, retain) User *user;
@end

@interface Post (CoreDataGeneratedAccessors)

- (void)addResponseOptionsObject:(ResponseOption *)value;
- (void)removeResponseOptionsObject:(ResponseOption *)value;
- (void)addResponseOptions:(NSSet *)values;
- (void)removeResponseOptions:(NSSet *)values;

@end
