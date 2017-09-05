//
//  Requester.m
//  Favor
//
//  Created by vudinhthuy on 6/9/15.
//  Copyright (c) 2015 pape. All rights reserved.
//

#import "HttpRequester.h"
#import "LanguageOption.h"

#define API_USERNAME @"papelook"
#define API_PASSWORD @"pape0321ozawa"

@implementation HttpRequester

static HttpRequester *_requester;

+(instancetype) requester{
    if (!_requester) {
        _requester = [[HttpRequester alloc] init];
    }
    
    return _requester;
}


-(id) init{
    if (self = [super init]) {
        NSString *baseURL = @"http://api.favor.life";
        
        if (SERVER_TYPE == TEST_SERVER) {
            baseURL = @"http://rikkei.org:8888";
        }else if (SERVER_TYPE == DEV_SERVER){
            baseURL = @"http://api.dev.favor.life";
        }else if(SERVER_TYPE == STG_SERVER){
            baseURL = @"http://api.stg.favor.life";
        }else if (SERVER_TYPE == LOCAL_SERVER){
            baseURL = @"http://192.168.11.91:4000";
        }
        
        NSLog(@"%@", baseURL);
        
        _requestManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:baseURL]];
        _requestManager.credential = [NSURLCredential credentialWithUser:API_USERNAME password:API_PASSWORD persistence:NSURLCredentialPersistenceForSession];
        [_requestManager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringCacheData];
        [_requestManager.requestSerializer setTimeoutInterval:30];
    }
    
    return self;
}




-(void) requestNewListArticlesByPage:(int) page responseHandler:(HttpRequesterHandler) handler{
    ShowNetworkActivityIndicator();//@{@"locale" : [Util getLocale]}
    [_requestManager GET:[NSString stringWithFormat:@"articles/new/%i.json", page] parameters:[self prepareParams:@{@"locale":[Util getLocale]}] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
        HideNetworkActivityIndicator();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"AF Error: %@", error);
        handler(NO, nil);
        HideNetworkActivityIndicator();
    }];
}

-(void) requestHotListArticlesByPage:(int) page responseHandler:(HttpRequesterHandler) handler{
    ShowNetworkActivityIndicator();
    [_requestManager GET:[NSString stringWithFormat:@"articles/hot/%i.json", page] parameters:[self prepareParams:@{@"locale" : [Util getLocale]}] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
        HideNetworkActivityIndicator();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"AF Error: %@", error);
        handler(NO, nil);
        HideNetworkActivityIndicator();
    }];
}


-(void) requestArticleDetailWithArticleID: (int)articleID andNoti:(int)notiId andResult:(HttpRequesterHandler) handler{
    ShowNetworkActivityIndicator();
    NSDictionary *params = [[NSMutableDictionary alloc] init];
    if (notiId > 0) {
        params = [self prepareParams:@{@"noti_id":[NSNumber numberWithInt:notiId], @"locale" : [Util getLocale], @"with_html": [NSNumber numberWithBool:YES]}];
    }else{
        params = [self prepareParams:@{@"locale" : [Util getLocale], @"with_html": [NSNumber numberWithBool:YES]}];
    }
    [_requestManager GET:[NSString stringWithFormat:@"articles/%d.json", articleID] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
        HideNetworkActivityIndicator();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"AF Error: %@", error);
        handler(NO, nil);
        HideNetworkActivityIndicator();
    }];
}

- (void)requestPR_ArticleDetailWithArticleID:(int)articleID andNoti:(int)notiId andResult:(HttpRequesterHandler)handler {
    ShowNetworkActivityIndicator();
    NSDictionary *params = [[NSMutableDictionary alloc] init];
    if (notiId > 0) {
        params = [self prepareParams:@{@"noti_id":[NSNumber numberWithInt:notiId], @"locale" : [Util getLocale], @"with_html": [NSNumber numberWithBool:YES], @"click_pr": [NSNumber numberWithInt:1]}];
    }else{
        params = [self prepareParams:@{@"locale" : [Util getLocale], @"with_html": [NSNumber numberWithBool:YES], @"click_pr": [NSNumber numberWithInt:1]}];
    }
    [_requestManager GET:[NSString stringWithFormat:@"articles/%d.json", articleID] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
        HideNetworkActivityIndicator();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"AF Error: %@", error);
        handler(NO, nil);
        HideNetworkActivityIndicator();
    }];
}
-(void) requestCreateUser:(HttpRequesterHandler) handler{
    [_requestManager POST:@"/users" parameters:@{@"app_version": APP_VERSION, @"client_type": CLIENT_TYPE} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        handler(NO, nil);
    }];
}

-(void) requestUpdateUserInfos:(NSDictionary *) infos responseHandler:(HttpRequesterHandler) handler{
    [_requestManager POST:@"/users" parameters:[self prepareParams:infos] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        handler(NO, nil);
    }];
}

-(void) requestUpdateDeviceToken{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if ([user objectForKey:FAVOR_DEVICE_TOKEN]) {
        [_requestManager POST:@"/users" parameters:[self prepareParams:@{@"device_token": [user objectForKey:FAVOR_DEVICE_TOKEN]}] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@", error);
        }];
    }
}

-(void) requestGetUserInfos:(NSInteger) userID responseHandler:(HttpRequesterHandler) handler{
    [_requestManager GET:[NSString stringWithFormat:@"/users/%li", (long)userID] parameters:[self prepareParams:@{@"locale" : [Util getLocale]}] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        handler(NO, nil);
    }];
}


