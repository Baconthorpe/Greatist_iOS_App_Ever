//
//  Section.h
//  Greatist Message Publisher
//
//  Created by Ezekiel Abuhoff on 4/8/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Article, Post;

@interface Section : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *articles;
@property (nonatomic, retain) NSSet *posts;
@end

@interface Section (CoreDataGeneratedAccessors)

- (void)addArticlesObject:(Article *)value;
- (void)removeArticlesObject:(Article *)value;
- (void)addArticles:(NSSet *)values;
- (void)removeArticles:(NSSet *)values;

- (void)addPostsObject:(Post *)value;
- (void)removePostsObject:(Post *)value;
- (void)addPosts:(NSSet *)values;
- (void)removePosts:(NSSet *)values;

@end
