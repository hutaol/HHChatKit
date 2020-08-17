//
//  HHConversationSearchResultController.m
//  HHChatKit
//
//  Created by Henry on 2020/8/17.
//  Copyright © 2020 Henry. All rights reserved.
//

#import "HHConversationSearchResultController.h"
#import "HHConversationCell.h"
#import "HHConversationManager.h"

@interface HHConversationSearchResultController ()

@property (nonatomic, strong) NSMutableArray *convData;

@end

@implementation HHConversationSearchResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.rowHeight = [HHConversationCell viewHeight];
    [self.tableView registerClass:[HHConversationCell class] forCellReuseIdentifier:[HHConversationCell cellId]];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.convData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HHConversationCell *cell = [tableView dequeueReusableCellWithIdentifier:[HHConversationCell cellId]];
    cell.conversation = self.convData[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.itemSelectedAction) {
        self.itemSelectedAction(self, self.convData[indexPath.row]);
    }
}

#pragma mark - # UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *text = [searchController.searchBar.text lowercaseString];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"partnerName CONTAINS[c] %@", text];
    //    NSArray *searchResultArray = [self.dataArray filteredArrayUsingPredicate:predicate];
        
    HHConversationManager *manager = [HHConversationManager sharedInstance];

    NSArray *searchResultArray = [manager.convDatas filteredArrayUsingPredicate:predicate];
        
    self.convData = searchResultArray.mutableCopy;

    [self.tableView reloadData];
}

@end
