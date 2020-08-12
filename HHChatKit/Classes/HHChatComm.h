//
//  HHChatComm.h
//  HHChatKit
//
//  Created by Henry on 2020/8/12.
//  Copyright © 2020 Henry. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 消息状态
typedef NS_ENUM(NSInteger, HHMessageStatus){
    HHMessageStatusSending             = 1,    // 消息发送中
    HHMessageStatusSendSucc            = 2,    // 消息发送成功
    HHMessageStatusSendFail            = 3,    // 消息发送失败
    HHMessageStatusHasDeleted          = 4,    // 消息被删除
    HHMessageStatusLocalStored         = 5,    // 导入到本地的消息
    HHMessageStatusLocalRevoked        = 6,    // 被撤销的消息
};
