//
//  ToastTool.m
//  HHChatKit
//
//  Created by Henry on 2020/8/14.
//  Copyright © 2020 Henry. All rights reserved.
//

#import "ToastTool.h"

@implementation ToastTool

#pragma mark - 显示提示视图

+ (void)show:(NSString *)message {
    [self show:message position:ToastToolPositionBottom showTime:2.0];
}

+ (void)showAtTop:(NSString *)message {
    [self show:message position:ToastToolPositionTop showTime:2.0];
}

+ (void)showAtCenter:(NSString *)message {
    [self show:message position:ToastToolPositionCenter showTime:2.0];
}

+ (void)showLong:(NSString *)message {
    [self show:message position:ToastToolPositionBottom showTime:4.0];
}

+ (void)showLongAtTop:(NSString *)message {
    [self show:message position:ToastToolPositionTop showTime:4.0];
}

+ (void)showLongAtCenter:(NSString *)message {
    [self show:message position:ToastToolPositionCenter showTime:4.0];
}

static UILabel *toastView = nil;
+ (void)show:(NSString *)message position:(ToastToolPosition)position showTime:(float)showTime {
    if (![[NSThread currentThread] isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self show:message position:position showTime:showTime];
        });
        return;
    }
    @synchronized(self){
        if (toastView == nil) {
            toastView = [[UILabel alloc] init];
            toastView.backgroundColor = [UIColor darkGrayColor];
            toastView.textColor = [UIColor whiteColor];
            toastView.font = [UIFont systemFontOfSize:17];
            toastView.layer.masksToBounds = YES;
            toastView.layer.cornerRadius = 3.0f;
            toastView.textAlignment = NSTextAlignmentCenter;
            toastView.alpha = 0;
            toastView.numberOfLines = 0;
            toastView.lineBreakMode = NSLineBreakByCharWrapping;
            [[UIApplication sharedApplication].keyWindow addSubview:toastView];
        }
    }
    if (toastView.superview != [UIApplication sharedApplication].keyWindow) {
        [toastView removeFromSuperview];
        [[UIApplication sharedApplication].keyWindow addSubview:toastView];
        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:toastView];
    }
    
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    
    CGFloat width = [self stringText:message font:18 isHeightFixed:YES fixedValue:30];
    CGFloat height = 30;
    if (width > screenWidth - 20) {
        width = screenWidth - 20;
        height = [self stringText:message font:18 isHeightFixed:NO fixedValue:width];
    }
    
    CGFloat y = [UIScreen mainScreen].bounds.size.height*0.85;
    switch (position) {
        case ToastToolPositionTop:
            y = [UIScreen mainScreen].bounds.size.height*0.15;
            break;
        case ToastToolPositionCenter:
            y = [UIScreen mainScreen].bounds.size.height*0.5;
            break;
        case ToastToolPositionBottom:
            y = [UIScreen mainScreen].bounds.size.height*0.85;
            break;
            
        default:
            break;
    }
    CGRect frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-width)/2, y, width, height);
    toastView.alpha = 1;
    toastView.text = message;
    toastView.frame = frame;
    [UIView animateWithDuration:showTime animations:^{
        toastView.alpha = 0;
    } completion:^(BOOL finished) {
        [toastView removeFromSuperview];
    }];
}

//根据字符串长度获取对应的宽度或者高度
+ (CGFloat)stringText:(NSString *)text font:(CGFloat)font isHeightFixed:(BOOL)isHeightFixed fixedValue:(CGFloat)fixedValue {
    CGSize size;
    if (isHeightFixed) {
        size = CGSizeMake(MAXFLOAT, fixedValue);
    } else {
        size = CGSizeMake(fixedValue, MAXFLOAT);
    }
    
    CGSize resultSize;
    //返回计算出的size
    resultSize = [text boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:font]} context:nil].size;
    
    if (isHeightFixed) {
        return resultSize.width;
    } else {
        return resultSize.height;
    }
}

@end
