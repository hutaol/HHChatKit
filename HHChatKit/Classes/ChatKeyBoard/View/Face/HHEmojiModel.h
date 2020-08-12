//
//  HHEmojiModel.h
//  YYT
//
//  Created by Henry on 2020/8/7.
//  Copyright © 2020 eastraycloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSInteger, HHEmojiType) {
    HHEmojiTypeSmall, //小图表情 7 * 3
    HHEmojiTypeBig    //大图表情 4 * 2
};

// emoji表情，包含🙂&[微笑]
@interface HHEmojiModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *image;

@end

// 大表情
@interface HHFaceModel : NSObject

@property (nonatomic, copy) NSString *image;

@end

@interface HHGroupEmojiModel : NSObject

@property (nonatomic, copy) NSString *groupImage;
@property (nonatomic, strong) NSArray<HHEmojiModel *> *emojis;
@property (nonatomic, strong) NSArray<HHFaceModel *> *faces;
@property (nonatomic, assign) HHEmojiType type;
@property (nonatomic, assign) NSInteger totalPages;

/// 创建文字类的小表情
/// @param plist 文件名
/// @param image 组图片名
+ (instancetype)initEmojiWithPlist:(NSString *)plist image:(NSString *)image;

///  创建图片类的小表情
/// @param plist 文件名
/// @param fileName 文件名前缀
/// @param image 组图片名
+ (instancetype)initEmojiWithPlist:(NSString *)plist fileName:(NSString *)fileName image:(NSString *)image;

/// 创建图片类大表情
/// @param name 文件名前缀
/// @param count 表情数量
/// @param image 组图片名
+ (instancetype)initFaceWithFileName:(nullable NSString *)name count:(NSInteger)count image:(NSString *)image;

@end

NS_ASSUME_NONNULL_END
