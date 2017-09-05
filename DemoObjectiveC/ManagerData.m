//
//  ManagerData.m
//  DemoObjectiveC
//
//  Created by ChungVT on 8/28/17.
//  Copyright © 2017 ChungVT. All rights reserved.
//

#import "ManagerData.h"
#import "Constant.h"
#import "Movie.h"
@implementation ManagerData
- (void)getListTopRate:(void (^)(NSMutableArray *, NSError *))completion {
    NSMutableArray *data = [[NSMutableArray alloc]init]; //alloc
    NSDictionary *param = @{@"api_key": APIkey};
    [self request:getMovie param:param header:nil completion:^(NSDictionary *result, NSError *error) {
        if (!error) {
            NSArray *dataDic = [result objectForKey:@"results"];
            if (dataDic != (NSArray *)[NSNull null])
            {
                for (NSDictionary* item in dataDic) {
                    Movie *movie = [[Movie alloc] initWithAttributes:item];
                    [data addObject:movie];
                }
                if( completion ) completion(data, nil);
            }
        }else {
            if( completion ) completion(nil, error);
        }
    }];
}

@end
