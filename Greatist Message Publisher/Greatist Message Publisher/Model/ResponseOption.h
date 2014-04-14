//
//  ResponseOption.h
//  Greatist Message Publisher
//
//  Created by Leonard Li on 4/11/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Response;

@interface ResponseOption : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSSet *responses;
@end

@interface ResponseOption (CoreDataGeneratedAccessors)

- (void)addResponsesObject:(Response *)value;
- (void)removeResponsesObject:(Response *)value;
- (void)addResponses:(NSSet *)values;
- (void)removeResponses:(NSSet *)values;

@end
