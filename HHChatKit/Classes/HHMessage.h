//
//  HHMessage.h
//  HHChatKit
//
//  Created by Henry on 2020/8/12.
//  Copyright © 2020 Henry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HHCodingModel.h"
#import "HHChatComm.h"

NS_ASSUME_NONNULL_BEGIN

/// 消息Elem基类
@interface HHElem : HHCodingModel

@property (nonatomic, copy) NSString *type;

@end

/// 文本消息Elem
@interface HHTextElem : HHElem

/// 消息文本
@property (nonatomic, strong) NSString *text;

@end

@interface HHImageElem : HHElem

/// 要发送的图片路径
@property (nonatomic, strong) NSString *path;
/// 所有类型图片
@property (nonatomic, strong) NSArray *imageList;

@end

/// 文件消息Elem
@interface HHFileElem : HHElem

/// 上传时，文件的路径（设置path时，优先上传文件）
@property (nonatomic, strong) NSString *path;
/// 文件数据，发消息时设置，收到消息时不能读取，通过 getFileData 获取数据
@property (nonatomic, strong) NSData *data;
/// 文件大小
@property (nonatomic, assign) int fileSize;
/// 文件显示名，发消息时设置
@property(nonatomic, strong) NSString *filename;

@end

@interface HHSoundElem : HHElem

/// 上传时，语音文件的路径（设置path时，优先上传语音文件），接收时使用getSoundToFile获得数据
@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) NSData *data;
/// 语音数据大小
@property (nonatomic, assign) int dataSize;
/// 语音长度（秒），发送消息时设置
@property (nonatomic, assign) int second;

@end

@interface HHCustomElem : HHElem

/// 自定义消息二进制数据
@property(nonatomic, strong) NSData *data;

@end

@interface HHFaceElem : HHElem

/// 表情索引，用户自定义
@property (nonatomic, assign) int index;
/// 额外数据，用户自定义
@property (nonatomic, strong) NSData *data;

@end


@interface HHMessage : NSObject

/// 消息ID
@property (nonatomic, copy) NSString *msgId;
/// 消息状态
@property (nonatomic, assign) HHMessageStatus status;
/// 当前消息的时间戳
@property (nonatomic, copy) NSString *timestamp;
/// 是否已读
@property (nonatomic, assign) BOOL isReaded;
/// 是否发送方
@property (nonatomic, assign) BOOL isSelf;
/// 发送方
@property (nonatomic, copy) NSString *sender;


/// 增加Elem
/// @param elem elem结构
/// @return 0       表示成功
///         1       禁止添加Elem（文件或语音多于两个Elem）
///         2       未知Elem
- (int)addElem:(HHElem *)elem;

/// 获取对应索引的Elem
/// @param index 对应索引
/// @return 返回对应Elem
- (HHElem *)getElem:(int)index;

/// 获取Elem数量
- (int)elemCount;

@end

NS_ASSUME_NONNULL_END
