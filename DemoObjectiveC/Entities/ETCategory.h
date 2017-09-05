//
//  ETCategory.h
//  Favor
//
//  Created by DUCDM on 6/19/15.
//  Copyright (c) 2015 pape. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETCategory : NSObject

+(instancetype) etcategory;
-(instancetype) initWithID: (int)catId andName: (NSString *)name;
-(instancetype) initWithTag: (ETTag *)tag;
-(instancetype) initWithName: (NSString *)name;
@property (nonatomic,assign) int catId;
@property (nonatomic,strong) NSString *catName;

-(void)parseData:(NSDictionary *) data;

@end
