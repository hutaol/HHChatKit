//
//  HHKeyBoardView.m
//  YYT
//
//  Created by Henry on 2020/8/7.
//  Copyright © 2020 eastraycloud. All rights reserved.
//

#import "HHKeyBoardView.h"
#import "HHKeyBoardTextView.h"
#import "HHKeyBoardMoreView.h"
#import "HHKeyBoardFaceView.h"
#import "HHVoiceAnimationView.h"

#import "HHAudioRecorder.h"

#import "UIColor+HHKeyBoard.h"
#import "NSString+HHKeyBoard.h"
#import "UIButton+HHKeyBoard.h"
#import "UIView+HHLayout.h"

#import "HHKeyBoardHeader.h"
#import "HHImageCache.h"

#define kButtonHeight            40.f   // 按钮高度
#define kHorizenSpace            10.f   // 按钮水平间隔
#define kVerticalSpace           7.f    // 按钮垂直间隔
#define kTextMargin          8.f    // 输入框内边距
#define height_textview      39.f
#define height_max_textview  112.f

@interface HHKeyBoardView () <UITextViewDelegate, HHKeyboardDelegate, HHKeyBoardMoreViewDelegate>
{
    UIImage *kVoiceImage;
    UIImage *kVoiceImageHL;
    UIImage *kFaceImage;
    UIImage *kFaceImageHL;
    UIImage *kMoreImage;
    UIImage *kMoreImageHL;
    UIImage *kKeyboardImage;
    UIImage *kKeyboardImageHL;
}

@property (nonatomic, strong) UIView *topBarView;

@property (nonatomic, strong) UIButton *voiceButton;
@property (nonatomic, strong) UIButton *faceButton;
@property (nonatomic, strong) UIButton *moreButton;
@property (nonatomic, strong) UIButton *recordButton;

@property (nonatomic, strong) HHKeyBoardTextView *textView;

@property (nonatomic, strong) HHKeyBoardMoreView *moreView;
@property (nonatomic, strong) HHKeyBoardFaceView *faceView;
@property (nonatomic, strong) HHVoiceAnimationView *voiceView;

// 当前键盘状态
@property (nonatomic, assign) HHKeyBoardState currentState;

// textView宽度
@property (nonatomic, assign) CGFloat textViewWidth;


@end

@implementation HHKeyBoardView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor hh_colorWithString:@"#fafafa"];
        self.layer.borderColor = [UIColor hh_colorWithString:@"#e0e0e0"].CGColor;
        self.layer.borderWidth = 1;
        
        [self p_initImage];

        _currentState = HHKeyBoardStateNormal;
        _showFace = YES;
        _showVoice = YES;
        _showMore = YES;
        
        _textViewWidth = self.frame.size.width-(5*kHorizenSpace)-(3*kButtonHeight);

        [self setupUI];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillHideNotification object:nil];
        
    }
    return self;
}

- (void)p_initImage {
    kVoiceImage = [[HHImageCache sharedInstance] getImageFromKeyboardCache:@"icon_keyboard_voice_nor"];
    kVoiceImageHL = [[HHImageCache sharedInstance] getImageFromKeyboardCache:@"icon_keyboard_voice_press"];

    kFaceImage = [[HHImageCache sharedInstance] getImageFromKeyboardCache:@"icon_keyboard_face_nor"];
    kFaceImageHL = [[HHImageCache sharedInstance] getImageFromKeyboardCache:@"icon_keyboard_face_press"];

    kMoreImage = [[HHImageCache sharedInstance] getImageFromKeyboardCache:@"icon_keyboard_add_nor"];
    kMoreImageHL = [[HHImageCache sharedInstance] getImageFromKeyboardCache:@"icon_keyboard_add_press"];

    kKeyboardImage = [[HHImageCache sharedInstance] getImageFromKeyboardCache:@"icon_keyboard_keyboard_nor"];
    kKeyboardImageHL = [[HHImageCache sharedInstance] getImageFromKeyboardCache:@"icon_keyboard_keyboard_press"];

}

