//
//  ETProduct.h
//  Favor
//
//  Created by DUCDM on 3/17/16.
//  Copyright © 2016 pape. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Brand.h"
#import "ETCategory.h"
@interface ETProduct : NSObject
+(instancetype) product;
-(instancetype) initWithID: (int)prdId andName: (NSString *)name;
@property (nonatomic,assign) int groupId;
@property (nonatomic,assign) int prdId;
@property (nonatomic,strong) NSString *prdName;
@property (nonatomic,strong) NSString *imageURL;
@property (nonatomic,strong) Brand *brand;
@property (nonatomic,strong) ETCategory *category;
@property (nonatomic,assign) float rating;
@property (nonatomic, strong) NSArray *variations;
@property (nonatomic, strong) NSString *productURL;
@property (nonatomic, assign) ProductUrlType urlType;
/// have it properties
@property (nonatomic,assign) BOOL ishaveit;
@property (nonatomic,strong) NSString *brandName;
@property (nonatomic,assign) int brand_id;
@property (nonatomic,assign) int category_id;

-(void)parseData:(NSDictionary *) data;

@end