-(void) requestAddNewComment:(NSDictionary *) commentInfos article:(NSInteger) articleId responseHandler:(HttpRequesterHandler) handler{
    ShowNetworkActivityIndicator();
    [_requestManager POST:[NSString stringWithFormat:@"/articles/%li/add_comment", (long)articleId]
               parameters:[self prepareParams:commentInfos]
                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
         handler(YES, responseObject);
        HideNetworkActivityIndicator();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"%@", error);
        handler(NO, nil);
        HideNetworkActivityIndicator();
    }];
}

-(void) requestLikeArticle:(NSInteger) articleId responseHandler:(HttpRequesterHandler) handler{
    ShowNetworkActivityIndicator();
    [_requestManager POST:[NSString stringWithFormat:@"/articles/%li/add_favorite", (long)articleId]
               parameters:[self prepareParams:nil]
                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
        HideNetworkActivityIndicator();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
         NSLog(@"%@", error);
         handler(NO, nil);
        HideNetworkActivityIndicator();
     }];
}

-(void) requestAllCommentOfArticle: (int)articleId responseHadle:(HttpRequesterHandler) handler{
    ShowNetworkActivityIndicator();
    [_requestManager GET:[NSString stringWithFormat:@"/articles/%d/comments", articleId] parameters:[self prepareParams:nil] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
        HideNetworkActivityIndicator();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        handler(NO, nil);
        HideNetworkActivityIndicator();
    }];
}

-(void) requestAllCommentOfArticleByNotification: (int)articleId notiId:(int) notiId responseHadle:(HttpRequesterHandler) handler{
    ShowNetworkActivityIndicator();
    NSDictionary *params = [[NSDictionary alloc] init];
    if (notiId > 0) {
        params = [self prepareParams:@{@"noti_id": [NSNumber numberWithInt:notiId]}];
    }else{
        params = [self prepareParams:nil];
    }
    [_requestManager GET:[NSString stringWithFormat:@"/articles/%d/comments", articleId] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
        HideNetworkActivityIndicator();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        handler(NO, nil);
        HideNetworkActivityIndicator();
    }];
}

-(void) requestAllBrands:(HttpRequesterHandler) handler{
    ShowNetworkActivityIndicator();
    [_requestManager GET:@"/brands" parameters:[self prepareParams:nil]
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
        HideNetworkActivityIndicator();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        handler(NO, nil);
        HideNetworkActivityIndicator();
    }];
}

- (void)requestAllBrandsGrouped:(HttpRequesterHandler)handler {
    ShowNetworkActivityIndicator();
    [_requestManager GET:@"/group_brands" parameters:[self prepareParams:nil]
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     handler(YES, responseObject);
                     HideNetworkActivityIndicator();
                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     NSLog(@"%@", error);
                     handler(NO, nil);
                     HideNetworkActivityIndicator();
                 }];
}

-(void) requestAllCatefory:(HttpRequesterHandler) handler{
    ShowNetworkActivityIndicator();
    [_requestManager GET:@"/categories"
              parameters:[self prepareParams:nil]
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
        HideNetworkActivityIndicator();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        handler(NO, nil);
        HideNetworkActivityIndicator();
    }];
}

-(void) requestCategoryWithBrand: (int)brandId responseHadle:(HttpRequesterHandler) handler{
    ShowNetworkActivityIndicator();
    [_requestManager GET:[NSString stringWithFormat:@"/brands/%d/categories", brandId]
              parameters:[self prepareParams:nil]
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
        HideNetworkActivityIndicator();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        handler(NO, nil);
        HideNetworkActivityIndicator();
    }];
}


-(void) requestListLikedArticle:(int) page type:(NSString *)type responseHadle:(HttpRequesterHandler)handler{
    ShowNetworkActivityIndicator();
    [_requestManager GET:[NSString stringWithFormat:@"/users/list_favorites/%i.json", page] parameters:[self prepareParams:@{@"type": type}] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
        HideNetworkActivityIndicator();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        handler(NO, nil);
        HideNetworkActivityIndicator();
    }];
}

-(void) requestSearchInfo:(HttpRequesterHandler) handler{
    ShowNetworkActivityIndicator();
    [_requestManager GET:@"/search" parameters:[self prepareParams:@{@"locale" : [Util getLocale]}] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
        HideNetworkActivityIndicator();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        handler(NO, nil);
        HideNetworkActivityIndicator();
    }];
}

-(void) requestArticleByTag: (int) tagId atPage:(int)page isCuration:(BOOL)isTrue andHanler:(HttpRequesterHandler) handler{
    ShowNetworkActivityIndicator();
    [_requestManager GET:[NSString stringWithFormat:@"/articles/tag/%d/%d", tagId, page] parameters:[self prepareParams:@{@"locale" : [Util getLocale],@"curation":[NSNumber numberWithBool:isTrue]}] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
        HideNetworkActivityIndicator();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        handler(NO, nil);
        HideNetworkActivityIndicator();
    }];
}

-(void) requestArticleByBrandId: (int)brandId andCategoryId: (int)categoryId atPage:(int)page isCuration:(BOOL)isTrue andHanler:(HttpRequesterHandler) handler{
    ShowNetworkActivityIndicator();
    [_requestManager GET:[NSString stringWithFormat:@"/articles/%d/%d/%d.json", brandId, categoryId, page] parameters:[self prepareParams:@{@"locale" : [Util getLocale],@"curation":[NSNumber numberWithBool:isTrue]}] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
        HideNetworkActivityIndicator();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        handler(NO, nil);
        HideNetworkActivityIndicator();
    }];
}

-(void) requestCheckCss:(NSString *) filename andHanler:(HttpRequesterHandler) handler{
    NSString *path = nil;
    if (filename) {
        path = [NSString stringWithFormat:@"/checkcss?filename=%@", filename];
    }else{
        path = @"/checkcss";
    }
    
    [_requestManager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        handler(NO, nil);
    }];
}


