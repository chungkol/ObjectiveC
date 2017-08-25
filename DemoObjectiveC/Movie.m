//
//  Movie.m
//  DemoObjectiveC
//
//  Created by ChungVT on 8/25/17.
//  Copyright © 2017 ChungVT. All rights reserved.
//

#import "Movie.h"

@implementation Movie
- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    ;
    if (self == [super init]) {
    self.title = [attributes valueForKeyPath:@"title"];
    self.overview = [attributes valueForKeyPath:@"overview"];
    self.poster_path = [attributes valueForKeyPath:@"poster_path"];
    }
    return self;
}

@end
