//
//  UIImageView+HHChat.m
//  HHChatKit
//
//  Created by Henry on 2020/8/13.
//  Copyright © 2020 Henry. All rights reserved.
//

#import "UIImageView+HHChat.h"

@implementation UIImageView (HHChat)

- (void)hh_setRoundedCorners:(CGFloat)radius {
    [self hh_setRoundedCorners:UIRectCornerAllCorners radius:radius];
}

- (void)hh_setRoundedCorners:(UIRectCorner)corners radius:(CGFloat)radius {
    CGRect rect = self.bounds;
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = rect;
    maskLayer.path = maskPath.CGPath;
    
    self.layer.mask = maskLayer;
}

@end
