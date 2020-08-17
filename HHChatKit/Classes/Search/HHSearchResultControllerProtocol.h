//
//  HHSearchResultControllerProtocol.h
//  HHChatKit
//
//  Created by Henry on 2020/8/17.
//  Copyright © 2020 Henry. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIViewController;

NS_ASSUME_NONNULL_BEGIN

@protocol HHSearchResultControllerProtocol <UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate>

@optional
- (void)setItemClickAction:(void (^)(__kindof UIViewController *searchResultVC, id data))itemClickAction;

@end

NS_ASSUME_NONNULL_END
