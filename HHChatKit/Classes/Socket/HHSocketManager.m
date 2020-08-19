//
//  HHSocketManager.m
//  HHChatKit
//
//  Created by Henry on 2020/8/19.
//  Copyright © 2020 Henry. All rights reserved.
//

#import "HHSocketManager.h"
#import "WebsocketStompKit.h"

@interface HHSocketManager () <STOMPClientDelegate>

@property (nonatomic, strong) STOMPClient *client;

@end

@implementation HHSocketManager

+ (instancetype)shareManager {
    static HHSocketManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)connect:(NSString *)url {
    
    NSDictionary *headers = nil;
    
    NSURL *websocketUrl = [NSURL URLWithString:url];
    STOMPClient *client = [[STOMPClient alloc] initWithURL:websocketUrl webSocketHeaders:headers useHeartbeat:YES];
    // 建立连接
    self.client = client;
    [client connectWithHeaders:headers completionHandler:^(STOMPFrame *connectedFrame, NSError *error) {
        NSLog(@"completionHandler: %@ | ", connectedFrame);
        if (error) {
            NSLog(@"completionHandler error: %@", error);
            return;
        }
         
        [client subscribeTo:@"/v2/im/to/123" messageHandler:^(STOMPMessage *message) {
            NSLog(@"body = %@",message.body);
        }];
        
        
    }];
     client.delegate = self; //添加代理监听连接状态

}

- (void)disconnect {
     [self.client disconnect];
}

- (void)subscribeTo:(NSString *)destination {
    // 注册协议
    [self.client subscribeTo:@"/v2/im/to/123" messageHandler:^(STOMPMessage *message) {
        NSLog(@"body = %@", message.body);
    }];
}

- (void)sendTo:(NSString *)destination body:(NSString *)body {
    [self.client sendTo:@"/v2/im/to/123/send" body:body];
}

#pragma mark - # STOMPClientDelegate

//与后台断开连接的回调方法 STOMPClientDelegate
- (void)websocketDidDisconnect:(NSError *)error {
    NSLog(@"websocketDidDisconnect: %@", error);
}


@end
