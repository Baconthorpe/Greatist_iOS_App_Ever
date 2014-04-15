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
    User *user = [GRTImporter interpretUserFromDictionary:postDictionary[@"user"] toContext:context];
    
    Section *section = [GRTImporter interpretSectionFromDictionary:postDictionary[@"section"] toContext:context];
    
    Post *newPost = [Post uniquePostWithContent:postDictionary[@"content"] author:user section:section responses:nil timeStamp:nil inContext:context];
    
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
    ResponseOption *responseOption = [ResponseOption uniqueResponseOptionWithContent:responseDictionary[@"content"] inContext:context];
    
    return [Response uniqueResponseWithResponseOption:responseOption post:nil author:nil inContext:context];
}

@end
