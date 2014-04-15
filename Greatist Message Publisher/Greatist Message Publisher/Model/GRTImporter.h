//
//  GRTImporter.h
//  
//
//  Created by Ezekiel Abuhoff on 4/14/14.
//
//

#import <Foundation/Foundation.h>

@class Post;

@interface GRTImporter : NSObject

+ (Post *) interpretPostFromDictionary: (NSDictionary *)postDictionary
                        toContext: (NSManagedObjectContext *)context;

@end
