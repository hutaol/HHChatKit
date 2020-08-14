//
//  HHMessagesViewController.h
//  HHChatKit
//
//  Created by Henry on 2020/8/13.
//  Copyright © 2020 Henry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHKeyBoardMoreItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface HHMessagesViewController : UIViewController

/// 替换掉more items
- (void)repleceMoreItems:(NSMutableArray<HHKeyBoardMoreItem *> *)items;
/// 添加more item 默认有图片，拍摄
- (void)addMoreItem:(HHKeyBoardMoreItem *)item;

- (void)onActionPhoto;
- (void)onAcitonCamera;

@end

NS_ASSUME_NONNULL_END
