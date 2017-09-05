//
//  Author.m
//  Favor
//
//  Created by DUCDM on 6/10/15.
//  Copyright (c) 2015 pape. All rights reserved.
//

#import "Author.h"

@implementation Author

+(instancetype)author{
    return [[self alloc] init];
}

-(void)parseData:(NSDictionary *)data{
    self.authorId = [Util intValueForKey:@"id" fromDict:data];
    self.name = [Util stringValueForKey:@"name" fromDict:data];
    self.title = [Util stringValueForKey:@"title" fromDict:data];
    self.imageURL = [Util stringValueForKey:@"image" fromDict:data];
    self.coverImageURL = [Util stringValueForKey:@"cover_image" fromDict:data];
    self.about = [Util stringValueForKey:@"about" fromDict:data];
    NSString *type = [Util stringValueForKey:@"type" fromDict:data];
    self.numberOfEntries = [Util intValueForKey:@"count_article" fromDict:data];
    self.numberOfFollowers = [Util intValueForKey:@"count_follow" fromDict:data];
    self.numberOfLikes = [Util intValueForKey:@"count_like" fromDict:data];
    if (type && [type isEqualToString:@"writer"]) {
        self.isUser = NO;
    } else {
        self.isUser = YES;
    }
    if (([data objectForKey:@"followed"]  == [NSNull null]) || ![data objectForKey:@"followed"]) {
        self.wasFollow = NO;
    }else{
        self.wasFollow = [[data objectForKey:@"followed"] boolValue];
    }

    
}

-(NSString *)description{
    return [NSString stringWithFormat:@"name: %@\ntitle: %@\nimageUrl: %@", self.name,self.title,self.imageURL];
}

@end