- (void)setupUI {
    
    [self addSubview:self.recordButton];
    [self addSubview:self.voiceButton];
    [self addSubview:self.textView];
    [self addSubview:self.faceButton];
    [self addSubview:self.moreButton];
    
}

- (void)setMoreItems:(NSMutableArray *)items {
    self.moreView.keyboardMoreData = items;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.textViewWidth = self.frame.size.width-(5*kHorizenSpace)-(3*kButtonHeight);

    if (self.showVoice) {
        self.voiceButton.frame = CGRectMake(kHorizenSpace, self.frame.size.height-kVerticalSpace-kButtonHeight, kButtonHeight, kButtonHeight);
    } else {
        self.voiceButton.frame = CGRectZero;
        self.textViewWidth += (kButtonHeight+kHorizenSpace);
    }
    
    if (self.showMore) {
        self.moreButton.frame = CGRectMake(self.frame.size.width-kHorizenSpace-kButtonHeight, self.frame.size.height-kVerticalSpace-kButtonHeight, kButtonHeight, kButtonHeight);
    } else {
        self.moreButton.frame = CGRectZero;
        self.textViewWidth += (kButtonHeight+kHorizenSpace);
    }
    
    if (self.showFace) {
        self.faceButton.frame = CGRectMake(self.frame.size.width-(kHorizenSpace+kButtonHeight)*2, self.frame.size.height-kVerticalSpace-kButtonHeight, kButtonHeight, kButtonHeight);
    } else {
        self.faceButton.frame = CGRectZero;
        self.textViewWidth += (kButtonHeight+kHorizenSpace);
    }
    
    self.textView.frame = CGRectMake(self.voiceButton.frame.size.width+self.voiceButton.frame.origin.x+kHorizenSpace, kTextMargin, self.textViewWidth, self.frame.size.height-2*kTextMargin);
    
    self.recordButton.frame = self.textView.frame;

}

#pragma mark - NSNotification

- (void)keyboardWillChange:(NSNotification *)noti {
//    CGFloat duration = [[noti userInfo][UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGFloat height = [[[noti userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    NSLog(@"keyboardWillChange: %@", noti.name);
    NSLog(@"keyboardWillChange: %f", height);

    if (noti.name == UIKeyboardWillHideNotification) {
        // 隐藏键盘
        
    } else if (noti.name == UIKeyboardWillShowNotification) {
        // 展示键盘
        
        if (self.currentState == HHKeyBoardStateMore) {
            [self.moreButton hh_setImage:kMoreImage imageHL:kMoreImageHL];
            [self.moreView dismissWithAnimation:YES];

        } else if (self.currentState == HHKeyBoardStateFace) {
            [self.faceButton hh_setImage:kFaceImage imageHL:kFaceImageHL];
            [self.faceView dismissWithAnimation:YES];
        }
        
        self.currentState = HHKeyBoardStateKeyBoard;
        
        [self chatKeyboard:self didChangeHeight:height];
        
    }
}

#pragma mark - Public

- (void)setText:(NSString *)text {
    self.textView.text = text;
}

- (NSString *)getText {
    return self.textView.text;
}

// 收起键盘
- (void)dismissKeyboard {
    [self.textView resignFirstResponder];
    
    if (self.currentState == HHKeyBoardStateNormal) {
        return;
    }

    if (self.currentState == HHKeyBoardStateMore) {
        
        [self.moreButton hh_setImage:kMoreImage imageHL:kMoreImageHL];
        [self.moreView dismissWithAnimation:YES];
        self.currentState = HHKeyBoardStateNormal;
        
    } else if (self.currentState == HHKeyBoardStateFace) {
        
        [self.faceButton hh_setImage:kFaceImage imageHL:kFaceImageHL];
        [self.faceView dismissWithAnimation:YES];
        self.currentState = HHKeyBoardStateNormal;
        
    } else {
        [self chatKeyboard:self didChangeHeight:0];
        if (self.currentState == HHKeyBoardStateKeyBoard) {
            self.currentState = HHKeyBoardStateNormal;
        }
    }
    
}

