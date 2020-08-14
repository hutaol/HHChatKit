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

@interface HHChatManager () <HHSocketManagerDelegte>

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
    if (type == HHSocketReceiveTypeForMessage) {
        // message NSString
        HHMessage *msg = [HHMessage yy_modelWithJSON:message];
        if (self.messageListener) {
            [self.messageListener onNewMessage:@[msg]];
        }
    }
}

- (void)socketManager:(HHSocketManager *)manager sendMessageError:(HHSocketStatus)status {
    
}

- (void)socketManager:(HHSocketManager *)manager closeCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    
}

- (int)sendMessage:(HHMessage *)msg cb:(id<HHChatCallback>)cb {
    
    NSString *str = [msg yy_modelToJSONString];
//    NSData *data = [msg yy_modelToJSONData];
//    NSLog(@"%@", [msg yy_modelToJSONString]);
   
    [[HHSocketManager shareManager] send:str];
    
    return 0;
}

@end
