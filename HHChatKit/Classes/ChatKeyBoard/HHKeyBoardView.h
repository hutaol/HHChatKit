//
//  HHKeyBoardView.h
//  YYT
//
//  Created by Henry on 2020/8/7.
//  Copyright © 2020 eastraycloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHKeyBoardMoreItem.h"
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

// 点击更多
- (void)keyboard:(HHKeyBoardView *)keyboard didSelectedMoreItem:(HHKeyBoardMoreItem *)moreItem;

/// 发送语音文件
/// @param keyboard HHKeyBoardView
/// @param voice 字典 {path, duration} path:路径 duration:长度
- (void)keyboard:(HHKeyBoardView *)keyboard sendVoice:(NSDictionary *)voice;

@end

@interface HHKeyBoardView : UIView

@property (nonatomic, weak) id<HHKeyBoardViewDelegate> delegate;

/// 是否使用录音，默认显示
@property (nonatomic, assign) BOOL showVoice;
/// 是否使用表情，默认显示
@property (nonatomic, assign) BOOL showFace;
/// 是否使用更多，默认显示
@property (nonatomic, assign) BOOL showMore;


- (void)setText:(NSString *)text;
- (NSString *)getText;

// 收起键盘
- (void)dismissKeyboard;

- (void)setMoreItems:(NSMutableArray *)items;

@end

NS_ASSUME_NONNULL_END