#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.currentState = HHKeyBoardStateKeyBoard;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@""]) {
        // 在这里处理删除键的逻辑
        [self clickDeleteButton:YES];
    } else if ([text isEqualToString:@"\n"]) {
        [self sendCurrentText];
        return NO; // 这样才不会出现换行
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    [self p_reloadTextViewWithAnimation:YES];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    [self p_reloadTextViewWithAnimation:YES];
}

- (void)sendCurrentText {
    if (self.textView.text.length > 0) {     // send Text
        if (_delegate && [_delegate respondsToSelector:@selector(keyboard:sendText:)]) {
            [_delegate keyboard:self sendText:self.textView.text];
        }
    }
    self.textView.text = @"";
    [self p_reloadTextViewWithAnimation:YES];
}

- (void)clickDeleteButton:(BOOL)isSystem {
    if (self.textView.text.length > 0) {
        // 判断末尾是否是emoji表情
        BOOL isEmoji = [NSString stringFromTrailIsEmoji:self.textView.text];
        if (isEmoji && !isSystem) {
            self.textView.text = [self.textView.text substringToIndex:self.textView.text.length-2];
        } else if ([self.textView.text hasSuffix:@"]"]) {
            // 判断是否是[微笑]类表情
            [NSString deleteEmtionString:self.textView isSystem:isSystem];

        } else if (!isSystem) {
            self.textView.text = [self.textView.text substringToIndex:self.textView.text.length-1];
        }
    }
}

#pragma mark - HHKeyboardDelegate

- (void)chatKeyboardWillShow:(id)keyboard animated:(BOOL)animated {
    HHBaseKeyboard *baseKeyboard = (HHBaseKeyboard *)keyboard;
    if (_delegate && [_delegate respondsToSelector:@selector(keyboard:height:)]) {
        [self.delegate keyboard:self height:[baseKeyboard keyboardHeight]];
    }
}

- (void)chatKeyboardDidShow:(id)keyboard animated:(BOOL)animated {
    
}

- (void)chatKeyboard:(id)keyboard didChangeHeight:(CGFloat)height {
    NSLog(@"didChangeHeight: %f", height);
    CGRect rect = self.frame;
    height = MAX(height, kbHeightSafeBottom);
    rect.origin.y = self.superview.frame.size.height - height - self.frame.size.height;
    self.frame = rect;

    if (_delegate && [_delegate respondsToSelector:@selector(keyboard:height:)]) {
        [self.delegate keyboard:self height:height];
    }
}

#pragma mark - Private Methods

- (void)p_reloadTextViewWithAnimation:(BOOL)animation {
    
    // 获取textView最佳高度

    CGFloat textHeight = [self.textView sizeThatFits:CGSizeMake(self.textView.frame.size.width, MAXFLOAT)].height;
    NSLog(@"textHeight: %f", textHeight);

    CGFloat height = textHeight > height_textview ? textHeight : height_textview;
    height = (textHeight <= height_max_textview ? textHeight : height_max_textview);

    [self.textView setScrollEnabled:textHeight > height];

    if (height != self.textView.frame.size.height) {
        if (animation) {
            [UIView animateWithDuration:0.2 animations:^{

                CGRect rect = self.frame;
                CGFloat maxY = rect.size.height+rect.origin.y;
                
                rect.size.height = height+kTextMargin*2;

                rect.origin.y = maxY - rect.size.height;
                self.frame = rect;

                self.textView.mm_h = height;
                
                if (self.delegate && [self.delegate respondsToSelector:@selector(keyboard:didChangeTextViewHeight:)]) {
                    [self.delegate keyboard:self didChangeTextViewHeight:self.textView.frame.size.height];
                }

            } completion:^(BOOL finished) {
                if (textHeight > height) {
                    [self.textView setContentOffset:CGPointMake(0, textHeight - height) animated:YES];
                }
                
                if (self.delegate && [self.delegate respondsToSelector:@selector(keyboard:didChangeTextViewHeight:)]) {
                    [self.delegate keyboard:self didChangeTextViewHeight:height];
                }

            }];
        } else {
            self.textView.mm_h = height;
            if (textHeight > height) {
                [self.textView setContentOffset:CGPointMake(0, textHeight - height) animated:YES];
            }
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(keyboard:didChangeTextViewHeight:)]) {
                [self.delegate keyboard:self didChangeTextViewHeight:height];
            }
        }
    } else if (textHeight > height) {
        if (animation) {
            CGFloat offsetY = self.textView.contentSize.height - self.textView.mm_h;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.textView setContentOffset:CGPointMake(0, offsetY) animated:YES];
            });
        } else {
            [self.textView setContentOffset:CGPointMake(0, self.textView.contentSize.height - self.textView.mm_h) animated:NO];
        }
    }
}

