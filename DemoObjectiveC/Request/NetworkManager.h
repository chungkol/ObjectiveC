//
//  NetworkManager.h
//  Favor
//
//  Created by Tinhvv on 10/5/15.
//  Copyright © 2015 pape. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"
#import "ResponseObject.h"
@interface NetworkManager : AFHTTPRequestOperationManager
+ (instancetype)sharedManager;
- (void)updateUserProfile:(NSDictionary *)params avatar:(NSData *)avatarData completion:(void (^)(ResponseObject *))completion;
- (void)commentArticleWithID:(NSInteger)articleID params:(NSDictionary *)params image:(NSData *)imageData completion:(void (^)(ResponseObject *))completion;
- (void)replyCommentWithID:(NSInteger)commentID params:(NSDictionary *)params image:(NSData *)imageData completion:(void (^)(ResponseObject *))completion;
- (void)userPostArticleWithParams:(NSDictionary *)params image:(NSData *)imageData completion:(void (^)(ResponseObject *))completion;
- (void) userPostArticleWithParams:(NSDictionary *)params
                             image:(NSData *)imageData
                         isProduct:(BOOL)isProductrate
                        completion:(void (^)(ResponseObject *))completion;
- (void) sendAdsAnalytics:(NSString *)imageShow01
              imageShow20:(NSString *)imageShow20
            imageTapped01:(NSString *)imageTapped01
            imageTapped20:(NSString *)imageTapped20
              videoPlay01:(NSString *)videoPlay01
              videoPlay20:(NSString *)videoPlay20
            videoTapped01:(NSString *)videoTapped01
            videoTapped20:(NSString *)videoTapped20
              videoDone01:(NSString *)videoDone01
              videoDone20:(NSString *)videoDone20
         videoCompleted01:(NSString *)videoCompleted01
         videoCompleted20:(NSString *)videoCompleted20
               completion:(void (^)(ResponseObject *))completion;
- (void) sendAdsAnalytics:(NSDictionary *)data
               completion:(void (^)(ResponseObject *))completion;
- (void) sendAdsAstrarsAnalytics:(NSDictionary *)data
                      completion:(void (^)(ResponseObject *))completion;
@end