-(void) requestCheckUpdateNewListWithLastId: (int) articleId andResult:(HttpRequesterHandler) handler{
    ShowNetworkActivityIndicator();
    [_requestManager GET:[NSString stringWithFormat:@"/update_new_articles?article_id=%i", articleId] parameters:[self prepareParams:@{@"locale" : [Util getLocale]}] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
        HideNetworkActivityIndicator();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"AF Error: %@", error);
        handler(NO, nil);
        HideNetworkActivityIndicator();
    }];
}

-(void) likeCommentWithId:(int)commentId andResult:(HttpRequesterHandler) handler{
    ShowNetworkActivityIndicator();
    [_requestManager POST:[NSString stringWithFormat:@"/comments/%d/add_favorite", commentId] parameters:[self prepareParams:nil] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
        HideNetworkActivityIndicator();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        handler(NO, nil);
        HideNetworkActivityIndicator();
    }];
}

-(void) requestWriterInfo: (int) writerId atPage:(int)page andHanler:(HttpRequesterHandler) handler{
    ShowNetworkActivityIndicator();
    [_requestManager GET:[NSString stringWithFormat:@"/writer/%d/%d", writerId, page] parameters:[self prepareParams:@{@"locale" : [Util getLocale]}] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
        HideNetworkActivityIndicator();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        handler(NO, nil);
        HideNetworkActivityIndicator();
    }];
}

-(void) requestNotificationList:(int) page responseHandler:(HttpRequesterHandler) handler{
    ShowNetworkActivityIndicator();
    [_requestManager GET:[NSString stringWithFormat:@"/notifications/%i", page] parameters:[self prepareParams:nil] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
        HideNetworkActivityIndicator();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"%@", error);
        handler(NO, nil);
        HideNetworkActivityIndicator();
    }];
}

-(void) requestNotificationCountWithResponseHandler:(HttpRequesterHandler) handler{
    [_requestManager GET:@"/notifications_unread" parameters:[self prepareParams:nil] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"%@", error);
        handler(NO, nil);
    }];
}

-(void) requestReplyComment:(int)commentId with:(NSDictionary *)replyInfor responseHandler:(HttpRequesterHandler) handler{
    ShowNetworkActivityIndicator();
    [_requestManager POST:[NSString stringWithFormat:@"/comments/%d/add_reply",commentId]
               parameters:[self prepareParams:replyInfor]
                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                      handler(YES, responseObject);
                      HideNetworkActivityIndicator();
                  } failure:^(AFHTTPRequestOperation *operation, NSError *error){
                      NSLog(@"%@", error);
                      handler(NO, nil);
                      HideNetworkActivityIndicator();
                  }];
}

-(void) requestNewListUserArticlesByPage:(int) page responseHandler:(HttpRequesterHandler) handler{
    ShowNetworkActivityIndicator();
    [_requestManager GET:[NSString stringWithFormat:@"articles/new/%i.json", page] parameters:[self prepareParams:@{@"type":@"user"}] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
        HideNetworkActivityIndicator();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"AF Error: %@", error);
        handler(NO, nil);
        HideNetworkActivityIndicator();
    }];
}

-(void) requestHotListUserArticlesByPage:(int) page responseHandler:(HttpRequesterHandler) handler{
    ShowNetworkActivityIndicator();
    [_requestManager GET:[NSString stringWithFormat:@"articles/hot/%i.json", page] parameters:[self prepareParams:@{@"type":@"user"}] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
        HideNetworkActivityIndicator();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"AF Error: %@", error);
        handler(NO, nil);
        HideNetworkActivityIndicator();
    }];
}

-(NSDictionary *) prepareParams:(NSDictionary *) input{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (input) {
        [params addEntriesFromDictionary:input];
    }
    
    [params setObject:[Util getAppVersion] forKey:@"app_version"];
    [params setObject:CLIENT_TYPE forKey:@"client_type"];
    
    if (favorUser.token) {
        [params setObject:favorUser.token forKey:@"token"];
    }
    if (favorUser.userId > 0) {
        [params setObject:[NSNumber numberWithInteger:favorUser.userId] forKey:@"user_id"];
    }
    if (![[input allKeys] containsObject:@"locale"]) {
         [params setObject:[Util getLocale] forKey:@"locale"];
    }
    [params setObject:[NSNumber numberWithInteger:[Util settingLanguage]]
               forKey:@"type_language"];
    return params;
}

#pragma mark - Version 1.1.0
- (void) requestUserPostArticle:(NSDictionary *)info responseHandler:(HttpRequesterHandler)handler{
    ShowNetworkActivityIndicator();
    NSLog(@"Params: %@", [self prepareParams:info]);
    [_requestManager POST:@"/articles" parameters:[self prepareParams:info] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES,responseObject);
        HideNetworkActivityIndicator();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        handler(NO, nil);
        HideNetworkActivityIndicator();
    }];
}

- (void) requestWriterInfo:(int)writerId atPage:(int)page type:(NSString *)type andHanler:(HttpRequesterHandler)handler{
    ShowNetworkActivityIndicator();
    [_requestManager GET:[NSString stringWithFormat:@"/writer/%d/%d", writerId, page] parameters:[self prepareParams:@{@"type" : type}] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
        HideNetworkActivityIndicator();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        handler(NO, nil);
        HideNetworkActivityIndicator();
    }];
}


