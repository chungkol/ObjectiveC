//
//  ETCategory.m
//  Favor
//
//  Created by DUCDM on 6/19/15.
//  Copyright (c) 2015 pape. All rights reserved.
//

#import "ETCategory.h"

@implementation ETCategory

+(instancetype)etcategory{
    return [[self alloc] init];
}

-(instancetype) initWithID: (int)catId andName: (NSString *)name{
    self = [super init];
    if (self) {
        _catId = catId;
        _catName = name;
    }
    return self;
}

-(instancetype) initWithTag: (ETTag *)tag{
    self = [super init];
    if (self) {
        _catId = tag.tagId;
        _catName = tag.name;
    }
    return self;
}

-(instancetype) initWithName: (NSString *)name{
    self = [super init];
    if (self) {
        _catId = 0;
        _catName = name;
    }
    return self;
}

-(void)parseData:(NSDictionary *)data{
    _catId = [Util intValueForKey:@"id" fromDict:data];
    _catName = [Util stringValueForKey:@"name" fromDict:data];
}

-(NSString *)description{
    return [NSString stringWithFormat:@"id: %d\nname: %@", _catId,_catName];
}

@end
