//
//  HHConvListViewController.m
//  HHChatKit_Example
//
//  Created by Henry on 2020/8/17.
//  Copyright © 2020 1325049637@qq.com. All rights reserved.
//

#import "HHConvListViewController.h"

@interface HHConvListViewController ()

@end

@implementation HHConvListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSMutableArray *arr = [NSMutableArray array];
        
    HHConversation *conv = [[HHConversation alloc] init];
    conv.convType = HHConversationTypePersonal;
    conv.partnerID = @"1";
    conv.partnerName = @"111";
    conv.avatarURL = @"https://i.picsum.photos/id/1/200/200.jpg?hmac=jZB9EZ0Vtzq-BZSmo7JKBBKJLW46nntxq79VMkCiBG8";
    conv.date = [NSDate new];
    conv.content = @"测试1测试1测试";
    conv.unreadCount = 1000;
    [arr addObject:conv];
    
    HHConversation *conv2 = [[HHConversation alloc] init];
    conv2.convType = HHConversationTypePersonal;
    conv2.partnerID = @"2";
    conv2.partnerName = @"赵丽颖";
    conv2.avatarURL = @"https://i.picsum.photos/id/1/200/200.jpg?hmac=jZB9EZ0Vtzq-BZSmo7JKBBKJLW46nntxq79VMkCiBG8";
    conv2.date = [NSDate new];
    conv2.content = @"我是谁";
    conv2.unreadCount = 2;
    [arr addObject:conv2];
    
    self.data = arr;
    [self.tableView reloadData];
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
