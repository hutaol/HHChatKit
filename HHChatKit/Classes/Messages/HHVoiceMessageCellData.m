//
//  HHVoiceMessageCellData.m
//  HHChatKit
//
//  Created by Henry on 2020/8/13.
//  Copyright © 2020 Henry. All rights reserved.
//

#import "HHVoiceMessageCellData.h"
#import "HHImageCache.h"
#import "HHHeader.h"
#import "HHKeyBoardHeader.h"

@interface HHVoiceMessageCellData ()

@end

@implementation HHVoiceMessageCellData

- (instancetype)initWithDirection:(HHMsgDirection)direction {
    self = [super initWithDirection:direction];
    if (self) {
        if (direction == MsgDirectionIncoming) {
            self.cellLayout = [HHIncommingVoiceCellLayout new];
            _voiceImage = [[HHImageCache sharedInstance] getImageFromMessageCache:@"message_voice_receiver_normal"];
       
            _voiceAnimationImages = [NSArray arrayWithObjects:
                                     [[HHImageCache sharedInstance] getImageFromMessageCache:@"message_voice_receiver_playing_1"],
                                     [[HHImageCache sharedInstance] getImageFromMessageCache:@"message_voice_receiver_playing_2"],
                                     [[HHImageCache sharedInstance] getImageFromMessageCache:@"message_voice_receiver_playing_3"], nil];
            _voiceTop = [[self class] incommingVoiceTop];
        } else {
            self.cellLayout = [HHOutgoingVoiceCellLayout new];
            
            _voiceImage = [[HHImageCache sharedInstance] getImageFromMessageCache:@"message_voice_sender_normal"];
            _voiceAnimationImages = [NSArray arrayWithObjects:
                                     [[HHImageCache sharedInstance] getImageFromMessageCache:@"message_voice_sender_playing_1"],
                                     [[HHImageCache sharedInstance] getImageFromMessageCache:@"message_voice_sender_playing_2"],
                                     [[HHImageCache sharedInstance] getImageFromMessageCache:@"message_voice_sender_playing_3"], nil];
            _voiceTop = [[self class] outgoingVoiceTop];
        }
    }
    return self;
}

- (CGSize)contentSize {
    
    CGFloat widthMax = kbScreenWidth * 0.4;
    CGFloat bubbleWidth = 60 + self.duration / 60.0 * kbScreenWidth;
    if (bubbleWidth > widthMax) {
        bubbleWidth = widthMax;
    }
    
    CGFloat bubbleHeight = 33;
    if (self.direction == MsgDirectionIncoming) {
        bubbleWidth = MAX(bubbleWidth, [HHBubbleMessageCellData incommingBubble].size.width);
        bubbleHeight = [HHBubbleMessageCellData incommingBubble].size.height;
    } else {
        bubbleWidth = MAX(bubbleWidth, [HHBubbleMessageCellData outgoingBubble].size.width);
        bubbleHeight = [HHBubbleMessageCellData outgoingBubble].size.height;
    }
    
    // TODO width 语音过期
    if (!self.innerMessage) {
        return CGSizeMake(180, bubbleHeight);
    }
    
    return CGSizeMake(bubbleWidth+33, bubbleHeight);
}


static CGFloat s_incommingVoiceTop = 12;

+ (void)setIncommingVoiceTop:(CGFloat)incommingVoiceTop {
    s_incommingVoiceTop = incommingVoiceTop;
}

+ (CGFloat)incommingVoiceTop {
    return s_incommingVoiceTop;
}

static CGFloat s_outgoingVoiceTop = 12;

+ (void)setOutgoingVoiceTop:(CGFloat)outgoingVoiceTop {
    s_outgoingVoiceTop = outgoingVoiceTop;
}

+ (CGFloat)outgoingVoiceTop {
    return s_outgoingVoiceTop;
}

@end
