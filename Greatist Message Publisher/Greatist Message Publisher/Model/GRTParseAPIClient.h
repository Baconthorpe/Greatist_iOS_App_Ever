//
//  GRTParseAPIClient.h
//  Greatist Message Publisher
//
//  Created by Ezekiel Abuhoff on 4/9/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GRTParseAPIClient : NSObject

- (void) getRelevantPostsWithCompletion:(void (^)(NSArray *))completion;
- (void) getValidResponsesWithCompletion:(void (^)(NSArray *))completion;

- (void) postPostWithContent: (NSString *)content
                     section: (NSString *)section
                    latitude: (CGFloat)latitude
                   longitude: (CGFloat)longitude
                      userID: (NSString *)userID;

@end