- (void)keyboardChangeHeight:(CGFloat)height {
    
}

#pragma mark - Actions

static NSString *textRec = @"";

- (void)pressVoiceButton:(UIButton *)sender {
    if (self.currentState == HHKeyBoardStateVoice) {
        // 开始文字输入
        
        if (textRec.length > 0) {
            [self.textView setText:textRec];
            textRec = @"";
            [self p_reloadTextViewWithAnimation:YES];
        }
        
        [self.voiceButton hh_setImage:kVoiceImage imageHL:kVoiceImageHL];
        
        [self.textView becomeFirstResponder];
        self.textView.hidden = NO;
        self.recordButton.hidden = YES;
        self.currentState = HHKeyBoardStateKeyBoard;
        
    } else {
        // 开始语音
        if (self.textView.text.length > 0) {
            textRec = self.textView.text;
            self.textView.text = @"";
            [self p_reloadTextViewWithAnimation:YES];
        }
        
        if (_delegate && [_delegate respondsToSelector:@selector(keyboard:height:)]) {
            [self.delegate keyboard:self height:0];
        }
        
        if (self.currentState == HHKeyBoardStateFace) {
            [self.faceButton hh_setImage:kFaceImage imageHL:kFaceImageHL];
            [self.faceView dismissWithAnimation:YES];
        } else if (self.currentState == HHKeyBoardStateMore) {
            [self.moreButton hh_setImage:kMoreImage imageHL:kMoreImageHL];
            [self.moreView dismissWithAnimation:YES];
        } else {
            [self chatKeyboard:self didChangeHeight:0];
        }
        
        [self.voiceButton hh_setImage:kKeyboardImage imageHL:kKeyboardImageHL];
        
        [self.textView resignFirstResponder];
        self.textView.hidden = YES;
        self.recordButton.hidden = NO;
        self.currentState = HHKeyBoardStateVoice;
    }
}

- (void)pressFaceButton:(UIButton *)sender {
    if (self.currentState == HHKeyBoardStateFace) {
        // 开始文字输入
        [self.faceButton hh_setImage:kFaceImage imageHL:kFaceImageHL];
        
        [self.textView becomeFirstResponder];
        self.currentState = HHKeyBoardStateKeyBoard;
        [self.faceView dismissWithAnimation:YES];
    } else {
        // 打开表情键盘
        if (self.currentState == HHKeyBoardStateVoice) {
            [self.voiceButton hh_setImage:kVoiceImage imageHL:kVoiceImageHL];

            self.textView.hidden = NO;
            self.recordButton.hidden = YES;
        } else if (self.currentState == HHKeyBoardStateMore) {
            [self.moreButton hh_setImage:kMoreImage imageHL:kMoreImageHL];
            [self.moreView dismissWithAnimation:YES];
        }
        
        [self.faceButton hh_setImage:kKeyboardImage imageHL:kKeyboardImageHL];

        [self.textView resignFirstResponder];
        self.currentState = HHKeyBoardStateFace;
        
        [self.faceView showInView:self.superview withAnimation:YES];

    }
    
}

