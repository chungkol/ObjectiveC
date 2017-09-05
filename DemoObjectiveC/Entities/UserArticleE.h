//
//  UserArticleE.h
//  Favor
//
//  Created by DUCDM on 9/9/15.
//  Copyright (c) 2015 pape. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArticleE.h"
@interface UserArticleE : ArticleE
+(instancetype) userArticle;

//@property (nonatomic, assign) int articleId;
//@property (nonatomic, strong) NSString *authorName;
//@property (nonatomic, strong) NSString *userAbout;
//@property (nonatomic, strong) NSString *title;
//@property (nonatomic, strong) NSString *imageURL;
//@property (nonatomic, assign) int like;
//@property (nonatomic, assign) int comment;
//@property (nonatomic, assign) BOOL userLiked;
//@property (nonatomic, strong) NSString *publishedAt;
//@property (nonatomic, strong) NSString *publishedAtDetail;
//@property (nonatomic, assign) float rating;
@property (nonatomic, strong) NSString *tagString;
@property (nonatomic, strong) NSString *body;
//@property (nonatomic, strong) NSString *descString;
//@property (nonatomic, strong) NSString *authorAvatar;
-(void) parseData:(NSDictionary *) data;
-(void)fillData:(NSDictionary *)data;
@end
