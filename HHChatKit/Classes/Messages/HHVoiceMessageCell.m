//
//  HHVoiceMessageCell.m
//  HHChatKit
//
//  Created by Henry on 2020/8/13.
//  Copyright © 2020 Henry. All rights reserved.
//

#import "HHVoiceMessageCell.h"
#import "UIView+HHLayout.h"

@implementation HHVoiceMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _voice = [[UIImageView alloc] init];
        _voice.animationDuration = 1;
        [self.bubbleView addSubview:_voice];
        
        _duration = [[UILabel alloc] init];
        _duration.font = [UIFont systemFontOfSize:12];
        _duration.textColor = [UIColor grayColor];
        [self.bubbleView addSubview:_duration];
        
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.font = [UIFont systemFontOfSize:12];
        _tipLabel.textColor = [UIColor grayColor];
        [self.bubbleView addSubview:_tipLabel];
        _tipLabel.hidden = YES;
        
    }
    return self;
}

- (void)stopVoiceMessage {
    [self.voice stopAnimating];
}

- (void)playVoiceMessage {
    [self.voice startAnimating];
}

- (void)fillWithData:(HHVoiceMessageCellData *)data {
    [super fillWithData:data];
    
    self.voiceData = data;

    _tipLabel.hidden = YES;

    // TODO 语音 需要TIMMessage innerMessage没有则显示语音已过期
//    if (data.innerMessage) {
//        _tipLabel.hidden = YES;
//
//    } else {
//        // 语音已过期
//        _tipLabel.text = @"语音已过期";
//        _tipLabel.hidden = NO;
//        if (data.direction == MsgDirectionOutgoing) {
//            // 发送
//            _tipLabel.textAlignment = NSTextAlignmentRight;
//        } else {
//            _tipLabel.textAlignment = NSTextAlignmentLeft;
//        }
//
//    }
    
    if (data.duration > 0) {
        _duration.text = [NSString stringWithFormat:@"%ld\"", (long)data.duration];
    } else {
        _duration.text = @"1\"";    // 显示0秒容易产生误解
    }
    _voice.image = data.voiceImage;
    _voice.animationImages = data.voiceAnimationImages;
    
    // TODO 语音未读
    self.readReceiptView.hidden = YES;
    if (self.voiceData.direction == MsgDirectionIncoming) {
        if (self.voiceData.isread &&  [self.voiceData.isread isEqualToString:@"0"]) {
            self.readReceiptView.hidden = NO;
        }
    }
    
    // TODO 下载语音文件
    
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.duration.mm_sizeToFitThan(10, 33).mm__centerY(self.bubbleView.mm_h/2-5);
    self.voice.mm_sizeToFit().mm_top(self.voiceData.voiceTop);
    
    if (self.voiceData.direction == MsgDirectionOutgoing) {
        self.bubbleView.mm_left(self.duration.mm_w).mm_flexToRight(0);
        self.voice.mm_right(self.voiceData.cellLayout.bubbleInsets.right);
        
        self.duration.mm_right(self.voice.mm_r + self.voice.mm_w + 8);

        if (!self.tipLabel.hidden) {
            self.tipLabel.mm_sizeToFitThan(100, 33).mm__centerY(self.bubbleView.mm_h/2-5);
            self.tipLabel.mm_right(self.duration.mm_r+self.duration.mm_w+8);
            
            // TODO
            self.bubbleView.mm_left(0).mm_flexToRight(0);
        }
        
    } else {
    
        self.bubbleView.mm_left(0).mm_flexToRight(self.duration.mm_w);
        self.voice.mm_left(self.voiceData.cellLayout.bubbleInsets.left);

        self.duration.mm_left(self.voice.mm_maxX + 8);
        
        if (!self.tipLabel.hidden) {
            self.tipLabel.mm_sizeToFitThan(100, 33).mm__centerY(self.bubbleView.mm_h/2-5);
            self.tipLabel.mm_left(self.duration.mm_maxX + 8);
            
            self.bubbleView.mm_left(0).mm_flexToRight(self.tipLabel.mm_r);
        }
    }
    
}

@end
