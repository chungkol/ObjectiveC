//
//  SpecialArticle.m
//  Favor
//
//  Created by DUCDM on 6/30/15.
//  Copyright (c) 2015 pape. All rights reserved.
//

#import "SpecialArticle.h"

@implementation SpecialArticle
-(instancetype) initWithId:(int)saId withName: (NSString *)name andImage: (NSString *)imageUrl{
    self = [super init];
    if (self) {
        _saId = saId;
        _saName = name;
        _saImageURL = imageUrl;
    }
    return self;
}

-(void)parseData:(NSDictionary *)data{
    _saId = [Util intValueForKey:@"id" fromDict:data];
    _saName = [Util stringValueForKey:@"name" fromDict:data];
    _saImageURL = [Util stringValueForKey:@"image" fromDict:data];
}
@end
