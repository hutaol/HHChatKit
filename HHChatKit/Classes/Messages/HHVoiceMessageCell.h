//
//  HHVoiceMessageCell.h
//  HHChatKit
//
//  Created by Henry on 2020/8/13.
//  Copyright © 2020 Henry. All rights reserved.
//

#import "HHBubbleMessageCell.h"
#import "HHVoiceMessageCellData.h"

NS_ASSUME_NONNULL_BEGIN

@interface HHVoiceMessageCell : HHBubbleMessageCell

@property (nonatomic, strong) UIImageView *voice;

@property (nonatomic, strong) UILabel *duration;

@property (nonatomic, strong) UILabel *tipLabel;

@property HHVoiceMessageCellData *voiceData;

- (void)fillWithData:(HHVoiceMessageCellData *)data;

- (void)stopVoiceMessage;
- (void)playVoiceMessage;

@end

NS_ASSUME_NONNULL_END