- (void) requestSampleArticleWithID:(int)articleID atPage:(int)page type:(NSString *)type andHanler:(HttpRequesterHandler)handler{
   ShowNetworkActivityIndicator();
    [_requestManager GET:[NSString stringWithFormat:@"products/related_article/%d", page] parameters:[self prepareParams:@{@"type" : type,
                                                                                                                           @"product_id" : [NSNumber numberWithInt:articleID]}] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
        HideNetworkActivityIndicator();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        handler(NO, nil);
        HideNetworkActivityIndicator();
    }];

}
    
-(void) requestUserArticleByTag: (int) tagId atPage:(int)page andHanler:(HttpRequesterHandler) handler{
    ShowNetworkActivityIndicator();
    [_requestManager GET:[NSString stringWithFormat:@"/articles/tag/%d/%d", tagId, page] parameters:[self prepareParams:@{@"type": @"user"}] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
        HideNetworkActivityIndicator();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        handler(NO, nil);
        HideNetworkActivityIndicator();
    }];
}

- (void)requestUserArticleByBigCategory:(int)tagId atPage:(int)page withUserId:(NSInteger)userId andHanler:(HttpRequesterHandler) handler {
    ShowNetworkActivityIndicator();
    [_requestManager GET:[NSString stringWithFormat:@"/articles/tag/%d/%ld/%d", tagId, (long)userId, page] parameters:[self prepareParams:@{@"type": @"user"}] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
        HideNetworkActivityIndicator();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        handler(NO, nil);
        HideNetworkActivityIndicator();
    }];
}

//Ver 1.1.0: Get list users liked comment
- (void)requestListUsersLikedArticle:(int)articleId andHandler:(HttpRequesterHandler) handler {
    ShowNetworkActivityIndicator();
    [_requestManager GET:[NSString stringWithFormat:@"/articles/%d/list_users_favorited", articleId]
              parameters:[self prepareParams:nil]
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
        HideNetworkActivityIndicator();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        handler(NO, nil);
        HideNetworkActivityIndicator();
    }];
}

-(void) requestCheckUpdateNewUserArticleListWithLastId: (int) articleId andResult:(HttpRequesterHandler) handler{
    ShowNetworkActivityIndicator();
    [_requestManager GET:[NSString stringWithFormat:@"/update_new_articles?article_id=%i", articleId] parameters:[self prepareParams:@{@"type":@"user"}] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
        HideNetworkActivityIndicator();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"AF Error: %@", error);
        handler(NO, nil);
        HideNetworkActivityIndicator();
    }];
}

/**
 *  Ver 1.1.0.1
 */

- (void) requestListAdsWithUserType:(NSString *)type responseHandler:(HttpRequesterHandler)handler{
    ShowNetworkActivityIndicator();
    [_requestManager GET:$S(@"advertisments/get_advertisments?type=%@",type) parameters:[self prepareParams:@{@"locale":[Util getLocale]}] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
        HideNetworkActivityIndicator();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"AF Error: %@", error);
        handler(NO, nil);
        HideNetworkActivityIndicator();
    }];
}

- (void)requestUpdateArticle:(NSDictionary *)params andResult:(HttpRequesterHandler) handler{
    ShowNetworkActivityIndicator();
    [_requestManager POST:@"/articles/update" parameters:[self prepareParams:params] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
        HideNetworkActivityIndicator();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"AF Error: %@", error);
        handler(NO, nil);
        HideNetworkActivityIndicator();
    }];
}
- (void)requestDeleteArticle:(int)articleId andResult:(HttpRequesterHandler) handler{
    ShowNetworkActivityIndicator();
    [_requestManager POST:@"/articles/destroy" parameters:[self prepareParams:@{@"id":[NSNumber numberWithInt:articleId]}] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
        HideNetworkActivityIndicator();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"AF Error: %@", error);
        handler(NO, nil);
        HideNetworkActivityIndicator();
    }];
}

- (void)requestUpdateNotification:(int)notiId andResult:(HttpRequesterHandler) handler{
    ShowNetworkActivityIndicator();
    [_requestManager GET:[NSString stringWithFormat:@"/notifications/%d/update_status", notiId] parameters:[self prepareParams:nil] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
        HideNetworkActivityIndicator();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"AF Error: %@", error);
        handler(NO, nil);
        HideNetworkActivityIndicator();
    }];
}

- (void)requestUpdateNotificationPush:(int)notiId andResult:(HttpRequesterHandler) handler{
    ShowNetworkActivityIndicator();
    [_requestManager GET:[NSString stringWithFormat:@"/notifications/%d/udpate_read_push", notiId] parameters:[self prepareParams:nil] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
        HideNetworkActivityIndicator();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"AF Error: %@", error);
        handler(NO, nil);
        HideNetworkActivityIndicator();
    }];
}

- (void)requestClearBadge{
    ShowNetworkActivityIndicator();
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [_requestManager POST:@"/notifications/clear" parameters:[self prepareParams:nil] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        HideNetworkActivityIndicator();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"AF Error: %@", error);
        HideNetworkActivityIndicator();
    }];
}

- (void) requestAllTabInfoResult:(HttpRequesterHandler) handler{
    ShowNetworkActivityIndicator();
    [_requestManager GET:@"/articles/index_new" parameters:[self prepareParams:nil] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
        HideNetworkActivityIndicator();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        handler(NO, nil);
        NSLog(@"AF Error: %@", error);
        HideNetworkActivityIndicator();
    }];
}

- (void) requestCheckUpdateTabWithTabIndex: (int)tabIndex lastArticle: (int)articleId andResult:(HttpRequesterHandler) handler{
    ShowNetworkActivityIndicator();
    [_requestManager GET:[NSString stringWithFormat:@"/update_articles_tab?article_id=%i&tab_id=%i", articleId, tabIndex] parameters:[self prepareParams:@{@"locale" : [Util getLocale]}] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
        HideNetworkActivityIndicator();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"AF Error: %@", error);
        handler(NO, nil);
        HideNetworkActivityIndicator();
    }];
}

