//
//  ETProductDetail.m
//  Favor
//
//  Created by DucDM on 5/17/16.
//  Copyright © 2016 pape. All rights reserved.
//

#import "ETProductDetail.h"
#import "UserArticleE.h"

@implementation ETProductDetail
+(instancetype) instance{
    return [[ETProductDetail alloc] init];
}

- (void)parseData:(NSDictionary *)data{
    self.productId = [Util intValueForKey:@"id" fromDict:[data objectForKey:@"product"]];
    self.title = [Util stringValueForKey:@"name" fromDict:[data objectForKey:@"product"]];
    self.image = [Util stringValueForKey:@"image" fromDict:[data objectForKey:@"product"]];
    self.url = [Util stringValueForKey:@"product_url" fromDict:[data objectForKey:@"product"]];
    self.urlType = ([Util intValueForKey:@"type_url" fromDict:[data objectForKey:@"product"]] != 2)?SitePublic:OnlineStore;
    self.variationImages = [[data objectForKey:@"product"] objectForKey:@"image_variation"];
    self.rating = [Util floatValueForKey:@"rating" fromDict:[data objectForKey:@"product"]];
    self.releaseDate = [Util stringValueForKey:@"release_date" fromDict:[data objectForKey:@"product"]];
    self.variations = [[data objectForKey:@"product"] objectForKey:@"product_variations"];
    self.breadCrumb = [[data objectForKey:@"product"] objectForKey:@"breadscrum"];
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *article in [[data objectForKey:@"same_articles_user"] objectForKey:@"articles"]) {
        UserArticleE *a = [UserArticleE userArticle];
        a.articleId = [Util intValueForKey:@"id" fromDict:article];
        a.authorName = [Util stringValueForKey:@"author_name" fromDict:article];
        a.authorAvatar = [Util stringValueForKey:@"author_avatar" fromDict:article];
        a.imageURL = [Util stringValueForKey:@"image" fromDict:article];
        a.comment = [Util intValueForKey:@"comment" fromDict:article];
        a.like = [Util intValueForKey:@"favorite" fromDict:article];
        a.userLiked = [Util intValueForKey:@"current_user_favorited" fromDict:article] == 1;
        a.title = [Util stringValueForKey:@"title" fromDict:article];
        a.body = [Util stringValueForKey:@"body" fromDict:article];
        a.tagString = [Util stringValueForKey:@"tags" fromDict:article];
        if (([article objectForKey:@"rating"]  == [NSNull null]) || ![article objectForKey:@"rating"]) {
            a.rating = 0;
        }else{
            a.rating = [[article objectForKey:@"rating"] floatValue];
        }
        [arr addObject:a];
    }
    self.relativeUserArticle =[NSArray arrayWithArray:arr];
    if ([Util intValueForKey:@"total" fromDict:[data objectForKey:@"same_articles_user"]] > 5) {
        _isMoreRelativeUser = YES;
    }
    arr = [NSMutableArray array];
    for (NSDictionary *article in [[data objectForKey:@"same_articles_writer"] objectForKey:@"articles"]) {
        ArticleE *a = [ArticleE article];
        [a parseData:article];
        [arr addObject:a];
    }
    self.relativeWriterArticle = [NSArray arrayWithArray:arr];
    if ([Util intValueForKey:@"total" fromDict:[data objectForKey:@"same_articles_writer"]] > 4) {
        _isMoreRelativeWriter = YES;
    }
    
}
@end
