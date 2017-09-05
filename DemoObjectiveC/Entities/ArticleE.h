//
//  ArticleE.h
//  Favor
//
//  Created by vudinhthuy on 6/9/15.
//  Copyright (c) 2015 pape. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum : NSUInteger {
    Normal,
    Video_1_1,
    Video_16_9,
} ArticleEVideoType;

@interface ArticleE : NSObject

+(instancetype) article;

@property (nonatomic, assign) int articleId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *lead;
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) NSString *video_url;
@property (nonatomic, assign) BOOL isYoutube;
@property (nonatomic, strong) NSString *youtube_url;
@property (nonatomic, strong) NSString *publishedAt;
@property (nonatomic, strong) NSString *publishedAtDetail;
@property (nonatomic, strong) NSString *authorName;
@property (nonatomic, strong) NSString *authorAvatar;
@property (nonatomic, assign) int like;
@property (nonatomic, assign) int comment;
@property (nonatomic, assign) BOOL userLiked;
@property (nonatomic, assign) BOOL isWaitingLikeRequest;
@property (nonatomic, assign) float rating;

// properties for top screen product
@property (nonatomic, assign) BOOL isProduct;
@property (nonatomic, assign) int productId;
@property (nonatomic, copy) NSString *product_Name;
@property (nonatomic, copy) NSString *product_Image;
@property (nonatomic, assign) ArticleEVideoType videoType;

-(void) parseData:(NSDictionary *) data;
-(void) fillData:(NSDictionary *)data;
@end