- (void) requestArticlesAtTabWithTabIndex: (int)tabIndex andResult:(HttpRequesterHandler) handler{
    ShowNetworkActivityIndicator();
    [_requestManager GET:[NSString stringWithFormat:@"/articles/refresh/%d", tabIndex] parameters:[self prepareParams:@{@"locale" : [Util getLocale]}] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
        HideNetworkActivityIndicator();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"AF Error: %@", error);
        handler(NO, nil);
        HideNetworkActivityIndicator();
    }];
}

- (void) requestLoadMoreArticleAtTabWithTabIndex: (int)tabIndex fromArticle: (int)articleId andResult:(HttpRequesterHandler) handler{
    ShowNetworkActivityIndicator();
    [_requestManager GET:[NSString stringWithFormat:@"/articles/loadmore/%d/%d",articleId, tabIndex] parameters:[self prepareParams:@{@"locale" : [Util getLocale]}] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
        HideNetworkActivityIndicator();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"AF Error: %@", error);
        handler(NO, nil);
        HideNetworkActivityIndicator();
    }];
}

- (void)requestDataForHistoryTab:(int)historyId andResult:(HttpRequesterHandler)handler {
    ShowNetworkActivityIndicator();
    NSString *url = @"/history";
    if (historyId > 0) {
        url = [NSString stringWithFormat:@"/history?last_history_id=%d", historyId];
    }
    [_requestManager GET:url parameters:[self prepareParams:@{@"locale" : [Util getLocale]}] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
        HideNetworkActivityIndicator();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"AF Error: %@", error);
        handler(NO, nil);
        HideNetworkActivityIndicator();
    }];

}

- (void) requestCheckTimeLineWithLastUpdate:(NSString *)lastUpdate andResult:(HttpRequesterHandler) handler{
    ShowNetworkActivityIndicator();
    [_requestManager GET:@"/articles/check_timeline" parameters:[self prepareParams:@{@"locale" : [Util getLocale],@"time_update" : lastUpdate}] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
        HideNetworkActivityIndicator();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"AF Error: %@", error);
        handler(NO, nil);
        HideNetworkActivityIndicator();
    }];
}

- (void) requestAllProduct:(HttpRequesterHandler) handler{
    ShowNetworkActivityIndicator();
    [_requestManager GET:@"/list_tag_products" parameters:[self prepareParams:nil] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
        HideNetworkActivityIndicator();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        handler(NO, nil);
        HideNetworkActivityIndicator();
    }];
}

- (void) requestAllTags:(HttpRequesterHandler) handler{
    ShowNetworkActivityIndicator();
    [_requestManager GET:@"/get_tags" parameters:[self prepareParams:nil] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
        HideNetworkActivityIndicator();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        handler(NO, nil);
        HideNetworkActivityIndicator();
    }];
}

- (void) requestCategoriesOfProductByBrandId:(int)brandId andCompletion:(HttpRequesterHandler) handler{
    ShowNetworkActivityIndicator();
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:brandId] forKey:@"brand_id"];
    [_requestManager GET:@"/category_of_brand" parameters:[self prepareParams:params] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
        HideNetworkActivityIndicator();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        handler(NO, nil);
        HideNetworkActivityIndicator();
    }];
}

- (void) requestProductsByBrandId:(int)brandId withCategory:(int)catId andCompletion:(HttpRequesterHandler) handler{
    ShowNetworkActivityIndicator();
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:brandId] forKey:@"brand_id"];
    [params setObject:[NSNumber numberWithInt:catId] forKey:@"category_id"];
    [_requestManager GET:@"/product_of_tag" parameters:[self prepareParams:params] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
        HideNetworkActivityIndicator();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        handler(NO, nil);
        HideNetworkActivityIndicator();
    }];
}

- (void) requestUpdateFollowStateAuthor:(int)authorId andCompletion:(HttpRequesterHandler) handler{
    ShowNetworkActivityIndicator();
    [_requestManager POST:@"/users/follow"
               parameters:[self prepareParams:@{@"author_id" : [NSNumber numberWithInt:authorId]}]
                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
        HideNetworkActivityIndicator();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        handler(NO, nil);
        HideNetworkActivityIndicator();
    }];
}

- (void) requestSyncTagData: (HttpRequesterHandler) handler{
    ShowNetworkActivityIndicator();
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    double last_time = [defaults doubleForKey:@"last_time"];
    BOOL didUpdate = [defaults boolForKey:@"kUpdateDB"];
    if (!didUpdate) {
        [params setObject:[NSNumber numberWithBool:didUpdate] forKey:@"isUpdate"];
    }
    [params setObject:[NSNumber numberWithDouble:last_time] forKey:@"last_time"];
    [_requestManager GET:@"/check_tag" parameters:[self prepareParams:params] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
        if (!didUpdate) {
            [defaults setBool:YES forKey:@"kUpdateDB"];
            [defaults synchronize];
        }
        HideNetworkActivityIndicator();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        handler(NO, nil);
        HideNetworkActivityIndicator();
    }];
}

- (void) requestProductDetail:(int)productId andCompletion:(HttpRequesterHandler) handler{
    ShowNetworkActivityIndicator();
    [_requestManager GET:[NSString stringWithFormat:@"/products/%d", productId]
              parameters:[self prepareParams:nil]
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
        HideNetworkActivityIndicator();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        handler(NO, nil);
        HideNetworkActivityIndicator();
    }];
}

