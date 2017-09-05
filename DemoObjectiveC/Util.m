//
//  Util.m
//  DemoObjectiveC
//
//  Created by ChungVT on 8/29/17.
//  Copyright © 2017 ChungVT. All rights reserved.
//

#import "Util.h"

@implementation Util
+(NSString *) stringValueForKey:(NSString *) key fromDict:(NSDictionary *) dict{
    if (([dict objectForKey:key]  == [NSNull null]) || ![dict objectForKey:key]) {
        return @"";
    }
    id value = [dict objectForKey:key];
    return [value isKindOfClass:[NSString class]] ? value:[value description];
}

+(int) intValueForKey:(NSString *) key fromDict:(NSDictionary *) dict{
    if (([dict objectForKey:key]  == [NSNull null]) || ![dict objectForKey:key]) {
        return 0;
    }
    
    return [[dict objectForKey:key] intValue];
}
@end
