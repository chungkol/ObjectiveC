//
//  Movie.h
//  DemoObjectiveC
//
//  Created by ChungVT on 8/25/17.
//  Copyright © 2017 ChungVT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *overview;
@property (nonatomic, strong) NSString *poster_path;
@property (nonatomic, assign) int *movieID;
- (instancetype)initWithAttributes:(NSDictionary *)attributes;

@end