- (void) requestAuthorInfo: (int)authorId andCompletion:(HttpRequesterHandler) handler{
    ShowNetworkActivityIndicator();
    [_requestManager GET:[NSString stringWithFormat:@"/api/mobile/v118/writer/%d", authorId]
              parameters:[self prepareParams:nil]
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     handler(YES, responseObject);
                     HideNetworkActivityIndicator();
                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     NSLog(@"%@", error);
                     handler(NO, nil);
                     HideNetworkActivityIndicator();
                 }];
}

- (void) requestAuthorWriterPostInfo: (int)authorId andPage:(int)page andCompletion:(HttpRequesterHandler) handler{
    ShowNetworkActivityIndicator();
    [_requestManager GET:[NSString stringWithFormat:@"/api/mobile/v118/writer_post_articles/%d/%d", authorId, page]
              parameters:[self prepareParams:nil]
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     handler(YES, responseObject);
                     HideNetworkActivityIndicator();
                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     NSLog(@"%@", error);
                     handler(NO, nil);
                     HideNetworkActivityIndicator();
                 }];
}

- (void) requestAuthorFavouritedWriterPostInfo: (int)authorId andPage:(int)page andCompletion:(HttpRequesterHandler) handler{
    ShowNetworkActivityIndicator();
    [_requestManager GET:[NSString stringWithFormat:@"/api/mobile/v118/writer_like_articles/%d/%d", authorId, page]
              parameters:[self prepareParams:nil]
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     handler(YES, responseObject);
                     HideNetworkActivityIndicator();
                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     NSLog(@"%@", error);
                     handler(NO, nil);
                     HideNetworkActivityIndicator();
                 }];
}

- (void) requestAuthorFavouritedUserPostInfo: (int)authorId andPage:(int)page andCompletion:(HttpRequesterHandler) handler{
    ShowNetworkActivityIndicator();
    [_requestManager GET:[NSString stringWithFormat:@"/api/mobile/v118/user_like_articles/%d/%d", authorId, page]
              parameters:[self prepareParams:nil]
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     handler(YES, responseObject);
                     HideNetworkActivityIndicator();
                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     NSLog(@"%@", error);
                     handler(NO, nil);
                     HideNetworkActivityIndicator();
                 }];
}

- (void) requestAllCategoryWithCompletion:(HttpRequesterHandler) handler{
    ShowNetworkActivityIndicator();
    [_requestManager GET:@"/small_medium_big"
              parameters:[self prepareParams:nil]
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     handler(YES, responseObject);
                     HideNetworkActivityIndicator();
                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     NSLog(@"%@", error);
                     handler(NO, nil);
                     HideNetworkActivityIndicator();
                 }];
}

- (void) requestBigCategoryWithBrand:(int)brandId andCompletion:(HttpRequesterHandler) handler{
    ShowNetworkActivityIndicator();
    [_requestManager GET:@"/big_medium_of_brand"
              parameters:[self prepareParams:@{@"brand_id":[NSNumber numberWithInt:brandId]}]
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     handler(YES, responseObject);
                     HideNetworkActivityIndicator();
                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     NSLog(@"%@", error);
                     handler(NO, nil);
                     HideNetworkActivityIndicator();
                 }];
}

- (void) requestCategoryWithBig:(int)bigCatId andCompletion:(HttpRequesterHandler) handler{
    ShowNetworkActivityIndicator();
    [_requestManager GET:@"/small_medium_of_big"
              parameters:[self prepareParams:@{@"big_id":[NSNumber numberWithInt:bigCatId]}]
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     handler(YES, responseObject);
                     HideNetworkActivityIndicator();
                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     NSLog(@"%@", error);
                     handler(NO, nil);
                     HideNetworkActivityIndicator();
                 }];
}

- (void) requestAllKeyWordsWithCompletion:(HttpRequesterHandler) handler{
    ShowNetworkActivityIndicator();
    [_requestManager GET:@"/hot_tags"
              parameters:[self prepareParams:nil]
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     handler(YES, responseObject);
                     HideNetworkActivityIndicator();
                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     NSLog(@"%@", error);
                     handler(NO, nil);
                     HideNetworkActivityIndicator();
                 }];
}

- (void) requestAuthorArticles: (int) authorId atPage:(int)page andHanler:(HttpRequesterHandler) handler{
    ShowNetworkActivityIndicator();
    [_requestManager GET:[NSString stringWithFormat:@"/same_author/%d", page]
              parameters:[self prepareParams:@{@"author_id" : [NSNumber numberWithInt:authorId]}]
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
        HideNetworkActivityIndicator();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        handler(NO, nil);
        HideNetworkActivityIndicator();
    }];
}

- (void) requestSameProductsArticles: (int) articleId atPage:(int)page andType:(NSString *)type andHanler:(HttpRequesterHandler) handler{
    ShowNetworkActivityIndicator();
    [_requestManager GET:@"articles/related_product"
              parameters:[self prepareParams:@{@"id": [NSNumber numberWithInt:articleId],
                                               @"type": type,
                                               @"page": [NSNumber numberWithInt:page]}]
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     handler(YES, responseObject);
                     HideNetworkActivityIndicator();
                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     NSLog(@"%@", error);
                     handler(NO, nil);
                     HideNetworkActivityIndicator();
                 }];
}

- (void) requestAPI:(NSString *)URLString withParams:(NSDictionary *)params andHanler:(HttpRequesterHandler) handler{
    ShowNetworkActivityIndicator();
    [_requestManager GET:URLString parameters:[self prepareParams:params] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
        HideNetworkActivityIndicator();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        handler(NO, nil);
        HideNetworkActivityIndicator();
    }];
}

