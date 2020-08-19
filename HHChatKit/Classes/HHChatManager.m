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

@interface HHChatManager () <HHSocketManagerDelegate>

@property (nonatomic, copy) NSString *userID;
@property (nonatomic, copy) NSString *token;

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
    
    int one = rand()%999;
    NSString *two = @"jfq402wo";
    
    self.token = @"81f58a18a77b31141f514f0bd4b2c910a7";
    
    url = [NSString stringWithFormat:@"%@/%d/%@/websocket?access_token=%@", url, one , two, self.token?:@""];
    
    NSLog(@"connect url: %@", url);
    
    [[HHSocketManager shareManager] connect:url];
    [HHSocketManager shareManager].delegate = self;
}

#pragma mark - HHSocketManagerDelegte



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
    [[HHSocketManager shareManager] sendTo:@"/app/content" body:@"111"];
    
    return 0;
}

- (NSMutableArray *)datas {
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

@end
