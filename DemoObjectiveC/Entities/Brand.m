//
//  Brand.m
//  Favor
//
//  Created by DUCDM on 6/19/15.
//  Copyright (c) 2015 pape. All rights reserved.
//

#import "Brand.h"

@implementation Brand

+(instancetype)brand{
    return [[self alloc] init];
}

-(instancetype) initWithID: (int)brandId andName: (NSString *)name{
    self = [super init];
    if (self) {
        _brandId = brandId;
        _name = name;
    }
    return self;
}

-(instancetype) initWithName: (NSString *)name{
    self = [super init];
    if (self) {
        _brandId = 0;
        _name = name;
    }
    return self;
}

-(instancetype) initWithTag: (ETTag *)tag{
    self = [super init];
    if (self) {
        _brandId = tag.tagId;
        _name = tag.name;
    }
    return self;
}

-(void)parseData:(NSDictionary *)data{
    _brandId = [Util intValueForKey:@"id" fromDict:data];
    _name = [Util stringValueForKey:@"name" fromDict:data];
    _indexTitle = [Util stringValueForKey:@"index_title" fromDict:data];
    _furigana = [Util stringValueForKey:@"name_furigana" fromDict:data];
    _indexFurigana = [Util stringValueForKey:@"index_title_furigana" fromDict:data];
}

+ (Brand *) furiBrandFromDict:(NSDictionary *) brandDict {
    Brand *brand = [Brand brand];
//    NSString *name =
    
    return brand;
}

-(NSString *)description{
    return [NSString stringWithFormat:@"BrandId: %d\nName: %@", _brandId,_name];
}
@end
