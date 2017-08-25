//
//  Menu.m
//  DemoObjectiveC
//
//  Created by ChungVT on 8/25/17.
//  Copyright © 2017 ChungVT. All rights reserved.
//

#import "Menu.h"

@implementation Menu
- (instancetype)init:(NSString *)section data:(NSArray *)data {
    if (self == [super init]) {
        self.section = section;
        self.data = data;
    }
    return self;
}
@end
