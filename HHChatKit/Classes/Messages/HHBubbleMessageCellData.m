//
//  HHBubbleMessageCellData.m
//  HHChatKit
//
//  Created by Henry on 2020/8/13.
//  Copyright © 2020 Henry. All rights reserved.
//

#import "HHBubbleMessageCellData.h"
#import "HHImageCache.h"

@implementation HHBubbleMessageCellData

- (instancetype)initWithDirection:(HHMsgDirection)direction {
    self = [super initWithDirection:direction];
    if (self) {
        if (direction == MsgDirectionIncoming) {
            _bubble = [[self class] incommingBubble];
            _highlightedBubble = [[self class] incommingHighlightedBubble];
            _bubbleTop = [[self class] incommingBubbleTop];
        } else {
            _bubble = [[self class] outgoingBubble];
            _highlightedBubble = [[self class] outgoingHighlightedBubble];
            _bubbleTop = [[self class] outgoingBubbleTop];
        }
    }
    return self;
}


static UIImage *sOutgoingBubble;

+ (UIImage *)outgoingBubble {
    if (!sOutgoingBubble) {
        
        sOutgoingBubble = [[[HHImageCache sharedInstance] getImageFromMessageCache:@"message_bubble_sender"] resizableImageWithCapInsets:UIEdgeInsetsFromString(@"{30,20,22,20}") resizingMode:UIImageResizingModeStretch];
    }
    return sOutgoingBubble;
}

+ (void)setOutgoingBubble:(UIImage *)outgoingBubble {
    sOutgoingBubble = outgoingBubble;
}

static UIImage *sOutgoingHighlightedBubble;

+ (UIImage *)outgoingHighlightedBubble {
    if (!sOutgoingHighlightedBubble) {
        sOutgoingHighlightedBubble = [[[HHImageCache sharedInstance] getImageFromMessageCache:@"message_bubble_sender_hl"] resizableImageWithCapInsets:UIEdgeInsetsFromString(@"{30,20,22,20}") resizingMode:UIImageResizingModeStretch];
    }
    return sOutgoingHighlightedBubble;
}

+ (void)setOutgoingHighlightedBubble:(UIImage *)outgoingHighlightedBubble {
    sOutgoingHighlightedBubble = outgoingHighlightedBubble;
}

static UIImage *sIncommingBubble;

+ (UIImage *)incommingBubble {
    if (!sIncommingBubble) {
        sIncommingBubble = [ [[HHImageCache sharedInstance] getImageFromMessageCache:@"message_bubble_receiver"] resizableImageWithCapInsets:UIEdgeInsetsFromString(@"{30,22,22,22}") resizingMode:UIImageResizingModeStretch];
    }
    return sIncommingBubble;
}

+ (void)setIncommingBubble:(UIImage *)incommingBubble {
    sIncommingBubble = incommingBubble;
}

static UIImage *sIncommingHighlightedBubble;

+ (UIImage *)incommingHighlightedBubble {
    if (!sIncommingHighlightedBubble) {
        sIncommingHighlightedBubble = [[[HHImageCache sharedInstance] getImageFromMessageCache:@"message_bubble_receiver_hl"] resizableImageWithCapInsets:UIEdgeInsetsFromString(@"{30,22,22,22}") resizingMode:UIImageResizingModeStretch];
    }
    return sIncommingHighlightedBubble;
}

+ (void)setIncommingHighlightedBubble:(UIImage *)incommingHighlightedBubble {
    sIncommingHighlightedBubble = incommingHighlightedBubble;
}


static CGFloat sOutgoingBubbleTop = -2;

+ (CGFloat)outgoingBubbleTop {
    return sOutgoingBubbleTop;
}

+ (void)setOutgoingBubbleTop:(CGFloat)outgoingBubble {
    sOutgoingBubbleTop = outgoingBubble;
}

static CGFloat sIncommingBubbleTop = -2;

+ (CGFloat)incommingBubbleTop {
    return sIncommingBubbleTop;
}

+ (void)setIncommingBubbleTop:(CGFloat)incommingBubbleTop {
    sIncommingBubbleTop = incommingBubbleTop;
}


@end
