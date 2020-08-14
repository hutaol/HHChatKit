//
//  HHMessageCellData.m
//  HHChatKit
//
//  Created by Henry on 2020/8/13.
//  Copyright © 2020 Henry. All rights reserved.
//

#import "HHMessageCellData.h"

@implementation HHMessageCellData

- (instancetype)initWithDirection:(HHMsgDirection)direction {
    self = [super init];
    if (self) {
        _direction = direction;
        _status = Msg_Status_Init;
        _nameFont = [UIFont systemFontOfSize:13];
        _nameColor = [UIColor grayColor];
        
        _avatarImage = [UIImage imageNamed:@"avatar"];
        
        if (direction == MsgDirectionIncoming) {
            _cellLayout = [[HHIncommingCellLayout alloc] init];
        } else {
            _cellLayout = [[HHOutgoingCellLayout alloc] init];
        }
    }
    return self;
}

- (CGFloat)heightOfWidth:(CGFloat)width {
    CGFloat height = 0;
    
    if (self.showName)
        height += 20;
    
    if (self.showTime) {
        height += self.cellLayout.timeTipHeight;
    }
    
    CGSize containerSize = [self contentSize];
    height += containerSize.height;
    height += self.cellLayout.messageInsets.top + self.cellLayout.messageInsets.bottom;
    
    if (height < 55)
        height = 55;
    
    return height;
}

- (CGSize)contentSize {
    return CGSizeZero;
}


static UIColor *sOutgoingNameColor;

+ (UIColor *)outgoingNameColor {
    if (!sOutgoingNameColor) {
        sOutgoingNameColor = [UIColor whiteColor];
    }
    return sOutgoingNameColor;
}

+ (void)setOutgoingNameColor:(UIColor *)outgoingNameColor {
    sOutgoingNameColor = outgoingNameColor;
}

static UIFont *sOutgoingNameFont;

+ (UIFont *)outgoingNameFont {
    if (!sOutgoingNameFont) {
        sOutgoingNameFont = [UIFont systemFontOfSize:15];
    }
    return sOutgoingNameFont;
}

+ (void)setOutgoingNameFont:(UIFont *)outgoingNameFont {
    sOutgoingNameFont = outgoingNameFont;
}

static UIColor *sIncommingNameColor;

+ (UIColor *)incommingNameColor {
    if (!sIncommingNameColor) {
        sIncommingNameColor = [UIColor blackColor];
    }
    return sIncommingNameColor;
}

+ (void)setIncommingNameColor:(UIColor *)incommingNameColor {
    sIncommingNameColor = incommingNameColor;
}

static UIFont *sIncommingNameFont;

+ (UIFont *)incommingNameFont {
    if (!sIncommingNameFont) {
        sIncommingNameFont = [UIFont systemFontOfSize:15];
    }
    return sIncommingNameFont;
}

+ (void)setIncommingNameFont:(UIFont *)incommingNameFont {
    sIncommingNameFont = incommingNameFont;
}

@end
