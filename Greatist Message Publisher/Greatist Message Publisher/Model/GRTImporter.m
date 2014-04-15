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
#import "User+Methods.h"
#import "Section+Methods.h"
#import "Response+Methods.h"
#import "ResponseOption+Methods.h"

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

+ (Post *) interpretPostFromDictionary: (NSDictionary *)postDictionary
                        toContext: (NSManagedObjectContext *)context
{
    NSDictionary *userDictionary = postDictionary[@"user"];
    User *authorUser = [User uniqueUserWithName:userDictionary[@"name"] uniqueID:userDictionary[@"uniqueID"] inContext:context];
    
    Section *section = [Section uniqueSectionWithName:postDictionary[@"section"] inContext:context];
    
    
    
    Post *newPost = [Post uniquePostWithContent:postDictionary[@"content"] author:authorUser section:section responses:nil timeStamp:nil inContext:context];
#warning Figure out how to turn a date from Parse into an NSDate, or else the time stamps for posts will never work
    
//    for (NSDictionary *responseDictionary in postDictionary[@"responses"])
//    {
//        Response *newResponse = [Response uniqueResponseWithResponseOption:<#(ResponseOption *)#> post:<#(Post *)#> author:<#(User *)#> inContext:<#(NSManagedObjectContext *)#>]
//    }
    
    return newPost;
}

+ (User *) interpretUserFromDictionary: (NSDictionary *)userDictionary
                        toContext: (NSManagedObjectContext *)context
{
    return [User uniqueUserWithName:userDictionary[@"name"] uniqueID:userDictionary[@"uniqueID"] inContext:context];
}

+ (Section *) interpretSectionFromDictionary: (NSDictionary *)sectionDictionary
                                   toContext: (NSManagedObjectContext *)context
{
    return [Section uniqueSectionWithName:sectionDictionary[@"name"] inContext:context];
}

+ (ResponseOption *) interpretResponseOptionFromDictionary: (NSDictionary *)responseOptionDictionary
                                                 toContext: (NSManagedObjectContext *)context
{
    return [ResponseOption uniqueResponseOptionWithContent:responseOptionDictionary[@"content"] inContext:context];
}

+ (Response *) interpretResponseFromDictionary: (NSDictionary *)responseDictionary
                                     toContext: (NSManagedObjectContext *)context
{
//    return [Response uniqueResponseWithResponseOption:<#(ResponseOption *)#> post:<#(Post *)#> author:<#(User *)#> inContext:<#(NSManagedObjectContext *)#>]
    return nil;
}

@end
