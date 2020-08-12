//
//  UIButton+HHKeyBoard.m
//  YYT
//
//  Created by Henry on 2020/8/10.
//  Copyright © 2020 eastraycloud. All rights reserved.
//

#import "UIButton+HHKeyBoard.h"

@implementation UIButton (HHKeyBoard)

- (void)hh_setImage:(UIImage *)image imageHL:(UIImage *)imageHL {
    [self setImage:image forState:UIControlStateNormal];
    [self setImage:imageHL forState:UIControlStateHighlighted];
}

@end
