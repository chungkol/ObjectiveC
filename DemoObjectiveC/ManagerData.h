//
//  ManagerData.h
//  DemoObjectiveC
//
//  Created by ChungVT on 8/28/17.
//  Copyright © 2017 ChungVT. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "AFNetwokingManager.h"
@interface ManagerData : AFNetwokingManager

-(void) getListTopRate:(void (^)(NSMutableArray *result , NSError *error))completion;
@end
