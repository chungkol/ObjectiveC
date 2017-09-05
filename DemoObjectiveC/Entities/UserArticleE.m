//
//  UserArticleE.m
//  Favor
//
//  Created by DUCDM on 9/9/15.
//  Copyright (c) 2015 pape. All rights reserved.
//

#import "UserArticleE.h"

@implementation UserArticleE
+(instancetype) userArticle{
    UserArticleE *articleE =  [[UserArticleE alloc] init];
    articleE.authorName = @"";
    return articleE;
}

-(void) parseData:(NSDictionary *)data{
    self.articleId = [Util intValueForKey:@"id" fromDict:data];
    self.authorName = [Util stringValueForKey:@"user_name" fromDict:data];
    self.imageURL = [Util stringValueForKey:@"image" fromDict:data];
    self.comment = [Util intValueForKey:@"comment" fromDict:data];
    self.like = [Util intValueForKey:@"favorite" fromDict:data];
    self.userLiked = [Util intValueForKey:@"current_user_favorited" fromDict:data] == 1;
    self.publishedAt = [Util stringValueForKey:@"published_at" fromDict:data];
    self.publishedAtDetail = [Util stringValueForKey:@"published_at_detail" fromDict:data];
    self.title = [Util stringValueForKey:@"title" fromDict:data];
    self.body = [Util stringValueForKey:@"body" fromDict:data];
    self.tagString = [Util stringValueForKey:@"tags" fromDict:data];
    if (([data objectForKey:@"rating"]  == [NSNull null]) || ![data objectForKey:@"rating"]) {
        self.rating = 0;
    }else{
        self.rating = [[data objectForKey:@"rating"] floatValue];
    }
    self.authorAvatar = [Util stringValueForKey:@"avatar" fromDict:data];
}

-(void)fillData:(NSDictionary *)data{
    self.articleId = [Util intValueForKey:@"id" fromDict:data];
    self.imageURL = [Util stringValueForKey:@"image" fromDict:data];
    self.comment = [Util intValueForKey:@"comment" fromDict:data];
    self.like = [Util intValueForKey:@"favorite" fromDict:data];
    self.title = [Util stringValueForKey:@"title" fromDict:data];
    self.userLiked = [Util intValueForKey:@"current_user_favorited" fromDict:data] == 1;
    self.authorName = [Util stringValueForKey:@"name" fromDict:[data objectForKey:@"user"]];
    self.authorAvatar = [Util stringValueForKey:@"avatar" fromDict:[data objectForKey:@"user"]];
    if (([data objectForKey:@"rating"]  == [NSNull null]) || ![data objectForKey:@"rating"]) {
        self.rating = 0;
    }else{
        self.rating = [[data objectForKey:@"rating"] floatValue];
    }
}
@end
