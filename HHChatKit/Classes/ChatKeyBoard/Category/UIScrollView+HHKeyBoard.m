//
//  UIScrollView+HHKeyBoard.m
//  YYT
//
//  Created by Henry on 2020/8/11.
//  Copyright © 2020 eastraycloud. All rights reserved.
//

#import "UIScrollView+HHKeyBoard.h"

@implementation UIScrollView (HHKeyBoard)

#pragma mark - # ContentOffset
- (CGFloat)offsetX
{
    return self.contentOffset.x;
}
- (void)setOffsetX:(CGFloat)offsetX
{
    [self setOffsetX:offsetX animated:NO];
}
- (void)setOffsetX:(CGFloat)offsetX animated:(BOOL)animated
{
    CGPoint point = self.contentOffset;
    point.x = offsetX;
    [self setContentOffset:point animated:animated];
}

- (CGFloat)offsetY
{
    return self.contentOffset.y;
}
- (void)setOffsetY:(CGFloat)offsetY
{
    [self setOffsetY:offsetY animated:NO];
}
- (void)setOffsetY:(CGFloat)offsetY animated:(BOOL)animated
{
    CGPoint point = self.contentOffset;
    point.y = offsetY;
    [self setContentOffset:point animated:animated];
}

#pragma mark - # ContentSize
- (CGFloat)contentWidth
{
    return self.contentSize.width;
}
- (void)setContentWidth:(CGFloat)contentWidth
{
    CGSize size = self.contentSize;
    size.width = contentWidth;
    [self setContentSize:size];
}

- (CGFloat)contentHeight
{
    return self.contentSize.height;
}
- (void)setContentHeight:(CGFloat)contentHeight
{
    CGSize size = self.contentSize;
    size.height = contentHeight;
    [self setContentSize:size];
}

#pragma mark - # Scroll
- (void)scrollToTopWithAnimation:(BOOL)animation
{
    [self setOffsetY:0 animated:animation];
}

- (void)scrollToBottomWithAnimation:(BOOL)animation
{
    CGFloat viewHeight = self.frame.size.height;
    if (self.contentHeight > viewHeight) {
        CGFloat offsetY = self.contentHeight - viewHeight;
        [self setOffsetY:offsetY animated:animation];
    }
}


- (void)scrollToLeftWithAnimation:(BOOL)animation
{
    [self setOffsetX:0 animated:animation];
}

- (void)scrollToRightWithAnimation:(BOOL)animation
{
    CGFloat viewWidth = self.frame.size.width;
    if (self.contentWidth > viewWidth) {
        CGFloat offsetX = self.contentWidth - viewWidth;
        [self setOffsetX:offsetX animated:animation];
    }
}

@end
