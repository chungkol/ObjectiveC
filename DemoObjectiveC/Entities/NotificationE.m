//
//  NotificationE.m
//  Favor
//
//  Created by vudinhthuy on 7/29/15.
//  Copyright (c) 2015 pape. All rights reserved.
//

#import "NotificationE.h"

@implementation NotificationE

+ (instancetype) notification{
    NotificationE *notiE = [[NotificationE alloc] init];
    return notiE;
}


-(void) parseData:(NSDictionary *)data{
    self.notiId = [Util intValueForKey:@"id" fromDict:data];
    self.articleId = [Util intValueForKey:@"article_id" fromDict:data];
    self.commentId = [Util intValueForKey:@"comment_id" fromDict:data];
    self.isRead = [Util intValueForKey:@"read" fromDict:data] == 1;
    self.message = [Util stringValueForKey:@"message" fromDict:data];
    self.type = [Util intValueForKey:@"type" fromDict:data];
    self.authorImg = [Util stringValueForKey:@"author_img" fromDict:data];
    self.eyeCatch = [Util stringValueForKey:@"eye_catch" fromDict:data];
}

@end
