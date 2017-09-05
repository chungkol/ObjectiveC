//
//  AFNetwokingManager.m
//  DemoObjectiveC
//
//  Created by ChungVT on 8/25/17.
//  Copyright © 2017 ChungVT. All rights reserved.
//

#import "AFNetwokingManager.h"
#import "AFHTTPSessionManager.h"
@implementation AFNetwokingManager

-(void)request:(NSString *)url param:(NSDictionary *)param header:(NSDictionary *)header completion:(void (^)(NSDictionary *, NSError *))completion {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:param progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        if( completion ) completion(responseObject, nil);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        if( completion ) completion(nil, error);
    }];
}
- (void)postRequest:(NSString *)url param:(NSDictionary *)param header:(NSDictionary *)header completion:(void (^)(NSDictionary *, NSError *))completion {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if( completion ) completion(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if( completion ) completion(nil, error);
    }];
}
@end
