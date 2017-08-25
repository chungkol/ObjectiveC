//
//  Movie.h
//  DemoObjectiveC
//
//  Created by ChungVT on 8/25/17.
//  Copyright © 2017 ChungVT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject
@property NSString *title;
@property NSString *overview;
@property NSString *poster_path;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

@end
