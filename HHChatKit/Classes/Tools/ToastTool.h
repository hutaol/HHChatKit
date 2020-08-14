//
//  ToastTool.h
//  HHChatKit
//
//  Created by Henry on 2020/8/14.
//  Copyright © 2020 Henry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ToastToolPosition) {
    ToastToolPositionBottom,
    ToastToolPositionCenter,
    ToastToolPositionTop,
};

@interface ToastTool : NSObject

/// 显示提示视图, 默认显示在屏幕下方，2s后自动消失
+ (void)show:(NSString *)message;

/// 显示提示视图, 默认显示在屏幕上方，防止被软键盘覆盖，2s后自动消失
+ (void)showAtTop:(NSString *)message;

/// 显示提示视图, 默认显示在屏幕中间，2s后自动消失
+ (void)showAtCenter:(NSString *)message;

/// 显示提示视图, 默认显示在屏幕下方，4s后自动消失
+ (void)showLong:(NSString *)message;

/// 显示提示视图, 默认显示在屏幕上方，防止被软键盘覆盖，4s后自动消失
+ (void)showLongAtTop:(NSString *)message;

/// 显示提示视图, 默认显示在屏幕中间，4s后自动消失
+ (void)showLongAtCenter:(NSString *)message;

+ (void)show:(NSString *)message position:(ToastToolPosition)position showTime:(float)showTime;

@end

NS_ASSUME_NONNULL_END
