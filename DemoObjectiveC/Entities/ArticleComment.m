//
//  ArticleComment.m
//  Favor
//
//  Created by DUCDM on 6/11/15.
//  Copyright (c) 2015 pape. All rights reserved.
//

#import "ArticleComment.h"
#import "ReplyComment.h"
@implementation ArticleComment

-(id)copyWithZone:(NSZone *)zone{
    ArticleComment *another = [[[self class] allocWithZone:zone] init];
    another.commentId = _commentId;
    another.name = _name;
    another.comment = _comment;
    another.icon = _icon;
    another.commentImage = _commentImage;
    another.isLiked = _isLiked;
    another.isWriter = _isWriter;
    another.userId = _userId;
    another.imageCommentSize = _imageCommentSize;
    if (_replies && _replies.count > 0) {
        another.replies = [NSMutableArray arrayWithObject:[_replies lastObject]];
    }
    another.numberLiked = _numberLiked;
    return another;
}

+(instancetype)articleComment{
    return [[self alloc] init];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.replies = [NSMutableArray array];
    }
    return self;
}

-(void)parseData:(NSDictionary *)data{
    self.commentId = [Util intValueForKey:@"id" fromDict:data];
    self.name = [Util stringValueForKey:@"user_name" fromDict:data];
    self.comment = [Util stringValueForKey:@"body" fromDict:data];
    self.icon = [Util stringValueForKey:@"icon" fromDict:data];
    self.commentImage = [Util stringValueForKey:@"image" fromDict:data];
    self.numberLiked = [Util intValueForKey:@"favorite" fromDict:data];
    self.isLiked = [Util intValueForKey:@"current_user_favorited" fromDict:data] == 1;
    if (![[Util stringValueForKey:@"user_type" fromDict:data] isEqualToString:@"user"]) {
        self.isWriter = YES;
    }
    self.userId = [Util intValueForKey:@"user_id" fromDict:data];
    if (self.commentImage.length  >0) {
        self.imageCommentSize = CGSizeMake([[data  objectForKey:@"width"] floatValue], [[data objectForKey:@"height"] floatValue]);
        if (self.imageCommentSize.width == 0 || self.imageCommentSize.height == 0) {
            self.imageCommentSize = CGSizeMake(1, 1);
        }
    }
    for (NSDictionary *dic in [data objectForKey:@"reply"]) {
        ReplyComment *reply = [ReplyComment replyComment];
        [reply parseData:dic];
        [self.replies addObject:reply];
    }
    
}

-(NSString *)description{
    return [NSString stringWithFormat:@"name: %@\ncomment: %@\nicon: %@\ncommentImage %@", self.name, self.comment, self.icon, self.commentImage];
}
@end
