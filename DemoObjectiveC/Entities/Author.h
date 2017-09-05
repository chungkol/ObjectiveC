//
//  Author.h
//  Favor
//
//  Created by DUCDM on 6/10/15.
//  Copyright (c) 2015 pape. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Author : NSObject

+(instancetype) author;

@property (nonatomic, assign) int authorId;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *imageURL;
@property (nonatomic, assign) BOOL isUser;// check author is user or writer
@property (nonatomic, strong) NSString *coverImageURL;
@property (nonatomic, strong) NSString *about;
@property (nonatomic, assign) int numberOfEntries;
@property (nonatomic, assign) int numberOfFollowers;
@property (nonatomic, assign) int numberOfLikes;
@property (nonatomic, assign) BOOL wasFollow;

-(void)parseData:(NSDictionary *) data;
@end
