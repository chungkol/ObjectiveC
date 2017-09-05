//
//  BreadCrumbE.m
//  Favor
//
//  Created by DUCDM on 9/24/15.
//  Copyright © 2015 pape. All rights reserved.
//

#import "BreadCrumbE.h"

@implementation BreadCrumbE

+(instancetype)breadCumb{
    return [[self alloc] init];
}

-(void)parseData:(NSDictionary *) data{
    if ([data objectForKey:@"brand"]) {
        _brand = [ETTag tag];
        [_brand parseData:[data objectForKey:@"brand"]];
    }
    if ([data objectForKey:@"category"]) {
        _category = [ETTag tag];
        [_category parseData:[data objectForKey:@"category"]];
    }
}
@end
