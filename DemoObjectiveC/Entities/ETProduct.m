//
//  ETProduct.m
//  Favor
//
//  Created by DUCDM on 3/17/16.
//  Copyright © 2016 pape. All rights reserved.
//

#import "ETProduct.h"

@implementation ETProduct
+(instancetype) product{
    return [[ETProduct alloc] init];
}

-(instancetype) initWithID: (int)prdId andName: (NSString *)name{
    self = [super init];
    if (self) {
        self.prdId = prdId;
        self.prdName = name;
    }
    return self;
}

-(void)parseData:(NSDictionary *) data{
    self.prdId = [Util intValueForKey:@"id" fromDict:data];
    self.prdName = [Util stringValueForKey:@"name" fromDict:data];
    self.imageURL = [Util stringValueForKey:@"image" fromDict:data];
    self.brand = [Brand brand];
    if ([data objectForKey:@"brand"]) {
        id brand = [data objectForKey:@"brand"];
        if ([brand isKindOfClass:[NSString class]]) {
            self.brandName = brand;
        } else {
            [self.brand parseData:brand];
        }
    }
    if ([data objectForKey:@"brand_name"]) {
        _brandName = [data objectForKey:@"brand_name"];
    }
    self.category = [ETCategory etcategory];
    if ([data objectForKey:@"category"]) {
        [self.category parseData:[data objectForKey:@"category"]];
    }
    if ([data objectForKey:@"rating"] != [NSNull null] && [data objectForKey:@"rating"]) {
        self.rating = [[data objectForKey:@"rating"] floatValue];
    }
    if ([data objectForKey:@"variations"] && [[data objectForKey:@"variations"] isKindOfClass:[NSArray class]]) {
        self.variations = [data objectForKey:@"variations"];
    }
    
    if ([data objectForKey:@"have_it"] != [NSNull null] && [data objectForKey:@"have_it"]) {
        self.ishaveit = [[data objectForKey:@"have_it"] boolValue];
    }
    
    if ([data objectForKey:@"brand_id"] != [NSNull null] && [data objectForKey:@"brand_id"]) {
        self.brand_id = [[data objectForKey:@"brand_id"] intValue];
    }
    
    if ([data objectForKey:@"category_id"] != [NSNull null] && [data objectForKey:@"category_id"]) {
        self.category_id = [[data objectForKey:@"category_id"] intValue];
    }
}
@end
