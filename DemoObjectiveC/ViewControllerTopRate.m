
//
//  ViewControllerTopRate.m
//  DemoObjectiveC
//
//  Created by ChungVT on 8/25/17.
//  Copyright © 2017 ChungVT. All rights reserved.
//

#import "ViewControllerTopRate.h"
@interface ViewControllerTopRate () <UITableViewDelegate, UITableViewDataSource>
//@property Manager
@end

@implementation ViewControllerTopRate

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getData];

}

- (void) showDialog:(NSString *) title message: (NSString *) message {

        UIAlertController *alertController = [UIAlertController alertControllerWithTitle: title message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        
        [self presentViewController:alertController animated:YES completion:nil];
}
- (void)getData {
    ManagerData *manager = [[ManagerData alloc] init];
    [manager getListTopRate:^(NSMutableArray *result, NSError *error) {
        if (!error) {
            self.data = result;
            [self.myTable reloadData];
        }else {
            NSLog(@"error %@" , error);
            [self showDialog:@"error" message:error.description];
        }
        
    }];
}

#pragma mark UITableviewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;

}
#pragma mark UITableviewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.data count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCellMovie *cell = [tableView dequeueReusableCellWithIdentifier:@"cellMovie" forIndexPath:indexPath];
    Movie *movie = [self.data objectAtIndex:indexPath.row];
    if (movie != (Movie *)[NSNull null]) {
        cell.des.text  = movie.overview;
        cell.titleCell.text = movie.title;
        if (movie.poster_path != (id) ([NSNull null])) {
            [cell.imageCell sd_setImageWithURL:[NSURL URLWithString: [baseURLImage stringByAppendingString:movie.poster_path]]
                              placeholderImage:[UIImage imageNamed:@"google.png"]];

        }else {
            cell.imageCell.image = [UIImage imageNamed:@"google.png"];
        }
        
    }
        return cell;
}
@end
