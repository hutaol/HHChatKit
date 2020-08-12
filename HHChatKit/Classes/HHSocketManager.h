//
//  HHSocketManager.h
//  HHChatKit
//
//  Created by Henry on 2020/8/12.
//  Copyright © 2020 Henry. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HHSocketManager;

NS_ASSUME_NONNULL_BEGIN

/// socket状态
typedef NS_ENUM(NSInteger, HHSocketStatus) {
    HHSocketStatusNotConnected,     // 未连接
    HHSocketStatusConnected,        // 已连接
    HHSocketStatusFailed,           // 失败
    HHSocketStatusClosedByServer,   // 系统关闭
    HHSocketStatusClosedByUser,     // 用户关闭
    HHSocketStatusReceived          // 接收消息
};

/// 消息类型
typedef NS_ENUM(NSInteger, HHSocketReceiveType) {
    HHSocketReceiveTypeForMessage,
    HHSocketReceiveTypeForPong
};

@protocol HHSocketManagerDelegte <NSObject>

@optional

/// 消息接收
- (void)socketManager:(HHSocketManager *)manager receiveMessage:(id)message type:(HHSocketReceiveType)type;

/// 连接状态
- (void)socketManager:(HHSocketManager *)manager connectStatus:(HHSocketStatus)status;

/// 关闭
- (void)socketManager:(HHSocketManager *)manager closeCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean;

- (void)socketManager:(HHSocketManager *)manager sendMessageError:(HHSocketStatus)status;


@end


@interface HHSocketManager : NSObject

@property (nonatomic, weak) id<HHSocketManagerDelegte> delegate;

/// 当前的socket状态
@property (nonatomic, assign, readonly) HHSocketStatus socketStatus;

/// 超时重连时间，默认1秒
@property (nonatomic, assign) NSTimeInterval overtime;

/// 重连次数,默认5次
@property (nonatomic, assign) NSUInteger reconnectCount;

/// 单例调用
+ (instancetype)shareManager;

/// 开启socket
/// @param urlStr 服务器地址
- (void)open:(NSString *)urlStr;

/// 关闭socket
- (void)close;

/// 重连
- (void)reconnect;


/// 发送消息 NSString 或者 NSData
/// @param data Send a UTF8 String or Data.
- (void)send:(id)data;

/// 发送心跳包
/// @param data 心跳包内容
/// @param sendInterval 间隔时间
- (void)sendPing:(NSData *)data sendInterval:(NSTimeInterval)sendInterval;

@end

NS_ASSUME_NONNULL_END
