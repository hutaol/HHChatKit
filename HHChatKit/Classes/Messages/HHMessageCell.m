//
//  HHMessageCell.m
//  HHChatKit
//
//  Created by Henry on 2020/8/13.
//  Copyright © 2020 Henry. All rights reserved.
//

#import "HHMessageCell.h"
#import <SDWebImage/SDWebImage.h>
#import "NSDate+HHChat.h"
#import "HHImageCache.h"
#import "UIView+HHLayout.h"
#import "UIImageView+HHChat.h"

@interface HHMessageCell ()

@property (nonatomic, strong) HHMessageCellData *messageData;

@end

@implementation HHMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style
                    reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        
        // timd
        _timeTipLabel = [[UILabel alloc] init];
        _timeTipLabel.font = [UIFont systemFontOfSize:10];
        _timeTipLabel.textColor = [UIColor lightGrayColor];
        _timeTipLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_timeTipLabel];
        
        // head
        _avatarView = [[UIImageView alloc] init];
        _avatarView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_avatarView];
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onSelectMessageAvatar:)];
        [_avatarView addGestureRecognizer:tap1];
        [_avatarView setUserInteractionEnabled:YES];
                
        // nameLabel
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:13];
        _nameLabel.textColor = [UIColor grayColor];
        [self addSubview:_nameLabel];
        
        // container
        _container = [[UIView alloc] init];
        _container.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onSelectMessage:)];
        [_container addGestureRecognizer:tap];
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onLongPress:)];
        [_container addGestureRecognizer:longPress];
        [self addSubview:_container];
        
        // indicator
        _indicator = [[UIActivityIndicatorView alloc] init];
        _indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        [self addSubview:_indicator];
        
        // error
        _retryView = [[UIImageView alloc] init];
        _retryView.userInteractionEnabled = YES;
        UITapGestureRecognizer *resendTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onRetryMessage:)];
        [_retryView addGestureRecognizer:resendTap];
        [self addSubview:_retryView];
        
        //已读label,由于 indicator 和 error，所以默认隐藏，消息发送成功后进行显示
        _readReceiptView = [[UIView alloc] init];
        _readReceiptView.hidden = YES;
        _readReceiptView.backgroundColor = [UIColor redColor];
        _readReceiptView.layer.cornerRadius = 4;
        [self addSubview:_readReceiptView];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)fillWithData:(HHMessageCellData *)data {
    [super fillWithData:data];
    self.messageData = data;
    
    [self.avatarView sd_setImageWithURL:data.avatarUrl placeholderImage:data.avatarImage options:SDWebImageDecodeFirstFrameOnly context:nil];
    

    self.nameLabel.text = data.name;
    self.nameLabel.textColor = data.nameColor;
    self.nameLabel.font = data.nameFont;
    
    NSDate *date = [NSDate dateForTimestamp:data.time];
    self.timeTipLabel.text = [date timeMessageString];
    
    if (data.status == Msg_Status_Fail) {
        [_indicator stopAnimating];
        self.retryView.image = [[HHImageCache sharedInstance] getImageFromMessageCache:@"msg_error"];
    } else {
        if (data.status == Msg_Status_Sending_2) {
            [_indicator startAnimating];
        }
        else if(data.status == Msg_Status_Succ){
            [_indicator stopAnimating];
        }
        else if(data.status == Msg_Status_Sending){
            [_indicator stopAnimating];
        }
        self.retryView.image = nil;
    }
    
    // 未读
    self.readReceiptView.hidden = YES;

}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.messageData.showName) {
        _nameLabel.mm_sizeToFitThan(1, 20);
        _nameLabel.hidden = NO;
    } else {
        _nameLabel.mm_height(0);
        _nameLabel.hidden = YES;
    }
    
    HHMessageCellLayout *cellLayout = self.messageData.cellLayout;

    if (self.messageData.showTime) {
        _timeTipLabel.mm_left(0).mm_flexToRight(0).mm_top(0).mm_height(cellLayout.timeTipHeight);
        _timeTipLabel.hidden = NO;
    } else {
        _timeTipLabel.mm_height(0);
        _timeTipLabel.hidden = YES;
    }
    
    if (self.messageData.direction == MsgDirectionIncoming) {
        
        self.avatarView.mm_x = cellLayout.avatarInsets.left;
        self.avatarView.mm_y = _timeTipLabel.mm_maxY + cellLayout.avatarInsets.top;
        self.avatarView.mm_w = cellLayout.avatarSize.width;
        self.avatarView.mm_h = cellLayout.avatarSize.height;
        
        self.nameLabel.mm_top(self.avatarView.mm_y);
        
        CGSize csize = [self.messageData contentSize];
        CGFloat ctop = cellLayout.messageInsets.top + _nameLabel.mm_h + _timeTipLabel.mm_h;
        self.container.mm_left(cellLayout.messageInsets.left+self.avatarView.mm_maxX)
        .mm_top(ctop).mm_width(csize.width).mm_height(csize.height);
        
        self.nameLabel.mm_left(_container.mm_x+cellLayout.nameHorizontalMargin);
        self.indicator.mm_sizeToFit().mm__centerY(_container.mm_centerY).mm_left(_container.mm_maxX + 8);
        self.retryView.frame = self.indicator.frame;
        
        // 这里不能像 retryView 一样直接使用 indicator 的设定，否则内容会显示不全。
//        self.readReceiptView.mm_sizeToFitThan(0, self.indicator.mm_w).mm_bottom(self.container.mm_b + cellLayout.bubbleInsets.bottom).mm_left(_container.mm_maxX + 8);
        self.readReceiptView.mm_sizeToFitThan(8, 8).mm_bottom(self.container.mm_b + cellLayout.bubbleInsets.bottom).mm_left(_container.mm_maxX);


    } else {
        
        self.avatarView.mm_w = cellLayout.avatarSize.width;
        self.avatarView.mm_h = cellLayout.avatarSize.height;
        self.avatarView.mm_top(cellLayout.avatarInsets.top+_timeTipLabel.mm_maxY).mm_right(cellLayout.avatarInsets.right);
        
        self.nameLabel.mm_top(self.avatarView.mm_y);
        
        CGSize csize = [self.messageData contentSize];
        CGFloat ctop = cellLayout.messageInsets.top + _nameLabel.mm_h + _timeTipLabel.mm_h;
        self.container.mm_width(csize.width).mm_height(csize.height)
        .mm_right(cellLayout.messageInsets.right+self.mm_w-self.avatarView.mm_x).mm_top(ctop);
        
        self.nameLabel.mm_right(_container.mm_r+cellLayout.nameHorizontalMargin);
        self.indicator.mm_sizeToFit().mm__centerY(_container.mm_centerY).mm_left(_container.mm_x - 8 - _indicator.mm_w);
        self.retryView.frame = self.indicator.frame;
        self.readReceiptView.hidden = YES;

    }
    
    [self.avatarView hh_setRoundedCorners:cellLayout.avatarCorner];

}


