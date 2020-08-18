//
//  AlertTool.m
//  YYT
//
//  Created by Henry on 2020/4/18.
//  Copyright © 2020 eastraycloud. All rights reserved.
//

#import "AlertTool.h"
#import "UIWindow+HHChat.h"

@implementation AlertTool

+ (UIViewController *)topViewController {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    return window.currentTopViewController;
}

// TODO 中英文
// 确定 警示框
+ (void)alertWithMessage:(NSString *)message {
    [AlertTool alertWithTitle:@"提示" message:message cancelTitle:nil buttonTitles:@[@"确定"] actionsBlock:nil];
}

// 取消，确定 警示框
+ (void)alert2WithMessage:(NSString *)message confirmBlock:(void (^)(NSInteger, NSString * _Nonnull))confirmBlock {

    [AlertTool alertWithTitle:@"提示" message:message cancelTitle:@"取消" buttonTitles:@[@"确定"] actionsBlock:^(NSInteger buttonIndex, NSString * _Nonnull buttonTitle) {
        if (buttonIndex == 0) {
            if (confirmBlock) {
                confirmBlock(0, buttonTitle);
            }
        }
    }];
}

+ (void)alert2WithMessage:(NSString *)message cancel:(NSString *)cancel confirm:(NSString *)confirm confirmBlock:(void (^)(NSInteger, NSString * _Nonnull))confirmBlock {

    [AlertTool alertWithTitle:@"提示" message:message cancelTitle:cancel buttonTitles:@[confirm] actionsBlock:^(NSInteger buttonIndex, NSString * _Nonnull buttonTitle) {
        if (buttonIndex == 0) {
            if (confirmBlock) {
                confirmBlock(0, buttonTitle);
            }
        }
    }];
}

#pragma mark - Alert
+ (void)alertWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle buttonTitles:(NSArray<NSString *> *)buttonTitles actionsBlock:(void (^)(NSInteger, NSString * _Nonnull))actionsBlock {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];

    if (cancelTitle) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            if (actionsBlock) {
                actionsBlock(-1, action.title);
            }
        }];
        [alertController addAction:action];
    }
    
    for (int i = 0; i < buttonTitles.count; i++) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:[buttonTitles objectAtIndex:i] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if (actionsBlock) {
                actionsBlock(i, action.title);
            }
        }];
        [alertController addAction:action];
    }

    [[AlertTool topViewController] presentViewController:alertController animated:YES completion:nil];

}

#pragma mark - Sheet
+ (void)sheetWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle destructiveTitle:(NSString *)destructiveTitle buttonTitles:(NSArray<NSString *> *)buttonTitles actionsBlock:(void (^)(NSInteger, NSString * _Nonnull))actionsBlock {
        
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    
    if (cancelTitle) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            if (actionsBlock) {
                actionsBlock(-1, action.title);
            }
        }];
        [alertController addAction:action];
    }
    
    if (destructiveTitle) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            if (actionsBlock) {
                actionsBlock(-2, action.title);
            }
        }];
        [alertController addAction:action];
    }
    
    for (int i = 0; i < buttonTitles.count; i++) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:[buttonTitles objectAtIndex:i] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if (actionsBlock) {
                actionsBlock(i, action.title);
            }
        }];
        [alertController addAction:action];
    }

    UIViewController *curVC = [AlertTool topViewController];

    if (curVC) {
        
        UIDevice *currentDevice = [UIDevice currentDevice];
        // ipad
        if (currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad && [alertController respondsToSelector:@selector(popoverPresentationController)]) {
            alertController.popoverPresentationController.sourceView = curVC.view; // 必须加
        }
        [curVC presentViewController:alertController animated:YES completion:nil];
        
    }
}

+ (void)sheetWithMessage:(NSString *)message buttonTitles:(NSArray<NSString *> *)buttonTitles actionsBlock:(void (^)(NSInteger, NSString * _Nonnull))actionsBlock {
    [self sheetWithTitle:nil message:message cancelTitle:@"取消" destructiveTitle:nil buttonTitles:buttonTitles actionsBlock:^(NSInteger buttonIndex, NSString * _Nonnull buttonTitle) {
        if (buttonIndex >= 0) {
            if (actionsBlock) {
                actionsBlock(buttonIndex, buttonTitle);
            }
        }
    }];
}

@end
