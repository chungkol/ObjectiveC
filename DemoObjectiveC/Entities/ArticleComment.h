//
//  ArticleComment.h
//  Favor
//
//  Created by DUCDM on 6/11/15.
//  Copyright (c) 2015 pape. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleComment : NSObject<NSCopying>

+(instancetype) articleComment;
@property (nonatomic,assign) int commentId;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *comment;
@property (nonatomic,strong) NSString *icon;
@property (nonatomic,strong) NSString *commentImage;
@property (nonatomic,assign) CGSize imageCommentSize;
@property (nonatomic,strong) NSMutableArray *replies;
@property (nonatomic,assign) int numberLiked;
@property (nonatomic,assign) BOOL isLiked;
@property (nonatomic,assign) int userId;
@property (nonatomic,assign) BOOL isWriter;
-(void)parseData:(NSDictionary *) data;
@end