#pragma mark --

- (void)onLongPress:(UIGestureRecognizer *)recognizer {
    if ([recognizer isKindOfClass:[UILongPressGestureRecognizer class]] &&
       recognizer.state == UIGestureRecognizerStateBegan) {
        if(_delegate && [_delegate respondsToSelector:@selector(onLongPressMessage:)]){
            [_delegate onLongPressMessage:self];
        }
    }
}

- (void)onRetryMessage:(UIGestureRecognizer *)recognizer {
    if (_messageData.status == Msg_Status_Fail) {
        if (_delegate && [_delegate respondsToSelector:@selector(onRetryMessage:)]) {
            [_delegate onRetryMessage:self];
        }
    }
}

- (void)onSelectMessage:(UIGestureRecognizer *)recognizer {
    if (_delegate && [_delegate respondsToSelector:@selector(onSelectMessage:)]) {
        [_delegate onSelectMessage:self];
    }
}

- (void)onSelectMessageAvatar:(UIGestureRecognizer *)recognizer {
    if (_delegate && [_delegate respondsToSelector:@selector(onSelectMessageAvatar:)]) {
        [_delegate onSelectMessageAvatar:self];
    }
}

- (void)prepareForReuse {
    [super prepareForReuse];
    // 今后任何关于复用产生的 UI 问题，都可以在此尝试编码解决。
}

@end
