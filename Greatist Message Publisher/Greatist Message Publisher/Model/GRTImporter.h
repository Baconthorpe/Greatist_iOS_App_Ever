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

+ (Post *) savePostFromDictionary: (NSDictionary *)postDictionary
                        toContext: (NSManagedObjectContext *)context;

@end
