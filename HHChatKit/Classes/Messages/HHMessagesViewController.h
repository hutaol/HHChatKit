//
//  HHMessagesViewController.h
//  HHChatKit
//
//  Created by Henry on 2020/8/13.
//  Copyright © 2020 Henry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHKeyBoardMoreItem.h"
#import "HHTextMessageCell.h"
#import "HHImageMessageCell.h"
#import "HHVoiceMessageCell.h"
#import "HHSystemMessageCell.h"

NS_ASSUME_NONNULL_BEGIN

#define MessageCount 20

@interface HHMessagesViewController : UIViewController

/// 记录最新展示的时间消息
@property (nonatomic, strong) HHMessageCellData *msgForDate;
/// 记录最新的消息
@property (nonatomic, strong) HHMessageCellData *msgForGet;

/// 替换掉more items
- (void)repleceMoreItems:(NSMutableArray<HHKeyBoardMoreItem *> *)items;
/// 添加more item 默认有图片，拍摄
- (void)addMoreItem:(HHKeyBoardMoreItem *)item;

- (void)onActionPhoto;
- (void)onAcitonCamera;

/// 可重写 加载消息
- (void)loadMessageWithComplation:(void(^)(BOOL status, NSArray *msgs))complation;

@end

NS_ASSUME_NONNULL_END
