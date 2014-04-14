//
//  GRTImporter.m
//  
//
//  Created by Ezekiel Abuhoff on 4/14/14.
//
//

#import "GRTImporter.h"
#import "Response+Methods.h"
#import "Post+Methods.h"

@implementation GRTImporter

//+ (Response *) saveResponseFromDictionary: (NSDictionary *)responseDictionary
//                          toContext: (NSManagedObjectContext *)context
//{
//    return nil;
//}
//
//+ (Post *) savePostFromDictionary: (NSDictionary *)postDictionary
//                        toContext: (NSManagedObjectContext *)context
//{
//    NSMutableSet *responseSet = [NSMutableSet new];
//    
//    for (NSDictionary *response in postDictionary[@"responses"])
//    {
//        Response *newResponse = [Response responseWithResponseOption:<#(ResponseOption *)#> post:nil author:<#(User *)#> inContext:<#(NSManagedObjectContext *)#>]
//    }
//    
//    Post *newPost = [Post postWithContent:postDictionary[@"content"] author:postDictionary[@"author"] section:postDictionary[@"section"] responses:<#(NSSet *)#> inContext:context];
//    
//    return nil;
//}

+ (Post *) savePostFromDictionary: (NSDictionary *)postDictionary
                        toContext: (NSManagedObjectContext *)context
{
    Post *newPost = [Post postWithContent:postDictionary[@""] author:postDictionary[@"author"] section:postDictionary[@"section"] responses:nil inContext:context];
    
    return newPost;
}

@end
