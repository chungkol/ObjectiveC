//
//  Util.h
//  DemoObjectiveC
//
//  Created by ChungVT on 8/29/17.
//  Copyright © 2017 ChungVT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Util : NSObject
+(NSString *) stringValueForKey:(NSString *) key fromDict:(NSDictionary *) dict;
+(int) intValueForKey:(NSString *) key fromDict:(NSDictionary *) dict;
@end
