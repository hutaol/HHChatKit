//
//  HHConversationViewController.h
//  HHChatKit
//
//  Created by Henry on 2020/8/17.
//  Copyright © 2020 Henry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHConversation.h"
@class HHConversationViewController;

NS_ASSUME_NONNULL_BEGIN

@protocol HHConversationViewControllerDelegagte <NSObject>

@optional
- (void)conversationViewController:(HHConversationViewController *)conversationController didSelectConversation:(HHConversation *)conversation;

@end


@interface HHConversationViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id<HHConversationViewControllerDelegagte> delegate;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *data;

@end

NS_ASSUME_NONNULL_END
