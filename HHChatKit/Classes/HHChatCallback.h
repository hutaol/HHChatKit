//
//  HHChatCallback.h
//  HHChatKit
//
//  Created by Henry on 2020/8/12.
//  Copyright © 2020 Henry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HHChatComm.h"

@protocol HHChatCallback <NSObject>

- (void)onSucc;

- (void)onErr:(int)errCode errMsg:(NSString *)errMsg;

@end

/// 消息回调
@protocol HHMessageListener <NSObject>
@optional

/// 新消息回调通知
/// @param msgs msgs 新消息列表，HHMessage 类型数组
- (void)onNewMessage:(NSArray*) msgs;

@end
