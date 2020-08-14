//
//  HHSystemMessageCell.h
//  HHChatKit
//
//  Created by Henry on 2020/8/13.
//  Copyright © 2020 Henry. All rights reserved.
//

#import "HHMessageCell.h"
#import "HHSystemMessageCellData.h"

NS_ASSUME_NONNULL_BEGIN

@interface HHSystemMessageCell : HHMessageCell

@property (nonatomic, strong) UILabel *messageLabel;

@property (nonatomic, strong) HHSystemMessageCellData *systemData;

- (void)fillWithData:(HHSystemMessageCellData *)data;

@end

NS_ASSUME_NONNULL_END
