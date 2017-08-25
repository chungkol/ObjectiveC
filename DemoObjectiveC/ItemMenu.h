//
//  ItemMenu.h
//  DemoObjectiveC
//
//  Created by ChungVT on 8/24/17.
//  Copyright © 2017 ChungVT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemMenu : NSObject
@property NSString *titleMenu;
@property NSString *identifier;
@property NSString *icon;

- (instancetype)init: (NSString *) titleMenu identifier: (NSString *) identifier icon: (NSString *) icon;

@end
