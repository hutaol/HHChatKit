//
//  HHConversationViewController.m
//  HHChatKit
//
//  Created by Henry on 2020/8/17.
//  Copyright © 2020 Henry. All rights reserved.
//

#import "HHConversationViewController.h"
#import "HHConversationCell.h"
#import "HHConversationNoNetCell.h"
#import "HHMessagesViewController.h"
#import "HHSearchController.h"
#import "HHConversationSearchResultController.h"
#import "HHConversationManager.h"

@interface HHConversationViewController ()

@property (nonatomic, strong) HHSearchController *searchController;

@end

@implementation HHConversationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor = self.view.backgroundColor;
    
    [self.view addSubview:self.tableView];
    
}

#pragma mark - Method

- (void)pushChat:(HHConversation *)conv {
    if (self.delegate && [self.delegate respondsToSelector:@selector(conversationViewController:didSelectConversation:)]) {
        [self.delegate conversationViewController:self didSelectConversation:conv];
        return;
    }
    
    HHMessagesViewController *messages = [[HHMessagesViewController alloc] init];
    messages.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:messages animated:YES];

}


#pragma mark - # UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HHConversation *conv = self.data[indexPath.row];
    if (conv.convType == HHConversationTypeNoNet) {
        HHConversationNoNetCell *cell = [tableView dequeueReusableCellWithIdentifier:[HHConversationNoNetCell cellId]];
        return cell;
    }
    HHConversationCell *cell = [tableView dequeueReusableCellWithIdentifier:[HHConversationCell cellId]];
    cell.conversation = self.data[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HHConversation *conv = self.data[indexPath.row];
    if (conv.convType == HHConversationTypeNoNet) {
        return [HHConversationNoNetCell viewHeight];
    }
    return [HHConversationCell viewHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HHConversation *conv = self.data[indexPath.row];
    if (conv.convType == HHConversationTypeNoNet) {
        return;
    }
    [self pushChat:conv];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    HHConversation *conv = self.data[indexPath.row];
    if (conv.convType == HHConversationTypeNoNet) {
        return NO;
    }
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tableView beginUpdates];
        HHConversation *conv = self.data[indexPath.row];
        [self.data removeObject:conv];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
        [tableView endUpdates];
    }
}

#pragma mark - # Setters

- (void)setData:(NSMutableArray *)data {
    _data = data;
    [HHConversationManager sharedInstance].convDatas = _data;
}

#pragma mark - # Getters

- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        tableView.tableFooterView = [UIView new];
        tableView.backgroundColor = [UIColor whiteColor];
        [tableView registerClass:[HHConversationCell class] forCellReuseIdentifier:[HHConversationCell cellId]];
        [tableView registerClass:[HHConversationNoNetCell class] forCellReuseIdentifier:[HHConversationNoNetCell cellId]];
        tableView.tableHeaderView = self.searchController.searchBar;
        
        _tableView = tableView;
    }
    return _tableView;
}

- (HHSearchController *)searchController {
    if (!_searchController) {
        HHConversationSearchResultController *searchVC = [[HHConversationSearchResultController alloc] init];
        _searchController = [HHSearchController createWithResultsContrller:searchVC];
        
        __weak typeof(self) weakSelf = self;
        searchVC.itemSelectedAction = ^(HHConversationSearchResultController * _Nonnull searchVC, HHConversation * _Nonnull conv) {
            // TODO
            weakSelf.searchController.active = NO;
            
            [weakSelf pushChat:conv];
        };

    }
    return _searchController;
}

@end
