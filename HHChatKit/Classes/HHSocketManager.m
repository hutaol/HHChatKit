//
//  HHSocketManager.m
//  HHChatKit
//
//  Created by Henry on 2020/8/12.
//  Copyright © 2020 Henry. All rights reserved.
//

#import "HHSocketManager.h"
#import <SocketRocket/SocketRocket.h>

@interface HHSocketManager () <SRWebSocketDelegate>

@property (nonatomic, strong) SRWebSocket *webSocket;
@property (nonatomic, assign) HHSocketStatus socketStatus;

@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, copy) NSString *urlString;

@end

@implementation HHSocketManager {
    NSInteger _reconnectCounter;
}

+ (instancetype)shareManager{
    static HHSocketManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        instance.overtime = 1;
        instance.reconnectCount = 5;
    });
    return instance;
}

- (void)open:(NSString *)urlStr {
    [self _open:urlStr];
}

- (void)close {
    [self _close];
}

// Send a UTF8 String or Data.
- (void)send:(id)data {
    switch (self.socketStatus) {
        case HHSocketStatusNotConnected:
        {
            // 未连接不会去自动重连
            NSLog(@"未连接。。。");
            if (self.delegate && [self.delegate respondsToSelector:@selector(socketManager:sendMessageError:)]) {
                [self.delegate socketManager:self sendMessageError:self.socketStatus];
            }
        }
            break;
        case HHSocketStatusConnected:
        case HHSocketStatusReceived:
        {
            NSLog(@"发送中。。。");
            [self.webSocket send:data];
            break;
        }
        case HHSocketStatusFailed:
        {
            NSLog(@"连接失败");
            if (self.delegate && [self.delegate respondsToSelector:@selector(socketManager:sendMessageError:)]) {
                [self.delegate socketManager:self sendMessageError:self.socketStatus];
            }
            // 连接失败会自动重连
            [self _reconnect];
        }
            break;
        case HHSocketStatusClosedByServer:
        case HHSocketStatusClosedByUser:
        {
            NSLog(@"已经关闭");
            if (self.delegate && [self.delegate respondsToSelector:@selector(socketManager:sendMessageError:)]) {
                [self.delegate socketManager:self sendMessageError:self.socketStatus];
            }
        }
            break;
    }
    
}

#pragma mark -- private method

- (void)_open:(id)params {
    NSString *urlStr = nil;
    if ([params isKindOfClass:[NSString class]]) {
        urlStr = (NSString *)params;
    } else if ([params isKindOfClass:[NSTimer class]]) {
        NSTimer *timer = (NSTimer *)params;
        urlStr = [timer userInfo];
    }
    self.urlString = urlStr;
    
    if (!self.urlString && !self.urlString.length) {
        //url不能空
        NSException *exception = [NSException exceptionWithName:@"URL Error" reason:@"URL is empty." userInfo:nil];
        [exception raise];
    }
    
    [self.webSocket close];
    self.webSocket.delegate = nil;
    
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"ws://%@:%@", server, port]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];

    self.webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
    self.webSocket.delegate = self;
    
    [self.webSocket open];
}

- (void)_close {
    [self.webSocket close];
    self.webSocket = nil;
    [self.timer invalidate];
    self.timer = nil;
}

- (void)_reconnect {
    // 计数+1
    if (_reconnectCounter < self.reconnectCount - 1) {
        _reconnectCounter ++;
        if (self.socketStatus == HHSocketStatusConnected || self.socketStatus == HHSocketStatusReceived) return;

        // 开启定时器
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.overtime target:self selector:@selector(_open:) userInfo:self.urlString repeats:NO];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        self.timer = timer;
    } else {
        NSLog(@"Websocket Reconnected Outnumber ReconnectCount");
        if (self.timer) {
            [self.timer invalidate];
            self.timer = nil;
        }
        return;
    }
    
}

#pragma mark -- SRWebSocketDelegate
- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    NSLog(@"Websocket Connected");
    
    // 开启成功后重置重连计数器
    _reconnectCounter = 0;
    [HHSocketManager shareManager].socketStatus = HHSocketStatusConnected;

    if (self.delegate && [self.delegate respondsToSelector:@selector(socketManager:connectStatus:)]) {
        [self.delegate socketManager:self connectStatus:HHSocketStatusConnected];
    }
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    NSLog(@":( Websocket Failed With Error %@", error);
    
    [HHSocketManager shareManager].socketStatus = HHSocketStatusFailed;

    if (self.delegate && [self.delegate respondsToSelector:@selector(socketManager:connectStatus:)]) {
        [self.delegate socketManager:self connectStatus:HHSocketStatusFailed];
    }
    // 重连
    [self _reconnect];
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    NSLog(@":( Websocket Receive With message %@", message);
    
    [HHSocketManager shareManager].socketStatus = HHSocketStatusReceived;
    if (self.delegate && [self.delegate respondsToSelector:@selector(socketManager:receiveMessage:type:)]) {
        [self.delegate socketManager:self receiveMessage:message type:HHSocketReceiveTypeForMessage];
    }
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    NSLog(@"Closed Reason:%@  code = %zd",reason,code);
    if (reason) {
        [HHSocketManager shareManager].socketStatus = HHSocketStatusClosedByServer;
        // 重连
        [self _reconnect];
    } else {
        [HHSocketManager shareManager].socketStatus = HHSocketStatusClosedByUser;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(socketManager:closeCode:reason:wasClean:)]) {
        [self.delegate socketManager:self closeCode:code reason:reason wasClean:wasClean];
    }
    self.webSocket = nil;
}

- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload {
    if (self.delegate && [self.delegate respondsToSelector:@selector(socketManager:receiveMessage:type:)]) {
        [self.delegate socketManager:self receiveMessage:pongPayload type:HHSocketReceiveTypeForPong];
    }
}

- (void)dealloc {
    // Close WebSocket
    [self _close];
}

@end
