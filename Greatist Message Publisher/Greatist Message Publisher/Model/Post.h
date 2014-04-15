//
//  Post.h
//  Greatist Message Publisher
//
//  Created by Ezekiel Abuhoff on 4/15/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Response, ResponseOption, Section, User;

@interface Post : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSNumber * latStamp;
@property (nonatomic, retain) NSNumber * lonStamp;
@property (nonatomic, retain) NSString * originType;
@property (nonatomic, retain) NSDate * timeStamp;
@property (nonatomic, retain) NSSet *responses;
@property (nonatomic, retain) Section *section;
@property (nonatomic, retain) User *user;
@property (nonatomic, retain) NSSet *responseOptions;
@end

@interface Post (CoreDataGeneratedAccessors)

- (void)addResponsesObject:(Response *)value;
- (void)removeResponsesObject:(Response *)value;
- (void)addResponses:(NSSet *)values;
- (void)removeResponses:(NSSet *)values;

- (void)addResponseOptionsObject:(ResponseOption *)value;
- (void)removeResponseOptionsObject:(ResponseOption *)value;
- (void)addResponseOptions:(NSSet *)values;
- (void)removeResponseOptions:(NSSet *)values;

@end
