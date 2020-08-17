//
//  HHVoiceMessageCellData.h
//  HHChatKit
//
//  Created by Henry on 2020/8/13.
//  Copyright © 2020 Henry. All rights reserved.
//

#import "HHBubbleMessageCellData.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, HHVoiceMessageStatus) {
    HHVoiceMessageStatusNormal,
    HHVoiceMessageStatusRecording,
    HHVoiceMessageStatusPlaying,
};

@interface HHVoiceMessageCellData : HHBubbleMessageCellData

///
@property (nonatomic, assign) HHVoiceMessageStatus voiceStatus;

/// 上传时，语音文件的路径，接收时使用 IM SDK 接口中的 getSound 获得数据
@property (nonatomic, strong) NSString *path;

/// 语音消息内部 ID
@property (nonatomic, strong) NSString *uuid;

/// 语音消息的时长
@property (nonatomic, assign) int duration;

/// 语音消息数据大小
@property (nonatomic, assign) int length;

@property (nonatomic, strong) NSString *url;

@property NSArray <UIImage *> *voiceAnimationImages;

@property UIImage *voiceImage;

@property (nonatomic, assign) BOOL isDownloading;

@property (nonatomic, assign) BOOL isPlaying;

@property (nonatomic, assign) CGFloat voiceTop;

@property (nonatomic, class) CGFloat incommingVoiceTop;

@property (nonatomic, class) CGFloat outgoingVoiceTop;

@end

NS_ASSUME_NONNULL_END
