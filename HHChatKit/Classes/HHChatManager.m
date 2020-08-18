//
//  HHChatManager.m
//  HHChatKit
//
//  Created by Henry on 2020/8/12.
//  Copyright © 2020 Henry. All rights reserved.
//

#import "HHChatManager.h"
#import "HHSocketManager.h"
#import <YYModel/YYModel.h>
#import "HHMessage.h"
#import "NSDate+HHChat.h"

@interface HHChatManager () <HHSocketManagerDelegte>

@property (nonatomic, copy) NSString *userID;
@property (nonatomic, assign) HHChatLoginStatus status;

@property (nonatomic, copy) HHChatSucc succ;
@property (nonatomic, copy) HHChatFail fail;

@property (nonatomic, strong) NSMutableArray *datas;

@end

@implementation HHChatManager

+ (instancetype)shareManager {
    static HHChatManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)initKit:(NSString *)url {
    [[HHSocketManager shareManager] open:url];
    [HHSocketManager shareManager].delegate = self;
}

#pragma mark - HHSocketManagerDelegte

- (void)socketManager:(HHSocketManager *)manager connectStatus:(HHSocketStatus)status {
    
}

- (void)socketManager:(HHSocketManager *)manager receiveMessage:(id)message type:(HHSocketReceiveType)type {
    
    // TODO 验证发送成功
    
    if (type == HHSocketReceiveTypeForMessage) {
        // message NSString
        HHMessage *msg = [HHMessage yy_modelWithJSON:message];
        
        int isSendIndex = -1;
        for (int i = 0 ; i < self.datas.count; ++i) {
            HHMessage *mm = self.datas[i];
            if ([mm.msgId isEqualToString:msg.msgId]) {
                isSendIndex = i;
                break;
            }
        }
        
        if (isSendIndex >= 0) {
            // 验证发送成功
            [self.datas removeObjectAtIndex:isSendIndex];
            if (self.succ) {
                self.succ();
            }
            return;
        }
        
        if (self.messageListener) {
            msg.isSelf = NO;
            [self.messageListener onNewMessage:@[msg]];
        }
    }
}

- (void)socketManager:(HHSocketManager *)manager sendMessageError:(HHSocketStatus)status {
    if (self.fail) {
        self.fail((int)status, @"发送失败");
    }
}

- (void)socketManager:(HHSocketManager *)manager closeCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    
}

- (void)login:(NSString *)userID succ:(HHChatSucc)succ fail:(HHChatFail)fail {
    self.userID = userID;
    // TODO 登录
    self.status = HHCHAT_STATUS_LOGINED;
}

- (void)logout:(HHChatSucc)succ fail:(HHChatFail)fail {
    self.userID = nil;
    // TODO 登出
    self.status = HHCHAT_STATUS_LOGOUT;
}

- (NSString *)getLoginUser {
    return self.userID;
}

- (HHChatLoginStatus)getLoginStatus {
    return self.status;
}

- (int)sendMessage:(HHMessage *)msg succ:(HHChatSucc)succ fail:(HHChatFail)fail {
    self.succ = succ;
    self.fail = fail;
        
    [self.datas addObject:msg];

    NSString *str = [msg yy_modelToJSONString];
    
//    NSData *data = [msg yy_modelToJSONData];
//    NSLog(@"%@", [msg yy_modelToJSONString]);
    [[HHSocketManager shareManager] send:str];
    
    return 0;
}

- (NSMutableArray *)datas {
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

@end
