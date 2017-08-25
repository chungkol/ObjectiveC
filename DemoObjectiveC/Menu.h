//
//  Menu.h
//  DemoObjectiveC
//
//  Created by ChungVT on 8/25/17.
//  Copyright © 2017 ChungVT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Menu : NSObject
@property NSString *section;
@property NSArray * data;
- (instancetype)init: (NSString *) section data: (NSArray *) data;
@end
