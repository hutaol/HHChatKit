//
//  HHMessageCellData.h
//  HHChatKit
//
//  Created by Henry on 2020/8/13.
//  Copyright © 2020 Henry. All rights reserved.
//

#import "HHCommonTableViewCell.h"
#import "HHMessageCellLayout.h"
#import "HHMessage.h"

NS_ASSUME_NONNULL_BEGIN

/**
 消息状态枚举

 - Msg_Status_Init: 消息创建
 - Msg_Status_Sending: 消息发送中
 - Msg_Status_Sending_2: 消息发送中_2，推荐使用
 - Msg_Status_Succ: 消息发送成功
 - Msg_Status_Fail: 消息发送失败
 */
typedef NS_ENUM(NSUInteger, HHMsgStatus) {
    Msg_Status_Init,
    Msg_Status_Sending,
    Msg_Status_Sending_2,
    Msg_Status_Succ,
    Msg_Status_Fail,
};

/**
 消息方向枚举 消息方向影响气泡图标、气泡位置等 UI 风格。

 - MsgDirectionIncoming: 消息接收
 - MsgDirectionOutgoing: 消息发送
 */
typedef NS_ENUM(NSUInteger, HHMsgDirection) {
    MsgDirectionIncoming,
    MsgDirectionOutgoing,
};

@interface HHMessageCellData : HHCommonCellData

// 已读 0-未读 已读后返回的值是seq
@property (nonatomic, strong) NSString *isread;

@property (nonatomic, strong) NSString *msgID;

@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSURL *avatarUrl;
@property (nonatomic, strong) UIImage *avatarImage;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, copy) NSString *time;

@property (nonatomic, assign) BOOL showName;
@property (nonatomic, assign) BOOL showTime;
@property HHMsgDirection direction;
@property (nonatomic, assign) HHMsgStatus status;

@property (nonatomic, strong) id innerMessage;

@property (nonatomic, strong) NSDictionary *innerData;


@property UIFont *nameFont;
@property UIColor *nameColor;
@property (nonatomic, class) UIColor *outgoingNameColor;
@property (nonatomic, class) UIFont *outgoingNameFont;
@property (nonatomic, class) UIColor *incommingNameColor;
@property (nonatomic, class) UIFont *incommingNameFont;

@property HHMessageCellLayout *cellLayout;


- (CGSize)contentSize;
- (instancetype)initWithDirection:(HHMsgDirection)direction;

@end

NS_ASSUME_NONNULL_END
