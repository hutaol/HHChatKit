//
//  ChatRequestV2.h
//  HHChatKit
//
//  Created by Henry on 2020/8/19.
//  Copyright © 2020 Henry. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChatRequestV2 : NSObject

/// 创建会话
+ (void)createGroup:(NSString *)dgtype users:(NSArray *)users dgmrecordid:(NSString *)dgmrecordid completion:(void(^)(BOOL success, NSDictionary *info))completion;

/// 修改会话信息
+ (void)updateGroup:(NSString *)dgid dgname:(NSString *)dgname dgmrecordid:(NSString *)dgmrecordid completion:(void(^)(BOOL success, NSDictionary *info))completion;

/// 邀请/添加会话成员
+ (void)addMembersGroup:(NSString *)dgid users:(NSArray *)users completion:(void(^)(BOOL success, NSDictionary *info))completion;

/// 删除会话成员
+ (void)deleteMembersGroup:(NSString *)dgid users:(NSArray *)users completion:(void(^)(BOOL success, NSDictionary *info))completion;

/// 会话列表
+ (void)listGroup:(NSString *)type completion:(void(^)(BOOL success, NSDictionary *info))completion;


@end

NS_ASSUME_NONNULL_END
