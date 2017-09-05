//
//  TableViewCellMovie.h
//  DemoObjectiveC
//
//  Created by ChungVT on 8/25/17.
//  Copyright © 2017 ChungVT. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DidClickCell <NSObject>
- (void) didClickCellExcel: (UITableViewCell *) cell button:(UIButton *)sender ;
@end
@interface TableViewCellMovie : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageCell;
@property (weak, nonatomic) IBOutlet UILabel *titleCell;
@property (weak, nonatomic) IBOutlet UILabel *des;
@property (nonatomic, strong) id<DidClickCell> delegate;

@end
