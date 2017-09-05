//
//  ViewControllerTopRate.h
//  DemoObjectiveC
//
//  Created by ChungVT on 8/25/17.
//  Copyright © 2017 ChungVT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewCellMovie.h"
#import "ManagerData.h"
#import "Constant.h"
#import "Movie.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ViewControllerTopRate : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *myTable;
@property (nonatomic, strong) NSMutableArray *data;
@end
