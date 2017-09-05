//
//  ResponseObject.m
//  Favor
//
//  Created by Tinhvv on 10/5/15.
//  Copyright © 2015 pape. All rights reserved.
//

#import "ResponseObject.h"

@implementation ResponseObject
+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{ @"error" : @"error",
                                                        @"user_article" : @"responsePost",
                                                        @"comment" : @"responseComment",
                                                        @"user" : @"responseUser",
                                                        @"status" : @"status",
                                                        @"message" : @"message"
                                                        }];
}

+ (ResponseObject *)responseObjectWithRequestOperation:(AFHTTPRequestOperation *)operation
                                                   error:(NSError *)error {
//    NSString *responseString = [[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding];
    if (error) {
        return [[ResponseObject alloc] initWithData:nil error:&error];
    }
    //HACK DATA
    NSMutableDictionary *mInfo = [[NSMutableDictionary alloc] initWithDictionary:operation.responseObject];
    id fuckData = [mInfo objectForKey:@"data"];
    if (fuckData) {
        if ([fuckData isKindOfClass:[NSArray class]]) {
            if (!((NSArray *)fuckData).count) {
                fuckData = @{};
                [mInfo setObject:fuckData forKey:@"data"];
            }
        }
    }
    
    NSError *parserError = nil;
    ResponseObject *obj = [[ResponseObject alloc] initWithDictionary:mInfo error:&parserError];
    
    return obj;
}

@end
