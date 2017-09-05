//
//  ArticleDetail.h
//  Favor
//
//  Created by DUCDM on 6/10/15.
//  Copyright (c) 2015 pape. All rights reserved.
//

#import "Author.h"
#import "Brand.h"
#import "BreadCrumbE.h"
#import "ETCategory.h"
#import "ETProduct.h"
#import "ETTag.h"
#import <Foundation/Foundation.h>

@interface ArticleDetail : NSObject

+ (instancetype)articleDetail;

@property(nonatomic, strong) ArticleE *nextArticle;
@property(nonatomic, strong) ArticleE *prevArticle;
@property(nonatomic, strong) UserArticleE *nextUserArticle;
@property(nonatomic, strong) UserArticleE *prevUserArticle;
@property(nonatomic, strong) NSArray *articleComments;

@property(nonatomic, strong) NSMutableArray *tags;
@property(nonatomic, strong) NSMutableArray *relatedArticles;
@property(nonatomic, strong) NSMutableArray *relatedArticlesUser;
@property(nonatomic, strong) NSMutableDictionary *sameUserArticles;
@property(nonatomic, strong) NSMutableDictionary *sameWriterArticles;
@property(nonatomic, assign) int articleId;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *lead;
@property(nonatomic, strong) NSString *imageURL;
@property(nonatomic, strong) NSString *thumbnailURL;
@property(nonatomic, strong) NSString *body;
@property(nonatomic, strong) NSString *shortenURL;
@property(nonatomic, strong) NSString *publishedAt;
@property (nonatomic, assign) BOOL isYoutube;
@property (nonatomic, strong) NSString *youtube_url;
@property(nonatomic, strong) Author *author;
@property(nonatomic, assign) BOOL isLike;
@property(nonatomic, assign) BOOL isBookmark;
@property(nonatomic, assign) int likeNumer;
@property(nonatomic, assign) int commentNumer;
@property(nonatomic, assign) BOOL isUserArticle;
@property(nonatomic, strong) BreadCrumbE *breadCrumb;
@property(nonatomic, strong) NSString *tagString;
@property(nonatomic, assign) BOOL isCuration;
@property(nonatomic, strong) NSArray *productBrand;
@property(nonatomic, strong) NSArray *productCat;
@property(nonatomic, strong) NSArray *product;
@property(nonatomic, assign) float rating;
@property(nonatomic, strong) NSArray *relativeProducts;
@property(nonatomic, strong) NSArray *sameAuthorArticle;
@property(nonatomic, assign) int typeArticle;
@property(nonatomic, assign) BOOL video;
@property(nonatomic, assign) int ratio;
@property(nonatomic, strong) ArticleE *adArticle;
- (void)parseData:(NSDictionary *)data;
@end
