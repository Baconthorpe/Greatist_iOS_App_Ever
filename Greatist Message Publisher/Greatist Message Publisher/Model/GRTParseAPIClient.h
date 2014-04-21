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

// GRTUser
- (void)getUsersWithCompletion:(void (^)(NSArray *users))completionBlock;

- (void) postUserWithFacebookID:(NSString *)fbookID
                     Completion:(void (^)(NSDictionary *))completion;
- (void) postUserWithName:(NSString *)name
               FacebookID:(NSString *)fbookID
               Completion:(void (^)(NSDictionary *))completion;

// GRTPosts
- (void) getPostsWithFriendIDs:(NSArray *)friendsArray
                WithCompletion:(void (^)(NSArray *posts))completionBlock;
- (void) getPostForPostID:(NSString *)postObjectID
           withCompletion:(void (^)(NSDictionary *postDictionary))completion;
- (void) postPostWithContent: (NSString *)content
                     section: (NSString *)section
                   responses: (NSString *)responseDictionaryString
              userFacebookID: (NSString *)userFacebookID
              usersResponded: (NSString *)usersRespondedDictionary
              withCompletion: (void (^)(NSDictionary *))completion;
- (void) flagPostID:(NSString *)postObjectID
     withCompletion:(void (^)(NSDictionary *))completion;

// GRTResponse
- (void) getValidResponsesWithCompletion:(void (^)(NSArray *))completion;
- (void) updatePostID:(NSString *)postObjectID
        withResponses:(NSString *)responseString
   withUsersResponded:(NSString *)usersRespondedString
       withCompletion:(void (^)(NSString *updatedAt))completion;
@end
