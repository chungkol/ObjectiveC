//
//  ETCategoryBig.h
//  Favor
//
//  Created by DucDM on 5/9/16.
//  Copyright © 2016 pape. All rights reserved.
//

#import "ETCategoryMedium.h"

@interface ETCategoryBig : ETCategoryMedium
@property (strong, nonatomic) NSMutableArray *expandArr;
@property (assign) int indexBig;
-(float)height;
@end
