//
//  SpecialArticle.h
//  Favor
//
//  Created by DUCDM on 6/30/15.
//  Copyright (c) 2015 pape. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpecialArticle : NSObject
-(instancetype) initWithId:(int)saId withName: (NSString *)name andImage: (NSString *)imageUrl;

@property (nonatomic,assign) int saId;
@property (nonatomic,strong) NSString *saName;
@property (nonatomic,strong) NSString *saImageURL;

-(void)parseData:(NSDictionary *) data;

@end
