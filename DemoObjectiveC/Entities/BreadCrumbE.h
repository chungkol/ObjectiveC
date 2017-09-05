//
//  BreadCrumbE.h
//  Favor
//
//  Created by DUCDM on 9/24/15.
//  Copyright © 2015 pape. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BreadCrumbE : NSObject
+(instancetype)breadCumb;
@property (nonatomic, strong) ETTag *brand;
@property (nonatomic, strong) ETTag *category;
@property (nonatomic, strong) NSString *subject;
-(void)parseData:(NSDictionary *) data;
@end
