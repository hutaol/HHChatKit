//
//  HHVoiceAnimationView.h
//  HHChatKit
//
//  Created by Henry on 2020/8/14.
//  Copyright © 2020 Henry. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, HHVoiceState) {
    HHVoiceNormal,
    HHVoiceWillCancel,
    HHVoiceCancel,
    HHVoiceFinished
};

@interface HHVoiceAnimationView : UIView

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *cancelImageView;
@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, assign) HHVoiceState state;

@property (nonatomic, strong) void(^timeoutEndRecordBlock)(void);

@end

NS_ASSUME_NONNULL_END
