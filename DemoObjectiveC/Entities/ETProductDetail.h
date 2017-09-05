//
//  ETProductDetail.h
//  Favor
//
//  Created by DucDM on 5/17/16.
//  Copyright © 2016 pape. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETProductDetail : NSObject
+ (instancetype) instance;
@property (nonatomic, assign) int productId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSArray *variationImages;
@property (nonatomic, assign) ProductUrlType urlType;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSArray *relativeUserArticle;
@property (nonatomic, strong) NSArray *relativeWriterArticle;
@property (nonatomic, assign) float rating;
@property (nonatomic, strong) NSString *releaseDate;
@property (nonatomic, strong) NSArray *variations;
@property (nonatomic, strong) NSDictionary *breadCrumb;
@property (nonatomic, assign) BOOL isMoreRelativeUser;
@property (nonatomic, assign) BOOL isMoreRelativeWriter;
- (void)parseData: (NSDictionary *)data;
@end
