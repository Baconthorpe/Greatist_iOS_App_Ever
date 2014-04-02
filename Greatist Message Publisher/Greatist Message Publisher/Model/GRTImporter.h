//
//  GRTImporter.h
//  Greatist Message Publisher
//
//  Created by Ezekiel Abuhoff on 4/2/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Post;

@interface GRTImporter : NSObject

+ (NSDictionary *) responsesDictionaryOfPost: (Post *)post;

@end