- (void) requestBookmarkArticle:(int) articleId andHanler:(HttpRequesterHandler) handler {
    ShowNetworkActivityIndicator();
    [_requestManager POST:@"/bookmarks"
              parameters:[self prepareParams:@{@"article_id": [NSNumber numberWithInt:articleId]}]
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     handler(YES, responseObject);
                     HideNetworkActivityIndicator();
                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     NSLog(@"%@", error);
                     handler(NO, nil);
                     HideNetworkActivityIndicator();
                 }];
}
- (void) requestBookmarkArticlesOfUser:(int) userId inPage: (int) page andHanler:(HttpRequesterHandler) handler {
    ShowNetworkActivityIndicator();
    [_requestManager GET:[NSString stringWithFormat:@"/bookmarks/%d/all", userId]
              parameters:[self prepareParams:@{@"page": [NSNumber numberWithInt:page]}]
                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                      handler(YES, responseObject);
                      HideNetworkActivityIndicator();
                  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                      NSLog(@"%@", error);
                      handler(NO, nil);
                      HideNetworkActivityIndicator();
                  }];
}

- (void) requestTrackSplashAds:(int) adsId andEvent:(NSString *)event fromAstrars:(BOOL) isAstrars {
    ShowNetworkActivityIndicator();
    [_requestManager POST:isAstrars?@"astrars_statiscal/astrars_splash":@"/statiscal_app/splash"
              parameters:[self prepareParams:@{event: [NSNumber numberWithInt:1],
                                               @"id": [NSNumber numberWithInt:adsId]}]
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     HideNetworkActivityIndicator();
                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     NSLog(@"%@", error);
                     HideNetworkActivityIndicator();
                 }];
}

- (AFHTTPRequestOperation *) requestSearchTagWithKey:(NSString *)keyword andHanler:(HttpRequesterHandler) handler {
    ShowNetworkActivityIndicator();
    return [_requestManager GET:@"/search"
              parameters:[self prepareParams:@{@"free_text": keyword}]
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     handler(YES, responseObject);
                     HideNetworkActivityIndicator();
                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     NSLog(@"%@", error);
                     handler(NO, nil);
                     HideNetworkActivityIndicator();
                 }];
}

- (AFHTTPRequestOperation *) requestAllBigKeywordsWithHandler:(HttpRequesterHandler) handler {
    ShowNetworkActivityIndicator();
    return [_requestManager GET:@"/all_keyword"
                     parameters:[self prepareParams:nil]
                        success:^(AFHTTPRequestOperation *operation, id responseObject) {
                            handler(YES, responseObject);
                            HideNetworkActivityIndicator();
                        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                            NSLog(@"%@", error);
                            handler(NO, nil);
                            HideNetworkActivityIndicator();
                        }];
}

- (AFHTTPRequestOperation *) requestBigKeywordInfo:(int)keyword_id andType:(int)type withHandler:(HttpRequesterHandler) handler {
    ShowNetworkActivityIndicator();
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:keyword_id] forKey:@"tag_id"];
    [params setObject:[NSNumber numberWithInt:type] forKey:@"check_keyword"];
    return [_requestManager GET:@"/keyword/detail"
                     parameters:[self prepareParams:params]
                        success:^(AFHTTPRequestOperation *operation, id responseObject) {
                            handler(YES, responseObject);
                            HideNetworkActivityIndicator();
                        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                            NSLog(@"%@", error);
                            handler(NO, nil);
                            HideNetworkActivityIndicator();
                        }];
}

- (AFHTTPRequestOperation *) requestListProductParams:(NSDictionary *)params withHandler:(HttpRequesterHandler) handler {
    ShowNetworkActivityIndicator();
    return [_requestManager GET:@"/product_of_search_brand/"
                     parameters:[self prepareParams:params]
                        success:^(AFHTTPRequestOperation *operation, id responseObject) {
                            handler(YES, responseObject);
                            HideNetworkActivityIndicator();
                        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                            NSLog(@"%@", error);
                            handler(NO, nil);
                            HideNetworkActivityIndicator();
                        }];
}

- (AFHTTPRequestOperation *)loadMoreListProductParams:(NSDictionary *)params withHandler:(HttpRequesterHandler)handler {
    ShowNetworkActivityIndicator();
    return [_requestManager GET:@"/loadmore_product_of_search_brand/"
                     parameters:[self prepareParams:params]
                        success:^(AFHTTPRequestOperation *operation, id responseObject) {
                            handler(YES, responseObject);
                            HideNetworkActivityIndicator();
                        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                            NSLog(@"%@", error);
                            handler(NO, nil);
                            HideNetworkActivityIndicator();
                        }];

}

- (AFHTTPRequestOperation *) requestListFavouriteArticlesParams:(NSDictionary *)params atPage:(int)page withHandler:(HttpRequesterHandler) handler {
    ShowNetworkActivityIndicator();
    return [_requestManager GET:[NSString stringWithFormat:@"/search_article_like/%d", page]
                     parameters:[self prepareParams:params]
                        success:^(AFHTTPRequestOperation *operation, id responseObject) {
                            handler(YES, responseObject);
                            HideNetworkActivityIndicator();
                        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                            NSLog(@"%@", error);
                            handler(NO, nil);
                            HideNetworkActivityIndicator();
                        }];
}

