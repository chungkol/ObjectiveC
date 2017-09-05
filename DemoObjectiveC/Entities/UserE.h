//
//  UserE.h
//  Favor
//
//  Created by vudinhthuy on 6/23/15.
//  Copyright (c) 2015 pape. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserE : NSObject

+(instancetype) sharedInstance;

@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *avatarURL;
@property (nonatomic, strong) NSString *about;
@property (nonatomic, assign) BOOL registered;
@property (nonatomic, assign) BOOL isUser;//check account is user or writer
@end
