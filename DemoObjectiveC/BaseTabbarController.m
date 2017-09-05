//
//  BaseTabbarController.m
//  DemoObjectiveC
//
//  Created by ChungVT on 9/5/17.
//  Copyright © 2017 ChungVT. All rights reserved.
//

#import "BaseTabbarController.h"

@interface BaseTabbarController ()<UITabBarControllerDelegate>
@end

@implementation BaseTabbarController
 NSArray *arrayOfImageNameForSelectedState;
 NSArray *arrayOfImageNameForUnselectedState;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    arrayOfImageNameForUnselectedState = @[[UIImage imageNamed:@"Tabbar_Top.pdf"],[UIImage imageNamed:@"Tabbar_Scheduler.pdf"],[UIImage imageNamed:@"Tabbar_Prescription.pdf"],[UIImage imageNamed:@"Tabbar_Configuration.pdf"]];
    
    if (self.tabBar.items.count != 0) {
        for (int i = 0; i < self.tabBar.items.count; i++) {
            self.tabBar.items[i].image = [arrayOfImageNameForUnselectedState[i] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
    }
    [[UITabBarItem appearance] setTitleTextAttributes:@{
                                                        NSFontAttributeName:[UIFont fontWithName:@"HiraKakuPro-W3" size:11], NSForegroundColorAttributeName: [UIColor whiteColor]
                                                        } forState:UIControlStateNormal];
    
   
    CGRect rectItem = [[self.tabBar subviews] objectAtIndex: 0].frame;
    UIImageView *im = [[UIImageView alloc] initWithFrame: CGRectMake((rectItem.origin.x + rectItem.size.width / 2 ) - 6, 0, 12, 6)];
    im.tag = 1314;
    im.image = [UIImage imageNamed:@"Triangle.pdf"];
    [self.tabBar addSubview:im];

    for (NSString* family in [[UIFont familyNames] sortedArrayUsingSelector:@selector(compare:)])
    {
        NSLog(@"%@", family);
        
        for (NSString* name in [[UIFont fontNamesForFamilyName:family] sortedArrayUsingSelector:@selector(compare:)])
        {
            NSLog(@"  %@", name);
        }
    }
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    for (UIView *item in self.tabBar.subviews) {
        if ((item != (UIView *)[NSNull null]) && item.tag == 1314 ){
            [item removeFromSuperview];
            break;
        }
    }
    NSUInteger indexOfTab = [self.viewControllers indexOfObject:viewController];
    NSLog(@"index %d, " , indexOfTab);
    CGRect rectItem = [[self.tabBar subviews] objectAtIndex:indexOfTab + 1].frame;
    UIImageView *im = [[UIImageView alloc] initWithFrame: CGRectMake((rectItem.origin.x + rectItem.size.width / 2 ) - 6, 0, 12, 6)];
    im.tag = 1314;
    im.image = [UIImage imageNamed:@"Triangle.pdf"];
    [self.tabBar addSubview:im];
}
@end
