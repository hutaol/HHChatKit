//
//  HHMessageCellLayout.m
//  HHChatKit
//
//  Created by Henry on 2020/8/13.
//  Copyright © 2020 Henry. All rights reserved.
//

#import "HHMessageCellLayout.h"

@implementation HHMessageCellLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.avatarSize = CGSizeMake(40, 40);
        self.nameHorizontalMargin = 10;
        self.timeTipHeight = 20;
        self.avatarCorner = 20;
   }
    return self;
}

/// 接收消息布局

static HHMessageCellLayout *sIncommingMessageLayout;

+ (HHMessageCellLayout *)incommingMessageLayout {
    if (!sIncommingMessageLayout) {
        sIncommingMessageLayout = [HHIncommingCellLayout new];
    }
    return sIncommingMessageLayout;
}

+ (void)setIncommingMessageLayout:(HHMessageCellLayout *)incommingMessageLayout {
    sIncommingMessageLayout = incommingMessageLayout;
}

/// 发送消息布局

static HHMessageCellLayout *sOutgoingMessageLayout;

+ (HHMessageCellLayout *)outgoingMessageLayout {
    if (!sOutgoingMessageLayout) {
        sOutgoingMessageLayout = [HHMessageCellLayout new];
    }
    return sOutgoingMessageLayout;
}

+ (void)setOutgoingMessageLayout:(HHMessageCellLayout *)outgoingMessageLayout {
    sOutgoingMessageLayout = outgoingMessageLayout;
}

/// 系统消息

static HHMessageCellLayout *sSystemMessageLayout;

+ (HHMessageCellLayout *)systemMessageLayout {
    if (!sSystemMessageLayout) {
        sSystemMessageLayout = [HHSystemMessageCellLayout new];
    }
    return sSystemMessageLayout;
}

+ (void)setSystemMessageLayout:(HHMessageCellLayout *)systemMessageLayout {
    sSystemMessageLayout = systemMessageLayout;
}

/// 文本消息（接收）布局

static HHMessageCellLayout *sIncommingTextMessageLayout;

+ (HHMessageCellLayout *)incommingTextMessageLayout {
    if (!sIncommingTextMessageLayout) {
        sIncommingTextMessageLayout = [HHIncommingTextCellLayout new];
    }
    return sIncommingTextMessageLayout;
}

+ (void)setIncommingTextMessageLayout:(HHMessageCellLayout *)incommingTextMessageLayout {
    sIncommingTextMessageLayout = incommingTextMessageLayout;
}

/// 文本消息（发送）布局

static HHMessageCellLayout *sOutgingTextMessageLayout;

+ (HHMessageCellLayout *)outgoingTextMessageLayout {
    if (!sOutgingTextMessageLayout) {
        sOutgingTextMessageLayout = [HHOutgoingTextCellLayout new];
    }
    return sOutgingTextMessageLayout;
}

+ (void)setOutgoingTextMessageLayout:(HHMessageCellLayout *)outgoingTextMessageLayout {
    sOutgingTextMessageLayout = outgoingTextMessageLayout;
}


@end


/////////////////////////////////////////////////////////////////////////////////
//
//                            HHmessageCell 的细化布局
//
/////////////////////////////////////////////////////////////////////////////////


@implementation HHSystemMessageCellLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.messageInsets = (UIEdgeInsets){.top = 5, .bottom = 5};
    }
    return self;
}

@end


@implementation HHIncommingCellLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.avatarInsets = (UIEdgeInsets){
            .top = 5,
            .bottom = 5,
            .left = 5,
        };
        self.messageInsets = (UIEdgeInsets){
            .top = 5,
            .bottom = 5,
            .left = 5,
        };
    }
    return self;
}

@end


@implementation HHOutgoingCellLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.avatarInsets = (UIEdgeInsets){
            .top = 5,
            .bottom = 5,
            .right = 5,
        };
        self.messageInsets = (UIEdgeInsets){
            .top = 5,
            .bottom = 5,
            .right = 5,
        };
    }
    return self;
}

@end


@implementation HHIncommingVoiceCellLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.bubbleInsets = (UIEdgeInsets){.top = 14, .left = 19, .bottom = 20, .right = 22};
    }
    return self;
}

@end


@implementation HHOutgoingVoiceCellLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.bubbleInsets = (UIEdgeInsets){.top = 14, .left = 22, .bottom = 20, .right = 20};
    }
    return self;
}

@end


@implementation HHIncommingTextCellLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.bubbleInsets = (UIEdgeInsets){.top = 14, .left = 20, .bottom = 16, .right = 16};
    }
    return self;
}

@end


@implementation HHOutgoingTextCellLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.bubbleInsets = (UIEdgeInsets){.top = 14, .left = 16, .bottom = 16, .right = 20};
    }
    return self;
}

@end