- (AFHTTPRequestOperation *) requestListNewArticlesParams:(NSDictionary *)params atPage:(int)page withHandler:(HttpRequesterHandler) handler {
    ShowNetworkActivityIndicator();
    return [_requestManager GET:[NSString stringWithFormat:@"/search_article_view/%d", page]
                     parameters:[self prepareParams:params]
                        success:^(AFHTTPRequestOperation *operation, id responseObject) {
                            handler(YES, responseObject);
                            HideNetworkActivityIndicator();
                        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                            NSLog(@"%@", error);
                            handler(NO, nil);
                            HideNetworkActivityIndicator();
                        }];
}

- (AFHTTPRequestOperation *) requestListHotTagsWithHandler:(HttpRequesterHandler) handler {
    ShowNetworkActivityIndicator();
    return [_requestManager GET:@"hot_search_tags"
                     parameters:[self prepareParams:nil]
                        success:^(AFHTTPRequestOperation *operation, id responseObject) {
                            handler(YES, responseObject);
                            HideNetworkActivityIndicator();
                        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                            NSLog(@"%@", error);
                            handler(NO, nil);
                            HideNetworkActivityIndicator();
                        }];
}
#pragma mark: 1.2.0
- (AFHTTPRequestOperation *) requestDidShowTag: (int) tagId {
    ShowNetworkActivityIndicator();
    return [_requestManager POST:@"analytics_tags"
                      parameters:[self prepareParams:@{@"tag_id": [NSNumber numberWithInt:tagId]}]
                        success:^(AFHTTPRequestOperation *operation, id responseObject) {
                            DLog(@"API increase number view success");
                            HideNetworkActivityIndicator();
                        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                            DLog(@"API increase number view error: %@", error);
                            HideNetworkActivityIndicator();
                        }];
}

- (AFHTTPRequestOperation *)requestVideosTab:(NSInteger)tabIndex completion:(HttpRequesterHandler)handler {
    ShowNetworkActivityIndicator();
    return [_requestManager GET:[NSString stringWithFormat:@"/articles/refresh/%d", tabIndex] parameters:[self prepareParams:@{@"locale" : [Util getLocale]}] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
        HideNetworkActivityIndicator();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"AF Error: %@", error);
        handler(NO, nil);
        HideNetworkActivityIndicator();
    }];
}

- (AFHTTPRequestOperation *)loadMore:(NSInteger)tabIndex videoType:(NSString *)type lastArticleId:(int)lastArticleId completion:(HttpRequesterHandler)handler {
    ShowNetworkActivityIndicator();
    id param = @{
                 @"locale" : [Util getLocale],
                 @"sub_tab": type
                 };
    return [_requestManager GET:[NSString stringWithFormat:@"/articles/loadmore/%d/%d",lastArticleId, (int)tabIndex] parameters:[self prepareParams:param] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
        HideNetworkActivityIndicator();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"AF Error: %@", error);
        handler(NO, nil);
        HideNetworkActivityIndicator();
    }];
}

- (AFHTTPRequestOperation *)getProductByarticle:(int)articleId withHandler:(HttpRequesterHandler)handler {
    ShowNetworkActivityIndicator();
    return [_requestManager GET:[NSString stringWithFormat:@"/articles/have_products?id=%d",articleId] parameters:[self prepareParams:nil] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
        HideNetworkActivityIndicator();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"AF Error: %@", error);
        handler(NO, nil);
        HideNetworkActivityIndicator();
    }];
}

- (AFHTTPRequestOperation *)haveItProducts:(NSArray *)products withHandler:(HttpRequesterHandler)handler {
    ShowNetworkActivityIndicator();
    NSMutableDictionary *param = [NSMutableDictionary new];
    NSMutableArray *product_ids = [NSMutableArray new];
    for (ETProduct *p in products) {
        id obj = @{@"id": [NSNumber numberWithInt:p.prdId],
                   @"have_it": [NSNumber numberWithBool:p.ishaveit]};
        [product_ids addObject: obj];
    }
    [param setObject:product_ids forKey:@"products"];
    return [_requestManager POST:@"/have_it" parameters:[self prepareParams:param] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
        HideNetworkActivityIndicator();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        handler(NO, nil);
        HideNetworkActivityIndicator();
    }];
}

- (AFHTTPRequestOperation *)getRateforProduct:(NSArray *)productIds withHandler:(HttpRequesterHandler)handler {
    if (productIds.count <= 0) {
        handler(NO, nil);
        return nil;
    }
    ShowNetworkActivityIndicator();
    NSString *endpoint = @"";
    for (NSNumber *n in productIds) {
        NSString *string = [NSString stringWithFormat:@"&product_ids[]=%d", n.intValue];
        endpoint = [NSString stringWithFormat:@"%@%@", endpoint, string];
    }
    return [_requestManager GET:[NSString stringWithFormat:@"/products/list_rate?%@",[endpoint substringFromIndex:1]] parameters:[self prepareParams:nil] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
        HideNetworkActivityIndicator();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"AF Error: %@", error);
        handler(NO, nil);
        HideNetworkActivityIndicator();
    }];
}

- (AFHTTPRequestOperation *)submitRate:(NSArray *)products withHandler:(HttpRequesterHandler)handler {
    NSMutableDictionary *param = [NSMutableDictionary new];
    NSMutableArray *product_ids = [NSMutableArray new];
    for (ETProduct *p in products) {
        id obj = @{@"id": [NSNumber numberWithInt:p.prdId],
                   @"rating": [NSNumber numberWithInt:p.rating]};
        [product_ids addObject: obj];
    }
    [param setObject:product_ids forKey:@"products"];
    return [_requestManager POST:@"/products/rate" parameters:[self prepareParams:param] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        handler(YES, responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        handler(NO, nil);
    }];
}


-(void)cancelAllRequest{
    [[_requestManager operationQueue] cancelAllOperations];
}
@end
