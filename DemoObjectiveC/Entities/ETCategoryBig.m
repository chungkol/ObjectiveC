//
//  ETCategoryBig.m
//  Favor
//
//  Created by DucDM on 5/9/16.
//  Copyright © 2016 pape. All rights reserved.
//

#import "ETCategoryBig.h"

@implementation ETCategoryBig
-(void)parseData:(NSDictionary *)data{
    [super parseData:data];
    self.indexBig = [Util intValueForKey:@"index" fromDict:data];
}
-(float)height{
    float rowHeight = (IS_IPHONE_6P)?125/3.0f:38;
    float h = rowHeight;
    for (ETCategoryMedium *medium in self.categories) {
        if (medium.isExpanding) {
            h += (medium.categories.count + 1)*rowHeight;
        }else{
            h += rowHeight;
        }
    }
    return h;
//    return rowHeight*(self.categories.count + 1);
}
@end
