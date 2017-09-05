//
//  ReplyComment.m
//  Favor
//
//  Created by DUCDM on 8/11/15.
//  Copyright (c) 2015 pape. All rights reserved.
//

#import "ReplyComment.h"

@implementation ReplyComment
+(instancetype)replyComment{
    return [[self alloc] init];
}

-(void)parseData:(NSDictionary *)data{
    self.replyId = [Util intValueForKey:@"id" fromDict:data];
    self.name = [Util stringValueForKey:@"user_name" fromDict:data];
    self.comment = [Util stringValueForKey:@"body" fromDict:data];
    self.icon = [Util stringValueForKey:@"icon" fromDict:data];
    self.commentImage = [Util stringValueForKey:@"image" fromDict:data];
    if (self.commentImage.length  >0) {
        self.imageCommentSize = CGSizeMake([[data  objectForKey:@"width"] floatValue], [[data objectForKey:@"height"] floatValue]);
        if (self.imageCommentSize.width == 0 || self.imageCommentSize.height == 0) {
            self.imageCommentSize = CGSizeMake(1, 1);
        }
    }
    self.numberLiked = [Util intValueForKey:@"favorite" fromDict:data];
    self.isLiked = [Util intValueForKey:@"current_user_favorited" fromDict:data] == 1;
    if (![[Util stringValueForKey:@"user_type" fromDict:data] isEqualToString:@"user"]) {
        self.isWriter = YES;
    }
    self.userId = [Util intValueForKey:@"user_id" fromDict:data];
}

-(NSString *)description{
    return [NSString stringWithFormat:@"name: %@\ncomment: %@\nicon: %@\ncommentImage %@", self.name, self.comment, self.icon, self.commentImage];
}
@end
