//
//  UIImage+HHKeyBoard.m
//  YYT
//
//  Created by Henry on 2020/8/7.
//  Copyright © 2020 eastraycloud. All rights reserved.
//

#import "UIImage+HHKeyBoard.h"

@implementation UIImage (HHKeyBoard)

+ (UIImage *)hh_imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

@end
