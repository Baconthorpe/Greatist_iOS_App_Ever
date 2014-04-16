//
//  User.h
//  Greatist Message Publisher
//
//  Created by Ezekiel Abuhoff on 4/16/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Post, Response;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * facebookID;
@property (nonatomic, retain) NSNumber * latestLat;
@property (nonatomic, retain) NSNumber * latestLon;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * uniqueID;
@property (nonatomic, retain) NSNumber * isMe;
@property (nonatomic, retain) NSSet *posts;
@property (nonatomic, retain) NSSet *responses;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addPostsObject:(Post *)value;
- (void)removePostsObject:(Post *)value;
- (void)addPosts:(NSSet *)values;
- (void)removePosts:(NSSet *)values;

- (void)addResponsesObject:(Response *)value;
- (void)removeResponsesObject:(Response *)value;
- (void)addResponses:(NSSet *)values;
- (void)removeResponses:(NSSet *)values;

@end
