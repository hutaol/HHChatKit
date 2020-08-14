//
//  HHBubbleMessageCellData.h
//  HHChatKit
//
//  Created by Henry on 2020/8/13.
//  Copyright © 2020 Henry. All rights reserved.
//

#import "HHMessageCellData.h"

NS_ASSUME_NONNULL_BEGIN

@interface HHBubbleMessageCellData : HHMessageCellData

/// 气泡顶部
@property CGFloat bubbleTop;

/// 气泡图标（正常）
@property UIImage *bubble;

/// 气泡图标（高亮）
@property UIImage *highlightedBubble;

/// 发送气泡图标（正常 )
@property (nonatomic, class) UIImage *outgoingBubble;

/// 发送气泡图标（高亮）
@property (nonatomic, class) UIImage *outgoingHighlightedBubble;

/// 接收气泡图标（正常）
@property (nonatomic, class) UIImage *incommingBubble;

/// 接收气泡图标（高亮)
@property (nonatomic, class) UIImage *incommingHighlightedBubble;

/// 发送气泡顶部
@property (nonatomic, class) CGFloat outgoingBubbleTop;

/// 接收气泡顶部
@property (nonatomic, class) CGFloat incommingBubbleTop;

@end

NS_ASSUME_NONNULL_END
