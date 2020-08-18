//
//  HHVoiceAnimationView.m
//  HHChatKit
//
//  Created by Henry on 2020/8/14.
//  Copyright © 2020 Henry. All rights reserved.
//

#import "HHVoiceAnimationView.h"
#import "HHAudioRecorder.h"
#import "HHKeyBoardHeader.h"
#import "HHImageCache.h"

@interface HHVoiceAnimationView ()

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) CAShapeLayer *maskLayer;

@property (nonatomic, assign) NSInteger count;

@end

@implementation HHVoiceAnimationView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        _iconImageView.image = [[HHImageCache sharedInstance] getImageFromKeyboardCache:@"icon_voice_nor"];

        [self addSubview:_iconImageView];
        
        _imageView = [[UIImageView alloc] init];
        _imageView.image = [[HHImageCache sharedInstance] getImageFromKeyboardCache:@"icon_voice_6"];

        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_imageView];
        
        _maskLayer = [CAShapeLayer layer];
        //默认显示一格的音量动画
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 55, 36.f, 11.f)];
        _maskLayer.path = path.CGPath;
        _maskLayer.fillRule = kCAFillRuleEvenOdd;
        _imageView.layer.mask = _maskLayer;
        
        _cancelImageView = [[UIImageView alloc] init];
        _cancelImageView.hidden = YES;
        _cancelImageView.image = [[HHImageCache sharedInstance] getImageFromKeyboardCache:@"icon_voice_cancel"];

        _cancelImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_cancelImageView];
        
        _stateLabel = [UILabel new];
        _stateLabel.textColor = [UIColor whiteColor];
        _stateLabel.font = [UIFont systemFontOfSize:15];
        _stateLabel.textAlignment = NSTextAlignmentCenter;
        _stateLabel.text = @"手指上滑，取消发送";
        _stateLabel.layer.cornerRadius = 3.f;
        [self addSubview:_stateLabel];
        
        _timeLabel = [UILabel new];
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.font = [UIFont systemFontOfSize:14];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.text = @"00:00";
        [self addSubview:_timeLabel];
        
        self.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.8];
        self.layer.cornerRadius = 5.f;
        
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(changeMaskView:) name:kHHAudioRecorderNotification object:nil];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.iconImageView.frame = CGRectMake(self.frame.size.width/2.f-34.f-12.f, 20.f, 34.f, 66.f);
    self.imageView.frame = CGRectMake(self.frame.size.width/2.f+12.f, 20.f, 26.f, 66.f);
    self.cancelImageView.frame = CGRectMake(self.iconImageView.frame.origin.x, 20.f, self.iconImageView.frame.size.width+self.imageView.frame.size.width+24, 66.f);
    self.timeLabel.frame = CGRectMake(0, (self.iconImageView.frame.origin.y+self.iconImageView.frame.size.height)+20.f, self.frame.size.width, 20.f);
    self.stateLabel.frame = CGRectMake(6.f, (self.timeLabel.frame.origin.y+self.timeLabel.frame.size.height)+12.f, self.frame.size.width-12.f, 24.f);
}

- (void)changeMaskView:(NSNotification *)noti {
    
    //vol的范围是0~100
    NSInteger vol = [noti.userInfo[@"voiceLevel"] integerValue];
    
    //将音量分成6份，100 / 6 = 16.6，取整
    CGFloat delta = (vol / 16) * 11.f;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 55.f - delta, 36.f, 11.f + delta)];
    self.maskLayer.path = path.CGPath;
    self.imageView.layer.mask = self.maskLayer;
    
    self.count++;
    
    NSLog(@"count: %ld", self.count);
    
    //每两次为1s，通知0.5s收到一次
    if (self.count % 2 == 0) {
        
        // TODO 录音最大60秒，50秒提醒
        if (self.count == 120) {
            // 主动结束录音
            if (self.timeoutEndRecordBlock) {
                self.timeoutEndRecordBlock();
            }
            return;
        }
        if (self.count >= 100) {
            self.timeLabel.text = [NSString stringWithFormat:@"%ld\"后将结束录音", (120-self.count)/2];
            return;
        }
        
        //此处-28800是因为多了8个小时，仅仅只使用日期后面的时分秒，前面的日期不管，方便计时
        NSTimeInterval second = self.count / 2.f - 28800;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:second];
        NSDateFormatter *formatter = [NSDateFormatter new];
        formatter.dateFormat = @"mm:ss";
        self.timeLabel.text = [formatter stringFromDate:date];
    }
}

- (void)setState:(HHVoiceState)state {
    _state = state;
    
    switch (state) {
        case HHVoiceNormal:
            self.iconImageView.hidden = NO;
            self.imageView.hidden = NO;
            self.timeLabel.hidden = NO;
            self.cancelImageView.hidden = YES;
            self.stateLabel.text = @"手指上滑，取消发送";
            self.stateLabel.backgroundColor = [UIColor clearColor];
            break;
        case HHVoiceWillCancel:
            self.iconImageView.hidden = YES;
            self.imageView.hidden = YES;
            self.timeLabel.hidden = YES;
            self.cancelImageView.hidden = NO;
            self.stateLabel.text = @"松开手指，取消发送";
            self.stateLabel.backgroundColor = [UIColor redColor];
            break;
        case HHVoiceCancel:
            self.iconImageView.hidden = YES;
            self.imageView.hidden = YES;
            self.timeLabel.hidden = YES;
            self.timeLabel.text = @"00:00";
            self.cancelImageView.hidden = NO;
            self.stateLabel.text = @"松开手指，取消发送";
            self.stateLabel.backgroundColor = [UIColor redColor];
            self.count = 0;
            break;
        case HHVoiceFinished:
            self.iconImageView.hidden = NO;
            self.imageView.hidden = NO;
            self.timeLabel.hidden = NO;
            self.timeLabel.text = @"00:00";
            self.cancelImageView.hidden = YES;
            self.stateLabel.text = @"手指上滑，取消发送";
            self.stateLabel.backgroundColor = [UIColor clearColor];
            self.count = 0;
            break;
    }
}

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

@end