- (void)pressMoreButton:(UIButton *)sender {
    
    if (self.currentState == HHKeyBoardStateMore) {
        // 开始文字输入
        [self.moreButton hh_setImage:kMoreImage imageHL:kMoreImageHL];

        [self.textView becomeFirstResponder];
        self.currentState = HHKeyBoardStateKeyBoard;
        [self.moreView dismissWithAnimation:YES];
        
    } else {
        // 打开更多键盘
        if (self.currentState == HHKeyBoardStateVoice) {
            [self.voiceButton hh_setImage:kVoiceImage imageHL:kVoiceImageHL];
            self.textView.hidden = NO;
            self.recordButton.hidden = YES;
        } else if (self.currentState == HHKeyBoardStateFace) {
            [self.faceButton hh_setImage:kFaceImage imageHL:kFaceImageHL];
            [self.faceView dismissWithAnimation:YES];
        }
        [self.moreButton hh_setImage:kKeyboardImage imageHL:kKeyboardImageHL];

        [self.textView resignFirstResponder];
        self.currentState = HHKeyBoardStateMore;
        
        [self.moreView showInView:self.superview withAnimation:YES];
    }
     
}

// 开始录音
- (void)beginRecordVoice:(UIButton *)sender {
    NSLog(@"开始录音");
    if (![UIApplication.sharedApplication.keyWindow.subviews containsObject:self.voiceView]) {
        [UIApplication.sharedApplication.keyWindow addSubview:self.voiceView];
    }
    self.voiceView.state = HHVoiceNormal;
    [HHAudioRecorder.shared startRecord];
}

// 结束录音
- (void)endRecordVoice:(UIButton *)sender {
    NSLog(@"结束录音");
    [self sendVoice];
}

// 取消录音
- (void)cancelRecordVoice:(UIButton *)sender {
    NSLog(@"取消录音");
    if ([UIApplication.sharedApplication.keyWindow.subviews containsObject:self.voiceView]) {
        self.voiceView.state = HHVoiceCancel;
        [self.voiceView removeFromSuperview];
    }
    [HHAudioRecorder.shared cancelRecording];
}

// 将要取消录音
- (void)remindDragExit:(UIButton *)sender {
    NSLog(@"将要取消录音");
    self.voiceView.state = HHVoiceWillCancel;
}

// 继续录音
- (void)remindDragEnter:(UIButton *)sender {
    NSLog(@"继续录音");
    self.voiceView.state = HHVoiceNormal;
}

/// 发送录音文件
- (void)sendVoice {
    if (!self.voiceView || self.voiceView.state == HHVoiceFinished) {
        return;
    }
    if ([UIApplication.sharedApplication.keyWindow.subviews containsObject:self.voiceView]) {
        self.voiceView.state = HHVoiceFinished;
        [self.voiceView removeFromSuperview];
    }
    NSDictionary *recordInfo = [HHAudioRecorder.shared stopRecord];
    NSLog(@"recordInfo: %@", recordInfo);
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(keyboard:sendVoice:)]) {
        if (recordInfo) {
            [self.delegate keyboard:self sendVoice:recordInfo];
        }
    }
}

#pragma mark - HHKeyBoardMoreViewDelegate

- (void)keyboardMore:(id)keyboard didSelectedFunctionItem:(HHKeyBoardMoreItem *)funcItem {
    if (self.delegate && [self.delegate respondsToSelector:@selector(keyboard:didSelectedMoreItem:)]) {
        [self.delegate keyboard:self didSelectedMoreItem:funcItem];
    }
}

#pragma mark - Setters

- (void)setShowVoice:(BOOL)showVoice {
    _showVoice = showVoice;
    self.voiceButton.hidden = !showVoice;
    [self layoutSubviews];
    [self layoutIfNeeded];
}

- (void)setShowFace:(BOOL)showFace {
    _showFace = showFace;
    self.faceButton.hidden = !showFace;
    [self layoutSubviews];
    [self layoutIfNeeded];
}

