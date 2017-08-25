//
//  ItemMenu.m
//  DemoObjectiveC
//
//  Created by ChungVT on 8/24/17.
//  Copyright © 2017 ChungVT. All rights reserved.
//

#import "ItemMenu.h"

@implementation ItemMenu
-(instancetype)init:(NSString *)titleMenu identifier:(NSString *)identifier icon:(NSString *)icon {
    if (self == [super init]) {
        self.titleMenu = titleMenu;
        self.identifier = identifier;
        self.icon = icon;

    }
    return self;
}
@end
