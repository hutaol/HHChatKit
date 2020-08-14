//
//  HHViewController.m
//  HHChatKit
//
//  Created by 1325049637@qq.com on 08/12/2020.
//  Copyright (c) 2020 1325049637@qq.com. All rights reserved.
//

#import "HHViewController.h"
#import <HHChatKit/HHChatManager.h>

@interface HHViewController ()

@end

@implementation HHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[HHChatManager shareManager] initKit:@"ws://172.16.4.17:8001"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
