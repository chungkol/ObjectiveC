//
//  ArticleE.m
//  Favor
//
//  Created by vudinhthuy on 6/9/15.
//  Copyright (c) 2015 pape. All rights reserved.
//

#import "ArticleE.h"

@implementation ArticleE

+(instancetype) article{
    ArticleE *articleE =  [[ArticleE alloc] init];
    articleE.isWaitingLikeRequest = NO;
    articleE.title = @"";
    articleE.lead = @"";
    return articleE;
}

-(void) parseData:(NSDictionary *)data{
    self.articleId = [Util intValueForKey:@"id" fromDict:data];
    self.title = [Util stringValueForKey:@"title" fromDict:data];
    self.lead = [Util stringValueForKey:@"lead" fromDict:data];
    self.imageURL = [Util stringValueForKey:@"image" fromDict:data];
    self.video_url = [Util stringValueForKey:@"video_url" fromDict:data];
    self.youtube_url = [Util stringValueForKey:@"youtube_url" fromDict:data];
    self.isYoutube = [Util intValueForKey:@"youtube_video" fromDict:data] == 1;
    self.comment = [Util intValueForKey:@"comment" fromDict:data];
    self.like = [Util intValueForKey:@"favorite" fromDict:data];
    self.userLiked = [Util intValueForKey:@"current_user_favorited" fromDict:data] == 1;
    self.publishedAt = [Util stringValueForKey:@"published_at" fromDict:data];
    self.publishedAtDetail = [Util stringValueForKey:@"published_at_detail" fromDict:data];
//    NSDictionary *author = [data objectForKey:@"author"];
    if ([data objectForKey:@"author"] && [data objectForKey:@"author"] != [NSNull null]) {
        id author = [data objectForKey:@"author"];
        if ([author isKindOfClass:[NSString class]]) {
            self.authorName = author;
        } else {
            self.authorName = [Util stringValueForKey:@"name" fromDict:author];
            self.authorAvatar = [Util stringValueForKey:@"image" fromDict:author];
        }
    } else if ([data objectForKey:@"author_name"] && [data objectForKey:@"author_name"] != [NSNull null]){
        self.authorName = [Util stringValueForKey:@"author_name" fromDict:data];
        self.authorAvatar = [Util stringValueForKey:@"author_avatar" fromDict:data];
    } else if ([data objectForKey:@"user_avatar"] && [data objectForKey:@"user_avatar"] != [NSNull null]){
        self.authorName = [Util stringValueForKey:@"user_name" fromDict:data];
        self.authorAvatar = [Util stringValueForKey:@"user_avatar" fromDict:data];
    } else if ([data objectForKey:@"user"]
               && [[data objectForKey:@"user"] isKindOfClass:[NSDictionary class]]) {
        NSDictionary *user = [data objectForKey:@"user"];
        self.authorName = [Util stringValueForKey:@"name" fromDict:user];
        self.authorAvatar = [Util stringValueForKey:@"avatar" fromDict:user];
    }
    if ([Util intValueForKey:@"ratio" fromDict:data] == 1) {
        self.videoType = 1;
    }else if ([Util intValueForKey:@"ratio" fromDict:data] == 2){
        self.videoType = 2;
    }else{
        self.videoType = 0;
    }
    
    if ([[Util stringValueForKey:@"type" fromDict:data] isEqualToString:@"product"]) {
        self.isProduct = YES;
        self.productId = [Util intValueForKey:@"id" fromDict:data];
        self.product_Name = [Util stringValueForKey:@"name" fromDict:data];
        self.product_Image = [Util stringValueForKey:@"image" fromDict:data];
    }
}

-(void) fillData:(NSDictionary *)data{
    self.articleId = [Util intValueForKey:@"id" fromDict:data];
    self.title = [Util stringValueForKey:@"title" fromDict:data];
    self.lead = [Util stringValueForKey:@"lead" fromDict:data];
    self.imageURL = [Util stringValueForKey:@"image" fromDict:data];
    self.comment = [Util intValueForKey:@"comment" fromDict:data];
    self.like = [Util intValueForKey:@"favorite" fromDict:data];
    self.userLiked = [Util intValueForKey:@"current_user_favorited" fromDict:data] == 1;
    self.publishedAt = [Util stringValueForKey:@"published_at" fromDict:data];
    self.authorName = [Util stringValueForKey:@"name" fromDict:[data objectForKey:@"user"]];
    self.authorAvatar = [Util stringValueForKey:@"avatar" fromDict:[data objectForKey:@"user"]];
    if ([Util intValueForKey:@"ratio" fromDict:data] == 1) {
        self.videoType = 1;
    }else if ([Util intValueForKey:@"ratio" fromDict:data] == 2){
        self.videoType = 2;
    }else{
        self.videoType = 0;
    }
}

-(NSString *) description{
    return [NSString stringWithFormat:@"id: %i\ntitle: %@\nlead: %@\nimage: %@\npublished_at: %@\n", _articleId, _title, _lead, _imageURL, _publishedAt];
}
@end
