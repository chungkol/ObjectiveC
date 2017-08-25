
//
//  ViewControllerTopRate.m
//  DemoObjectiveC
//
//  Created by ChungVT on 8/25/17.
//  Copyright © 2017 ChungVT. All rights reserved.
//

#import "ViewControllerTopRate.h"
#import "TableViewCellMovie.h"
#import "AFNetwokingManager.h"
#import "Constant.h"
#import "Movie.h"
@interface ViewControllerTopRate () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation ViewControllerTopRate

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)getData {
    AFNetwokingManager *manager = [[AFNetwokingManager alloc] init];
    NSDictionary *param = @{@"api_key": APIkey};
    [manager request:getMovie param:param header:nil completion:^(NSDictionary *result, NSError *error) {
        if (!error) {
            NSArray *dataDic = [result objectForKey:@"results"];
            if (dataDic != (NSArray *)[NSNull null])
            {
                for (NSDictionary* item in dataDic) {
                    Movie *movie = [[Movie alloc] initWithAttributes:item];
                    [self.data addObject:movie];
                }
                [self.myTable reloadData];
            }
        }else {
            NSLog(@"error %@" , error);
        }
    }];
}

//MARK: UITableviewDelegate

//MARK: UITableviewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.data count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCellMovie *cell = [tableView dequeueReusableCellWithIdentifier:@"cellMovie" forIndexPath:indexPath];
    Movie *movie = [self.data objectAtIndex:indexPath.row];
    if (movie != (Movie *)[NSNull null]) {
        cell.description = movie.description;
        cell.titleCell = movie.title;
        

    }
        return cell;
}
@end
