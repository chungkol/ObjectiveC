//
//  Requester.h
//  Favor
//
//  Created by vudinhthuy on 6/9/15.
//  Copyright (c) 2015 pape. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void (^HttpRequesterHandler)(BOOL success, id responseObject);

@interface HttpRequester : NSObject

@property (nonatomic, strong) AFHTTPRequestOperationManager *requestManager;
+(instancetype) requester;

-(void) requestNewListArticlesByPage:(int) page responseHandler:(HttpRequesterHandler) handler;
-(void) requestHotListArticlesByPage:(int) page responseHandler:(HttpRequesterHandler) handler;

-(void) requestArticleDetailWithArticleID: (int) articleId andNoti: (int)notiId andResult:(HttpRequesterHandler) handler;
-(void) requestPR_ArticleDetailWithArticleID: (int)articleID andNoti:(int)notiId andResult:(HttpRequesterHandler) handler;
-(void) requestCreateUser:(HttpRequesterHandler) handler;
-(void) requestUpdateUserInfos:(NSDictionary *) infos responseHandler:(HttpRequesterHandler) handler;
-(void) requestGetUserInfos:(NSInteger) userID responseHandler:(HttpRequesterHandler) handler;
-(void) requestAddNewComment:(NSDictionary *) commentInfos article:(NSInteger) articleId responseHandler:(HttpRequesterHandler) handler;
-(void) requestLikeArticle:(NSInteger) articleId responseHandler:(HttpRequesterHandler) handler;
-(void) requestAllCommentOfArticle: (int)articleId responseHadle:(HttpRequesterHandler) handler;
-(void) requestAllBrands:(HttpRequesterHandler) handler;
-(void) requestAllBrandsGrouped:(HttpRequesterHandler) handler;
-(void) requestAllCatefory:(HttpRequesterHandler) handler;
-(void) requestCategoryWithBrand: (int)brandId responseHadle:(HttpRequesterHandler) handler;
-(void) requestListLikedArticle:(int) page type:(NSString *)type responseHadle:(HttpRequesterHandler) handler;
-(void) requestSearchInfo:(HttpRequesterHandler) handler;
-(void) requestArticleByTag: (int) tagId atPage:(int)page isCuration:(BOOL)isTrue andHanler:(HttpRequesterHandler) handler;
-(void) requestArticleByBrandId: (int)brandId andCategoryId: (int)categoryId atPage:(int)page isCuration:(BOOL)isTrue andHanler:(HttpRequesterHandler) handler;
-(void) requestCheckCss:(NSString *) filename andHanler:(HttpRequesterHandler) handler;
-(void) requestUpdateDeviceToken;
-(void) requestCheckUpdateNewListWithLastId: (int) articleId andResult:(HttpRequesterHandler) handler;
-(void) likeCommentWithId:(int)commentId andResult:(HttpRequesterHandler) handler;
-(void) requestWriterInfo: (int) writerId atPage:(int)page andHanler:(HttpRequesterHandler) handler;
-(void) requestAllCommentOfArticleByNotification: (int)articleId notiId:(int) notiId responseHadle:(HttpRequesterHandler) handler;
-(void) requestNotificationList:(int) page responseHandler:(HttpRequesterHandler) handler;
-(void) requestNotificationCountWithResponseHandler:(HttpRequesterHandler) handler;
-(void) requestReplyComment:(int)commentId with:(NSDictionary *)replyInfor responseHandler:(HttpRequesterHandler) handler;
-(void) requestNewListUserArticlesByPage:(int) page responseHandler:(HttpRequesterHandler) handler;
-(void) requestHotListUserArticlesByPage:(int) page responseHandler:(HttpRequesterHandler) handler;
-(void) requestUserArticleByTag: (int) tagId atPage:(int)page andHanler:(HttpRequesterHandler) handler;
- (void)requestUserArticleByBigCategory:(int)tagId atPage:(int)page withUserId:(NSInteger)userId andHanler:(HttpRequesterHandler) handler;
//-(void) requestUserArticleByBrandId: (int)brandId andCategoryId: (int)categoryId atPage:(int)page andHanler:(HttpRequesterHandler) handler;


/**
 *  Update  for 1.1.0
 */
- (void) requestUserPostArticle:(NSDictionary *)info responseHandler:(HttpRequesterHandler) handler;
-(void) requestWriterInfo: (int) writerId atPage:(int)page type: (NSString *)type andHanler:(HttpRequesterHandler) handler;
- (void) requestSampleArticleWithID:(int)articleID atPage:(int)page type: (NSString *)type andHanler:(HttpRequesterHandler) handler;
- (void)requestListUsersLikedArticle:(int)articleId andHandler:(HttpRequesterHandler) handler;
-(void) requestCheckUpdateNewUserArticleListWithLastId: (int) articleId andResult:(HttpRequesterHandler) handler;

/**
 *  Update for 1.1.0.1
 */

- (void)requestListAdsWithUserType:(NSString *)type responseHandler:(HttpRequesterHandler) handler;
- (void)requestUpdateArticle:(NSDictionary *)params andResult:(HttpRequesterHandler) handler;
- (void)requestDeleteArticle:(int)articleId andResult:(HttpRequesterHandler) handler;
- (void)cancelAllRequest;
- (void)requestUpdateNotification:(int)notiId andResult:(HttpRequesterHandler) handler;
- (void)requestUpdateNotificationPush:(int)notiId andResult:(HttpRequesterHandler) handler;
- (void)requestClearBadge;

/**
 *  Update for 1.1.7
 *
 *  @param handler Request response hadnled
 */
