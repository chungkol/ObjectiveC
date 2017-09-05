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
        self.movieID = [Util intValueForKey:@"id" fromDict:attributes];
        self.title = [Util stringValueForKey:@"title" fromDict:attributes];
        self.overview = [Util stringValueForKey:@"overview" fromDict:attributes];
        self.poster_path = [Util stringValueForKey:@"poster_path" fromDict:attributes];
        _title = @"a";
    }
    return self;
}

@end
