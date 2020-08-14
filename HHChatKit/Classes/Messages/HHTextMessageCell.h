//
//  HHTextMessageCell.h
//  HHChatKit
//
//  Created by Henry on 2020/8/13.
//  Copyright © 2020 Henry. All rights reserved.
//

#import "HHBubbleMessageCell.h"
#import "HHTextMessageCellData.h"

NS_ASSUME_NONNULL_BEGIN

@interface HHTextMessageCell : HHBubbleMessageCell

@property (nonatomic, strong) UILabel *content;

@property HHTextMessageCellData *textData;

- (void)fillWithData:(HHTextMessageCellData *)data;

@end

NS_ASSUME_NONNULL_END
