//
//  NotificationE.h
//  Favor
//
//  Created by vudinhthuy on 7/29/15.
//  Copyright (c) 2015 pape. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificationE : NSObject

+ (instancetype) notification;

@property (nonatomic, assign) int notiId;
@property (nonatomic, assign) int articleId;
@property (nonatomic, assign) int commentId;
@property (nonatomic, assign) BOOL isRead;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, assign) int type;
@property (nonatomic, strong) NSString *eyeCatch;
@property (nonatomic, strong) NSString *authorImg;

-(void) parseData:(NSDictionary *) data;
@end
