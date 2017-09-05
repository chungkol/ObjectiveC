//
//  ETTag.h
//  Favor
//
//  Created by DUCDM on 6/24/15.
//  Copyright (c) 2015 pape. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETTag : NSObject
+(instancetype) tag;
-(instancetype) initWithId: (int)tagId;
-(instancetype) initWithId: (int)tagId andName:(NSString *)name;
@property (nonatomic,assign) int tagId;
@property (nonatomic,strong) NSString *name;
@property (nonatomic, strong) NSArray *articles;
@property (nonatomic, assign) TypeTag type;
-(void)parseData:(NSDictionary *) data;

@end
