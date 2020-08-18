//
//  UIWindow+HHChat.h
//  HHChatKit
//
//  Created by Henry on 2020/8/18.
//  Copyright © 2020 Henry. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIWindow (HHChat)

// 获取当前显示
- (UIViewController *)currentTopViewController;

@end

NS_ASSUME_NONNULL_END
