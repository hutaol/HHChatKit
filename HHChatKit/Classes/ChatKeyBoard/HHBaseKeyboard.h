//
//  HHBaseKeyboard.h
//  YYT
//
//  Created by Henry on 2020/8/10.
//  Copyright © 2020 eastraycloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHKeyboardProtocol.h"
#import "HHKeyboardDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface HHBaseKeyboard : UIView <HHKeyboardProtocol>

/// 是否正在展示
@property (nonatomic, assign, readonly) BOOL isShow;

/// 事件回调
@property (nonatomic, weak) id<HHKeyboardDelegate> keyboardDelegate;

/// 显示键盘(在keyWindow上)
/// @param animation 是否显示动画
- (void)showWithAnimation:(BOOL)animation;

/// 显示键盘
/// @param view 父view
/// @param animation 是否显示动画
- (void)showInView:(UIView *)view withAnimation:(BOOL)animation;

/// 键盘消失
/// @param animation 是否显示消失动画
- (void)dismissWithAnimation:(BOOL)animation;

/// 重置键盘
- (void)reset;

@end

NS_ASSUME_NONNULL_END
