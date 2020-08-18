//
//  HHHelper.h
//  HHChatKit
//
//  Created by Henry on 2020/8/13.
//  Copyright © 2020 Henry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^TAsyncImageComplete)(NSString *path, UIImage *image);

@interface HHHelper : NSObject

+ (void)asyncDecodeImage:(NSString *)path complete:(TAsyncImageComplete)complete;

+ (NSString *)randAvatarUrl;

/// 图片 -- 聊天
+ (NSString *)pathUserChatImage:(NSString *)imageName;
/// 语音 -- 聊天
+ (NSString *)pathUserChatVoice:(NSString *)voiceName;

@end

NS_ASSUME_NONNULL_END