- (void) requestAllTabInfoResult:(HttpRequesterHandler) handler;
- (void) requestCheckUpdateTabWithTabIndex: (int)tabIndex lastArticle: (int)articleId andResult:(HttpRequesterHandler) handler;
- (void) requestArticlesAtTabWithTabIndex: (int)tabIndex andResult:(HttpRequesterHandler) handler;
- (void) requestLoadMoreArticleAtTabWithTabIndex: (int)tabIndex fromArticle: (int)articleId andResult:(HttpRequesterHandler) handler;
- (void) requestCheckTimeLineWithLastUpdate:(NSString *)lastUpdate andResult:(HttpRequesterHandler) handler;
- (void)requestDataForHistoryTab:(int)historyId andResult:(HttpRequesterHandler)handler;
/**
 *  update for 1.1.8
 */
- (void) requestAllProduct:(HttpRequesterHandler) handler;
- (void) requestAllTags:(HttpRequesterHandler) handler;
- (void) requestCategoriesOfProductByBrandId:(int)brandId andCompletion:(HttpRequesterHandler) handler;
- (void) requestProductsByBrandId:(int)brandId withCategory:(int)catId andCompletion:(HttpRequesterHandler) handler;
- (void) requestUpdateFollowStateAuthor:(int)authorId andCompletion:(HttpRequesterHandler) handler;
- (void) requestSyncTagData: (HttpRequesterHandler) handler;
- (void) requestProductDetail:(int)productId andCompletion:(HttpRequesterHandler) handler;
- (void) requestAuthorInfo: (int)authorId andCompletion:(HttpRequesterHandler) handler;
- (void) requestAuthorWriterPostInfo: (int)authorId andPage:(int)page andCompletion:(HttpRequesterHandler) handler;
- (void) requestAuthorFavouritedWriterPostInfo: (int)authorId andPage:(int)page andCompletion:(HttpRequesterHandler) handler;
- (void) requestAuthorFavouritedUserPostInfo: (int)authorId andPage:(int)page andCompletion:(HttpRequesterHandler) handler;
- (void) requestAllCategoryWithCompletion:(HttpRequesterHandler) handler;
- (void) requestBigCategoryWithBrand:(int)brandId andCompletion:(HttpRequesterHandler) handler;
- (void) requestCategoryWithBig:(int)bigCatId andCompletion:(HttpRequesterHandler) handler;
- (void) requestAllKeyWordsWithCompletion:(HttpRequesterHandler) handler;
- (void) requestAuthorArticles: (int) authorId atPage:(int)page andHanler:(HttpRequesterHandler) handler;
- (void) requestSameProductsArticles: (int) articleId atPage:(int)page andType:(NSString *)type andHanler:(HttpRequesterHandler) handler;
- (void) requestAPI:(NSString *)URLString withParams:(NSDictionary *)params andHanler:(HttpRequesterHandler) handler;
- (void) requestBookmarkArticle:(int) articleId andHanler:(HttpRequesterHandler) handler;
- (void) requestBookmarkArticlesOfUser:(int) userId inPage: (int) page andHanler:(HttpRequesterHandler) handler;

/**
 Track Splash advertisement
 *
 */
- (void) requestTrackSplashAds:(int) adsId andEvent:(NSString *)event fromAstrars:(BOOL) isAstrars;
// 1.1.9
- (AFHTTPRequestOperation *) requestSearchTagWithKey:(NSString *)keyword andHanler:(HttpRequesterHandler) handler;
- (AFHTTPRequestOperation *) requestAllBigKeywordsWithHandler:(HttpRequesterHandler) handler;
- (AFHTTPRequestOperation *) requestBigKeywordInfo:(int)keyword_id andType:(int)type withHandler:(HttpRequesterHandler) handler;
- (AFHTTPRequestOperation *) requestListProductParams:(NSDictionary *)params withHandler:(HttpRequesterHandler) handler;
- (AFHTTPRequestOperation *) loadMoreListProductParams:(NSDictionary *)params withHandler:(HttpRequesterHandler) handler;
- (AFHTTPRequestOperation *) requestListFavouriteArticlesParams:(NSDictionary *)params atPage:(int)page withHandler:(HttpRequesterHandler) handler;
- (AFHTTPRequestOperation *) requestListNewArticlesParams:(NSDictionary *)params atPage:(int)page withHandler:(HttpRequesterHandler) handler;
- (AFHTTPRequestOperation *) requestListHotTagsWithHandler:(HttpRequesterHandler) handler;
// 1.2.0
/**
 API POST to increase number view when show an Tag (Brand, Category, Keyword)
 * @param tagId: int id of tag
 * @return AFHTTPRequestOperation request of api
 */
- (AFHTTPRequestOperation *) requestDidShowTag: (int) tagId;

- (AFHTTPRequestOperation *)requestVideosTab:(NSInteger)tabIndex completion:(HttpRequesterHandler)handler;
- (AFHTTPRequestOperation *)loadMore:(NSInteger)tabIndex videoType:(NSString *)type lastArticleId:(int)lastArticleId completion:(HttpRequesterHandler)handler;

// 2017/07/13
/*
    APIs for have it products
 */

- (AFHTTPRequestOperation *)getProductByarticle:(int)articleId withHandler:(HttpRequesterHandler)handler;
- (AFHTTPRequestOperation *)getRateforProduct:(NSArray *)productIds withHandler:(HttpRequesterHandler)handler;
- (AFHTTPRequestOperation *)haveItProducts:(NSArray *)products withHandler:(HttpRequesterHandler)handler;
- (AFHTTPRequestOperation *)submitRate:(NSArray *)products withHandler:(HttpRequesterHandler)handler;

@end
