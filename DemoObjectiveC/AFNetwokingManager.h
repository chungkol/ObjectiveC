//
//  AFNetwokingManager.h
//  DemoObjectiveC
//
//  Created by ChungVT on 8/25/17.
//  Copyright © 2017 ChungVT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFNetwokingManager : NSObject
- (void) request: (NSString *) url param:(NSDictionary *) param header:(NSDictionary *)header completion:(void (^)(NSDictionary *result , NSError *error))completion;
@end