- (void)setShowMore:(BOOL)showMore {
    _showMore = showMore;
    self.moreButton.hidden = !showMore;
    [self layoutSubviews];
    [self layoutIfNeeded];
}

#pragma mark - Getters

- (UIButton *)voiceButton {
    if (!_voiceButton) {
        _voiceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_voiceButton hh_setImage:kVoiceImage imageHL:kVoiceImageHL];
        [_voiceButton addTarget:self action:@selector(pressVoiceButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _voiceButton;
}

- (UIButton *)faceButton {
    if (!_faceButton) {
        _faceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_faceButton hh_setImage:kFaceImage imageHL:kFaceImageHL];
        [_faceButton addTarget:self action:@selector(pressFaceButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _faceButton;
}

- (UIButton *)moreButton {
    if (!_moreButton) {
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreButton hh_setImage:kMoreImage imageHL:kMoreImageHL];
        [_moreButton addTarget:self action:@selector(pressMoreButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreButton;
}

- (UIButton *)recordButton {
    if (!_recordButton) {
        _recordButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _recordButton.bounds = CGRectMake(0, 0, self.textViewWidth, kButtonHeight);
        _recordButton.backgroundColor = [UIColor whiteColor];
        _recordButton.layer.borderWidth = 0.5;
        _recordButton.layer.borderColor = [UIColor hh_colorWithString:@"#e0e0e0"].CGColor;
        _recordButton.clipsToBounds = YES;
        _recordButton.layer.cornerRadius = 3;
        _recordButton.userInteractionEnabled = YES;
        _recordButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [_recordButton setTitleColor:[UIColor hh_colorWithString:@"#646464"] forState:UIControlStateNormal];
        [_recordButton setTitle:@"按住 说话" forState:UIControlStateNormal];
        [_recordButton setTitle:@"松开 结束" forState:UIControlStateHighlighted];
        [_recordButton addTarget:self action:@selector(beginRecordVoice:) forControlEvents:UIControlEventTouchDown];
        [_recordButton addTarget:self action:@selector(endRecordVoice:) forControlEvents:UIControlEventTouchUpInside];
        [_recordButton addTarget:self action:@selector(cancelRecordVoice:) forControlEvents:UIControlEventTouchUpOutside | UIControlEventTouchCancel];
        [_recordButton addTarget:self action:@selector(remindDragExit:) forControlEvents:UIControlEventTouchDragExit];
        [_recordButton addTarget:self action:@selector(remindDragEnter:) forControlEvents:UIControlEventTouchDragEnter];
    }
    return _recordButton;
}

- (HHKeyBoardTextView *)textView {
    if (!_textView) {
        _textView = [[HHKeyBoardTextView alloc] init];
        _textView.delegate = self;
        _textView.returnKeyType = UIReturnKeySend;
        _textView.enablesReturnKeyAutomatically = YES;
        _textView.placeHolder = @"";
    }
    return _textView;
}

- (HHKeyBoardMoreView *)moreView {
    if (!_moreView) {
        _moreView = [[HHKeyBoardMoreView alloc] init];
        _moreView.keyboardDelegate = self;
        _moreView.delegate = self;
    }
    return _moreView;
}

- (HHKeyBoardFaceView *)faceView {
    if (!_faceView) {
        _faceView = [[HHKeyBoardFaceView alloc] init];
        _faceView.keyboardDelegate = self;
        _faceView.backgroundColor = [UIColor redColor];
    }
    return _faceView;
}

- (HHVoiceAnimationView *)voiceView {
    if (!_voiceView) {
        _voiceView = [[HHVoiceAnimationView alloc] initWithFrame:CGRectMake(kbScreenWidth/2.f-160.f/2.f, kbScreenHeight/2.f-180.f/2.f, 160.f, 180.f)];
        
        __weak typeof(self) weakSelf = self;
        _voiceView.timeoutEndRecordBlock = ^{
            [weakSelf sendVoice];
        };
    }
    return _voiceView;
}

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

@end
