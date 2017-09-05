//
//  ETTag.m
//  Favor
//
//  Created by DUCDM on 6/24/15.
//  Copyright (c) 2015 pape. All rights reserved.
//

#import "ETTag.h"

@implementation ETTag

+(instancetype) tag{
    return [[ETTag alloc] init];
}

-(void) parseData:(NSDictionary *)data{
    _tagId = [Util intValueForKey:@"id" fromDict:data];
    _name = [Util stringValueForKey:@"name" fromDict:data];
    NSString *type = [Util stringValueForKey:@"type" fromDict:data];
    
    if ([type isEqualToString:@"brand"]) {
        _type = BrandTag;
    }else if([type isEqualToString:@"category"]){
        _type = CategoryTag;
    }else if([type isEqualToString:@"special"]){
        _type = SpecialTag;
    }else{
        _type = OtherTag;
    }
}

-(instancetype) initWithId: (int)tagId{
    self = [super init];
    if (self) {
        self.tagId = tagId;
        self.name = @"";
    }
    return self;
}

-(instancetype) initWithId: (int)tagId andName:(NSString *)name {
    self = [super init];
    if (self) {
        self.tagId = tagId;
        self.name = name;
    }
    return self;
}
@end
