//
//  NSString+HHKeyBoard.h
//  YYT
//
//  Created by Henry on 2020/8/7.
//  Copyright © 2020 eastraycloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (HHKeyBoard)

/// 判断字符串的尾部是否是emoji表情
+ (BOOL)stringFromTrailIsEmoji:(NSString *)string;

/// 判断字符串里面是否包含emoji表情
+ (BOOL)stringContainsEmoji:(NSString *)string;

/// 删除[微笑]类的标签，判断是否为系统删除按钮
+ (void)deleteEmtionString:(UITextView *)textView isSystem:(BOOL)isSystem;

/// 将文字里面的包含的[微笑]类表情转换成attributedString返回
+ (NSMutableAttributedString *)emotionImgsWithString:(NSString *)string;

/// 去除字符串前后的空白，不包含换行符
- (NSString *)trim;

/// md5
+ (NSString *)md5String:(NSString *)str;
- (NSString *)md5;

@end

NS_ASSUME_NONNULL_END
