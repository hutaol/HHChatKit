//
//  HHTextMessageCellData.h
//  HHChatKit
//
//  Created by Henry on 2020/8/13.
//  Copyright © 2020 Henry. All rights reserved.
//

#import "HHBubbleMessageCellData.h"

NS_ASSUME_NONNULL_BEGIN

@interface HHTextMessageCellData : HHBubbleMessageCellData

/// 消息的文本内容
@property (nonatomic, strong) NSString *content;

/// 文本字体
@property (nonatomic, strong) UIFont *textFont;

/// 文本颜色
@property (nonatomic) UIColor *textColor;

/// 可变字符串 文本消息接收到 content 字符串后，需要将字符串中可能存在的字符串表情（比如[微笑]），转为图片表情
@property (nonatomic, strong) NSAttributedString *attributedString;

/// 文本内容尺寸 
@property (readonly) CGSize textSize;

/// 文本内容原点
@property (readonly) CGPoint textOrigin;

/// 文本消息颜色（发送）
@property (nonatomic, class) UIColor *outgoingTextColor;

/// 文本消息字体（发送)
@property (nonatomic, class) UIFont *outgoingTextFont;

/// 文本消息颜色（接收）
@property (nonatomic, class) UIColor *incommingTextColor;

/// 文本消息字体（接收）
@property (nonatomic, class) UIFont *incommingTextFont;

@end

NS_ASSUME_NONNULL_END
