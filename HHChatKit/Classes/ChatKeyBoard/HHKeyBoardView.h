//
//  HHKeyBoardView.h
//  YYT
//
//  Created by Henry on 2020/8/7.
//  Copyright © 2020 eastraycloud. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HHKeyBoardView;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, HHKeyBoardState) {
    HHKeyBoardStateNormal,         //初始状态
    HHKeyBoardStateVoice,          //录音状态
    HHKeyBoardStateFace,           //表情状态
    HHKeyBoardStateMore,           //更多状态
    HHKeyBoardStateKeyBoard,       //系统键盘弹起状态
};

@protocol HHKeyBoardViewDelegate <NSObject>

- (void)keyboard:(HHKeyBoardView *)keyboard sendText:(NSString *)text;

- (void)keyboard:(HHKeyBoardView *)keyboard didChangeTextViewHeight:(CGFloat)height;

// 状态改变
- (void)keyboard:(HHKeyBoardView *)keyboard height:(CGFloat)height;

@end

@interface HHKeyBoardView : UIView

@property (nonatomic, weak) id<HHKeyBoardViewDelegate> delegate;

- (void)setText:(NSString *)text;
- (NSString *)getText;

// 收起键盘
- (void)dismissKeyboard;

@end

NS_ASSUME_NONNULL_END
