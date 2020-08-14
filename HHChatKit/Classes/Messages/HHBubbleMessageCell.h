//
//  HHBubbleMessageCell.h
//  HHChatKit
//
//  Created by Henry on 2020/8/13.
//  Copyright © 2020 Henry. All rights reserved.
//

#import "HHMessageCell.h"
#import "HHBubbleMessageCellData.h"

NS_ASSUME_NONNULL_BEGIN

@interface HHBubbleMessageCell : HHMessageCell

/// 气泡图像视图，即消息的气泡图标，在 UI 上作为气泡的背景板包裹消息信息内容
@property (nonatomic, strong) UIImageView *bubbleView;

@property HHBubbleMessageCellData *bubbleData;

- (void)fillWithData:(HHBubbleMessageCellData *)data;

@end

NS_ASSUME_NONNULL_END
