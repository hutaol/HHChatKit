//
//  HHMessageCell.h
//  HHChatKit
//
//  Created by Henry on 2020/8/13.
//  Copyright © 2020 Henry. All rights reserved.
//

#import "HHCommonTableViewCell.h"
#import "HHMessageCellData.h"

@class HHMessageCell;

NS_ASSUME_NONNULL_BEGIN

@protocol HHMessageCellDelegate <NSObject>

/// 长按消息回调
/// @param cell 委托者，消息单元
- (void)onLongPressMessage:(HHMessageCell *)cell;

/// 重发消息点击回调
/// @param cell 委托者，消息单元
- (void)onRetryMessage:(HHMessageCell *)cell;

/// 点击消息回调
/// @param cell 委托者，消息单元
- (void)onSelectMessage:(HHMessageCell *)cell;

/// 点击消息单元中消息头像的回调
/// @param cell 委托者，消息单元
- (void)onSelectMessageAvatar:(HHMessageCell *)cell;

@end

@interface HHMessageCell : HHCommonTableViewCell

/// 时间提示
@property (nonatomic, strong) UILabel *timeTipLabel;
/// 头像视图
@property (nonatomic, strong) UIImageView *avatarView;
/// 昵称标签
@property (nonatomic, strong) UILabel *nameLabel;

/// 容器视图
/// 包裹了 MesageCell 的各类视图，作为 MessageCell 的“底”，方便进行视图管理与布局
@property (nonatomic, strong) UIView *container;
/// 活动指示器
/// 在消息发送中提供转圈图标，表明消息正在发送
@property (nonatomic, strong) UIActivityIndicatorView *indicator;
/// 重发视图
@property (nonatomic, strong) UIImageView *retryView;
/// 消息已读控件
@property (nonatomic, strong) UIView *readReceiptView;

@property (readonly) HHMessageCellData *messageData;
@property (nonatomic, weak) id<HHMessageCellDelegate> delegate;

- (void)fillWithData:(HHCommonCellData *)data;

@end

NS_ASSUME_NONNULL_END
