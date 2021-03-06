//
//  NSDate+HHChat.h
//  HHChatKit
//
//  Created by Henry on 2020/8/13.
//  Copyright © 2020 Henry. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (HHChat)

- (NSString *)shortTimeMessageString;
- (NSString *)timeMessageString;

/// 时间戳转时间date
/// @param timestamp 时间戳
+ (NSDate *)dateForTimestamp:(NSString *)timestamp;

/// 时间转时间戳
/// @param date 时间 精确秒
+ (NSString *)timestamp:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END
