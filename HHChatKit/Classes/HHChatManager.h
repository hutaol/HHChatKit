//
//  HHChatManager.h
//  HHChatKit
//
//  Created by Henry on 2020/8/12.
//  Copyright © 2020 Henry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HHChatCallback.h"
#import "HHMessage.h"

NS_ASSUME_NONNULL_BEGIN

/// 成功通用回调
typedef void (^HHChatSucc)(void);
/// 失败通用回调
typedef void (^HHChatFail)(int code, NSString *desc);

/// 登录状态
typedef NS_ENUM(NSInteger, HHChatLoginStatus) {
    HHCHAT_STATUS_LOGINED                   = 1,  ///< 已登录
    HHCHAT_STATUS_LOGINING                  = 2,  ///< 登录中
    HHCHAT_STATUS_LOGOUT                    = 3,  ///< 无登录
};

@interface HHChatManager : NSObject

@property (nonatomic, strong) id<HHMessageListener> messageListener;

+ (instancetype)shareManager;

- (void)initKit:(NSString *)url;

/// 登录
/// @param userID <#userID description#>
/// @param succ <#succ description#>
/// @param fail <#fail description#>
- (void)login:(NSString *)userID succ:(HHChatSucc)succ fail:(HHChatFail)fail;

/// 登出
/// @param succ <#succ description#>
/// @param fail <#fail description#>
- (void)logout:(HHChatSucc)succ fail:(HHChatFail)fail;

///  获取登录用户
- (NSString *)getLoginUser;

/// 获取登录状态
- (HHChatLoginStatus)getLoginStatus;


- (int)sendMessage:(HHMessage *)msg  succ:(HHChatSucc)succ fail:(HHChatFail)fail;


@end

NS_ASSUME_NONNULL_END
