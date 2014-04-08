//
//  Post.h
//  Greatist Message Publisher
//
//  Created by Ezekiel Abuhoff on 4/8/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Response, Section, User;

@interface Post : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSDate * timeStamp;
@property (nonatomic, retain) NSNumber * lonStamp;
@property (nonatomic, retain) NSNumber * latStamp;
@property (nonatomic, retain) NSString * originType;
@property (nonatomic, retain) NSSet *responses;
@property (nonatomic, retain) Section *section;
@property (nonatomic, retain) User *user;
@end

@interface Post (CoreDataGeneratedAccessors)

- (void)addResponsesObject:(Response *)value;
- (void)removeResponsesObject:(Response *)value;
- (void)addResponses:(NSSet *)values;
- (void)removeResponses:(NSSet *)values;

@end
