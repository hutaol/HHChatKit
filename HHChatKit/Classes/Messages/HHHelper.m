//
//  HHHelper.m
//  HHChatKit
//
//  Created by Henry on 2020/8/13.
//  Copyright © 2020 Henry. All rights reserved.
//

#import "HHHelper.h"
#import "PathTool.h"
#import "NSString+HHKeyBoard.h"

@implementation HHHelper

+ (void)asyncDecodeImage:(NSString *)path complete:(TAsyncImageComplete)complete {
    static dispatch_queue_t queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("com.hhchatkit.asyncDecodeImage", DISPATCH_QUEUE_SERIAL);
    });
    
    dispatch_async(queue, ^{
        if(path == nil){
            return;
        }
        
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        if (image == nil) {
            return;
        }
        
        // 获取CGImage
        CGImageRef cgImage = image.CGImage;
        
        // alphaInfo
        CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(cgImage) & kCGBitmapAlphaInfoMask;
        BOOL hasAlpha = NO;
        if (alphaInfo == kCGImageAlphaPremultipliedLast ||
            alphaInfo == kCGImageAlphaPremultipliedFirst ||
            alphaInfo == kCGImageAlphaLast ||
            alphaInfo == kCGImageAlphaFirst) {
            hasAlpha = YES;
        }
        
        // bitmapInfo
        CGBitmapInfo bitmapInfo = kCGBitmapByteOrder32Host;
        bitmapInfo |= hasAlpha ? kCGImageAlphaPremultipliedFirst : kCGImageAlphaNoneSkipFirst;
        
        // size
        size_t width = CGImageGetWidth(cgImage);
        size_t height = CGImageGetHeight(cgImage);
        
        // 解码：把位图提前画到图形上下文，生成 cgImage，就完成了解码。
        // context
        CGContextRef context = CGBitmapContextCreate(NULL, width, height, 8, 0, CGColorSpaceCreateDeviceRGB(), bitmapInfo);
        
        // draw
        CGContextDrawImage(context, CGRectMake(0, 0, width, height), cgImage);
        
        // get CGImage
        cgImage = CGBitmapContextCreateImage(context);
        
        // 解码后的图片，包装成 UIImage 。
        // into UIImage
        UIImage *newImage = [UIImage imageWithCGImage:cgImage scale:image.scale orientation:image.imageOrientation];
        
        // release
        if(context) CGContextRelease(context);
        if(cgImage) CGImageRelease(cgImage);
        
        //callback
        if(complete){
            complete(path, newImage);
        }
    });
}

+ (NSString *)randAvatarUrl {
    return [NSString stringWithFormat:@"https://picsum.photos/id/%d/200/200", rand()%999];
}

+ (NSString *)getImagePath {
    NSString *filePath = [PathTool getFileDocumentPath:@"/HHChatKit/image"];
    
    [PathTool createDirectory:filePath];
    
    NSString *name = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];

    return [NSString stringWithFormat:@"%@/%@", filePath, [name md5]];

}

@end
