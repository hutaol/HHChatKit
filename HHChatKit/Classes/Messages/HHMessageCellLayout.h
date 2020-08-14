//
//  HHMessageCellLayout.h
//  HHChatKit
//
//  Created by Henry on 2020/8/13.
//  Copyright © 2020 Henry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHMessageCellLayout : NSObject

/// 消息边距
@property UIEdgeInsets messageInsets;

/// 气泡内部内容边距
@property UIEdgeInsets bubbleInsets;

/// 头像边距
@property UIEdgeInsets avatarInsets;

/// 头像大小
@property CGSize avatarSize;

/// 头像圆角
@property CGFloat avatarCorner;

/// 名字
@property CGFloat nameHorizontalMargin;

@property CGFloat timeTipHeight;

/// 获取接收消息布局
+ (HHMessageCellLayout *)incommingMessageLayout;

/// 设置接收消息布局
/// @param incommingMessageLayout HHMessageCellLayout
+ (void)setIncommingMessageLayout:(HHMessageCellLayout *)incommingMessageLayout;

/// 发送消息布局
+ (HHMessageCellLayout *)outgoingMessageLayout;
+ (void)setOutgoingMessageLayout:(HHMessageCellLayout *)outgoingMessageLayout;

/// 系统消息布局
+ (HHMessageCellLayout *)systemMessageLayout;
+ (void)setSystemMessageLayout:(HHMessageCellLayout *)systemMessageLayout;

/// 文本消息（接收）布局
+ (HHMessageCellLayout *)incommingTextMessageLayout;
+ (void)setIncommingTextMessageLayout:(HHMessageCellLayout *)incommingTextMessageLayout;

/// 文本消息（发送）布局
+ (HHMessageCellLayout *)outgoingTextMessageLayout;
+ (void)setOutgoingTextMessageLayout:(HHMessageCellLayout *)outgoingTextMessageLayout;

@end

/////////////////////////////////////////////////////////////////////////////////
//
//                            HHmessageCell 的细化布局
//
/////////////////////////////////////////////////////////////////////////////////

/// 系统消息 单元布局
@interface HHSystemMessageCellLayout : HHMessageCellLayout

@end

/// 接收消息 单元布局
/// 用于接收消息时，消息单元的默认布局
@interface HHIncommingCellLayout : HHMessageCellLayout

@end

/// 发送消息 单元布局
@interface HHOutgoingCellLayout : HHMessageCellLayout

@end

/// 语音接收消息 单元布局
@interface HHIncommingVoiceCellLayout : HHIncommingCellLayout

@end

/// 语音发送消息 单元布局
@interface HHOutgoingVoiceCellLayout : HHOutgoingCellLayout

@end

/// 文本接收消息 单元布局
@interface HHIncommingTextCellLayout : HHIncommingCellLayout

@end

/// 文本发送消息 单元布局
@interface HHOutgoingTextCellLayout : HHOutgoingCellLayout

@end

NS_ASSUME_NONNULL_END
