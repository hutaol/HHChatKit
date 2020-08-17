//
//  HHConversation.h
//  HHChatKit
//
//  Created by Henry on 2020/8/17.
//  Copyright © 2020 Henry. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 会话类型
typedef NS_ENUM(NSInteger, HHConversationType) {
    HHConversationTypePersonal,     // 个人
    HHConversationTypeGroup,        // 群聊
    HHConversationTypePublic,       // 公众号
    HHConversationTypeServerGroup,  // 服务组（订阅号、企业号）
    HHConversationTypeNoNet,        // 无网络
};

typedef NS_ENUM(NSInteger, HHMessageRemindType) {
    HHMessageRemindTypeNormal,    // 正常接受
    HHMessageRemindTypeClosed,    // 不提示
    HHMessageRemindTypeNoHHook,   // 不看
    HHMessageRemindTypeUnlike,    // 不喜欢
};

@interface HHConversation : NSObject


/**
 *  会话类型（个人，讨论组，企业号）
 */
@property (nonatomic, assign) HHConversationType convType;

/**
 *  消息提醒类型
 */
@property (nonatomic, assign) HHMessageRemindType remindType;

/**
 *  用户ID
 */
@property (nonatomic, strong) NSString *partnerID;

/**
 *  用户名
 */
@property (nonatomic, strong) NSString *partnerName;

/**
 *  头像地址（网络）
 */
@property (nonatomic, strong) NSString *avatarURL;

/**
 *  头像地址（本地）
 */
@property (nonatomic, strong) NSString *avatarPath;

/**
 *  时间
 */
@property (nonatomic, strong) NSDate *date;

/**
 *  消息展示内容
 */
@property (nonatomic, strong) NSString *content;

/**
 *  未读数量
 */
@property (nonatomic, assign) NSInteger unreadCount;
@property (nonatomic, strong, readonly) NSString *badgeValue;
@property (nonatomic, assign, readonly) BOOL isRead;

@end

NS_ASSUME_NONNULL_END
