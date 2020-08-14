//
//  HHImageCache.h
//  HHChatKit
//
//  Created by Henry on 2020/8/13.
//  Copyright © 2020 Henry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define TResource(name) [[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"MessageResources" ofType:@"bundle"]] resourcePath] stringByAppendingPathComponent:name]

@interface HHImageCache : NSObject

+ (instancetype)sharedInstance;

/**
 *  将图像资源添加进本地缓存中
 *
 *  @param path 本地缓存所在路径
 */
- (void)addResourceToCache:(NSString *)path;

/**
 *  从本地缓存获取图像资源
 *
 *  @param path 本地缓存所在路径
 */
- (UIImage *)getResourceFromCache:(NSString *)path;

/**
 从本地缓存获取图像资源

 @param name 图片名字
 @return 图片
 */
- (UIImage *)getImageFromMessageCache:(NSString *)name;

/**
 *  将表情添加进本地缓存中
 *
 *  @param path 本地缓存所在路径
 */
- (void)addFaceToCache:(NSString *)path;

/**
 *  从本地缓存获取表情资源
 *
 *  @param path 本地缓存所在路径
 */
- (UIImage *)getFaceFromCache:(NSString *)path;

@end

NS_ASSUME_NONNULL_END
