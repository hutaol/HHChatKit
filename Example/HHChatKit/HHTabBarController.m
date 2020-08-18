//
//  HHTabBarController.m
//  HHChatKit_Example
//
//  Created by Henry on 2020/8/17.
//  Copyright © 2020 1325049637@qq.com. All rights reserved.
//

#import "HHTabBarController.h"
#import "HHConvListViewController.h"
#import "HHMineViewController.h"
#import <HHChatKit/HHChatManager.h>

@interface HHTabBarController ()

@end

@implementation HHTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[HHChatManager shareManager] initKit:@"ws://172.16.2.60:8091"];


    HHConvListViewController *conv = [[HHConvListViewController alloc] init];
    UINavigationController *convNav = [[UINavigationController alloc] initWithRootViewController:conv];
    conv.title = @"交流";
    
    HHMineViewController *mine = [[HHMineViewController alloc] init];
    UINavigationController *mineNav = [[UINavigationController alloc] initWithRootViewController:mine];
    mine.title = @"我";

    self.viewControllers = @[convNav, mineNav];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
