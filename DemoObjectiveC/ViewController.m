//
//  ViewController.m
//  DemoObjectiveC
//
//  Created by ChungVT on 8/24/17.
//  Copyright © 2017 ChungVT. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCellMenu.h"
#import "ItemMenu.h"
#import "Authentication.h"
#import "Menu.h"
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ItemMenu *item1 = [[ItemMenu alloc] init:@"authen" identifier:@"authen" icon:@"authentication"];
    ItemMenu *item2 = [[ItemMenu alloc] init:@"getData" identifier:@"topRate" icon:@"authentication"];
    Menu *account = [[Menu alloc] init:@"Authentication" data:@[item1]];
    Menu *afnetworking = [[Menu alloc] init:@"AFNetworking" data:@[item2]];
    self.data = @[account, afnetworking];
//    [self.myTable reloadData];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.data count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    Menu *item = [self.data objectAtIndex:section];
    if (item != (Menu *)[NSNull null])
    {
        return [item.data count];
    }
    return 0;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    Menu *item = [self.data objectAtIndex:section];
    //check if let ben obj kieur nayf a?
    if (item != (Menu *)[NSNull null])
    {
        return item.section;
    }
    return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCellMenu *cell = [tableView dequeueReusableCellWithIdentifier: @"cellTable" forIndexPath:indexPath];
    Menu *menu = [self.data objectAtIndex:indexPath.section];
    ItemMenu *item = [menu.data objectAtIndex:indexPath.row];
    if (item != (ItemMenu *)[NSNull null])
    {
        cell.titleMenu.text = item.titleMenu;
        cell.iconMenu.image = [UIImage imageNamed:item.icon];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Menu *menu = [self.data objectAtIndex:indexPath.section];
    ItemMenu *item = [menu.data objectAtIndex:indexPath.row];
    if (item != (ItemMenu *)[NSNull null])
    {
        UIViewController *destination = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier: item.identifier];
        [self.navigationController pushViewController:destination animated:true];
    }
   
}

@end
