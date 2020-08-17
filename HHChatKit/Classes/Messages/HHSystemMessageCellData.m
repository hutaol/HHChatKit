//
//  HHSystemMessageCellData.m
//  HHChatKit
//
//  Created by Henry on 2020/8/13.
//  Copyright © 2020 Henry. All rights reserved.
//

#import "HHSystemMessageCellData.h"
#import "HHKeyBoardHeader.h"
#import "NSString+HHChat.h"

@implementation HHSystemMessageCellData

- (instancetype)initWithDirection:(HHMsgDirection)direction {
    self = [super initWithDirection:direction];
    if (self) {
        _contentFont = [UIFont systemFontOfSize:13];
        _contentColor = [UIColor colorWithRed:148.0 / 255.0
                                        green:149.0 / 255.0
                                         blue:149.0 / 255.0 alpha:1.0];
        self.cellLayout =  [HHMessageCellLayout systemMessageLayout];
    }
    return self;
}

- (CGSize)contentSize {
    CGSize size = [self.content textSizeIn:CGSizeMake(kbScreenWidth * 0.7, MAXFLOAT) font:self.contentFont];
    size.height += 10;
    size.width += 16;
    return size;
}

- (CGFloat)heightOfWidth:(CGFloat)width {
    CGFloat height = [self contentSize].height + 10;
    if (self.showTime) {
        height += self.cellLayout.timeTipHeight;
    }
    return height;
}

@end
