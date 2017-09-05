//
//  UserE.m
//  Favor
//
//  Created by vudinhthuy on 6/23/15.
//  Copyright (c) 2015 pape. All rights reserved.
//

#import "UserE.h"

@implementation UserE

static UserE *_sharedInstance;

+ (instancetype)sharedInstance {
    if (!_sharedInstance) {
        _sharedInstance = [[UserE alloc] init];
    }
    return _sharedInstance;
}

- (id)init {
    if (self = [super init]) {
        _userId = 0;
        _token = nil;
        _username = nil;
        _avatarURL = nil;
        _about = nil;
        _registered = NO;
        _isUser = YES;
    }
    return self;
}
@end
