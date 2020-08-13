//
//  HHBaseKeyboard.m
//  YYT
//
//  Created by Henry on 2020/8/10.
//  Copyright © 2020 eastraycloud. All rights reserved.
//

#import "HHBaseKeyboard.h"
#import "HHKeyBoardHeader.h"

@implementation HHBaseKeyboard

- (void)showWithAnimation:(BOOL)animation {
    [self showInView:[UIApplication sharedApplication].keyWindow withAnimation:animation];
}

- (void)showInView:(UIView *)view withAnimation:(BOOL)animation {
    if (_isShow) {
        return;
    }
    _isShow = YES;
    
    if (self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(chatKeyboardWillShow:animated:)]) {
        [self.keyboardDelegate chatKeyboardWillShow:self animated:animation];
    }
    
    [view addSubview:self];
    CGFloat keyboardHeight = [self keyboardHeight];
    
    self.frame = CGRectMake(0, view.frame.size.height, view.frame.size.width, keyboardHeight);
    
    CGRect rect = self.frame;
    rect.origin.y -= keyboardHeight;
    
    if (animation) {
        [UIView animateWithDuration:0.3 animations:^{
            self.frame = rect;
            
            if (self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(chatKeyboard:didChangeHeight:)]) {
                [self.keyboardDelegate chatKeyboard:self didChangeHeight:keyboardHeight];
            }
            
        } completion:^(BOOL finished) {
            if (self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(chatKeyboardDidShow:animated:)]) {
                [self.keyboardDelegate chatKeyboardDidShow:self animated:animation];
            }
        }];
    } else {
        self.frame = rect;
        if (self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(chatKeyboardDidShow:animated:)]) {
            [self.keyboardDelegate chatKeyboardDidShow:self animated:animation];
        }
    }
}

- (void)dismissWithAnimation:(BOOL)animation {
    if (!_isShow) {
        if (!animation) {
            [self removeFromSuperview];
        }
        return;
    }
    _isShow = NO;
    
    if (self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(chatKeyboardWillDismiss:animated:)]) {
        [self.keyboardDelegate chatKeyboardWillDismiss:self animated:animation];
    }
    
    if (animation) {
        CGFloat keyboardHeight = [self keyboardHeight];
        
        CGRect rect = self.frame;
        rect.origin.y += keyboardHeight;
        
        [UIView animateWithDuration:0.3 animations:^{
            self.frame = rect;
            
            if (self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(chatKeyboard:didChangeHeight:)]) {
                [self.keyboardDelegate chatKeyboard:self didChangeHeight:-keyboardHeight];
            }
            
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            
            if (self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(chatKeyboardDidDismiss:animated:)]) {
                [self.keyboardDelegate chatKeyboardDidDismiss:self animated:animation];
            }
        }];
    } else {
        [self removeFromSuperview];
        
        if (self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(chatKeyboardDidDismiss:animated:)]) {
            [self.keyboardDelegate chatKeyboardDidDismiss:self animated:animation];
        }
    }
}

- (void)reset {
    
}

#pragma mark - HHKeyboardProtocol
- (CGFloat)keyboardHeight {
    return 215 + kbHeightSafeBottom;
}

@end
