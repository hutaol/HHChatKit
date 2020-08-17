//
//  HHSearchController.m
//  HHChatKit
//
//  Created by Henry on 2020/8/17.
//  Copyright © 2020 Henry. All rights reserved.
//

#import "HHSearchController.h"

@interface HHSearchController ()

@end

@implementation HHSearchController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

}

+ (HHSearchController *)createWithResultsContrller:(UIViewController<HHSearchResultControllerProtocol> *)resultVC {
    if (!resultVC) {
        return nil;
    }
    HHSearchController *searchController = [[HHSearchController alloc] initWithSearchResultsController:resultVC];
    [searchController setSearchResultsUpdater:resultVC];
    return searchController;
}

- (id)initWithSearchResultsController:(UIViewController<HHSearchResultControllerProtocol>  *)searchResultsController {
    if (self = [super initWithSearchResultsController:searchResultsController]) {
        [self setDelegate:searchResultsController];
        self.definesPresentationContext = YES;
        
        // searchResultsController
        searchResultsController.edgesForExtendedLayout = UIRectEdgeNone;
        searchResultsController.automaticallyAdjustsScrollViewInsets = NO;
        
        // searchBar
        [self.searchBar sizeToFit];
        
        self.searchBar.placeholder = @"搜索";
        
    }
    return self;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

@end
