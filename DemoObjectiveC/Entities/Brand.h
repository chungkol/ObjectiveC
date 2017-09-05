//
//  Brand.h
//  Favor
//
//  Created by DUCDM on 6/19/15.
//  Copyright (c) 2015 pape. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Brand : NSObject

+(instancetype) brand;
-(instancetype) initWithID: (int)brandId andName: (NSString *)name;
-(instancetype) initWithName: (NSString *)name;
-(instancetype) initWithTag: (ETTag *)tag;
@property (nonatomic,assign) int brandId;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSArray *categorys;
@property (nonatomic, strong) NSString *indexTitle;
@property (nonatomic, strong) NSString *furigana;
@property (nonatomic, strong) NSString *indexFurigana;
@property (nonatomic, strong) NSString *subTitle;
@property (nonatomic,assign) BOOL isFuri;
-(void)parseData:(NSDictionary *) data;
@end
