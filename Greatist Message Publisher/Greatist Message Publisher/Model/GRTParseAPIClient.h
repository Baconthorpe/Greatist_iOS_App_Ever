//
//  GRTParseAPIClient.h
//  Greatist Message Publisher
//
//  Created by Ezekiel Abuhoff on 4/9/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Post.h"

@interface GRTParseAPIClient : NSObject

+ (instancetype)sharedClient;

- (void) getRelevantPostsWithCompletion:(void (^)(NSArray *))completion;
- (void) getValidResponsesWithCompletion:(void (^)(NSArray *))completion;

- (void) postPostWithContent: (NSString *)content
                     section: (NSString *)section
                    latitude: (CGFloat)latitude
                   longitude: (CGFloat)longitude
                      userID: (NSString *)userID;
- (void) putPost: (Post *)post;

- (void) postResponseWithContent: (NSString *)content
                       timeStamp: (NSDate *)timeStamp
                          userID: (NSString *)userID
                            post: (NSString *)post;

// GRTUser
- (void) postUserWithName:(NSString *)name
                  FbookID:(NSString *)fbookID;

                   
@end
