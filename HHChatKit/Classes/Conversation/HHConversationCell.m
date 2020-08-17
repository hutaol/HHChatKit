//
//  HHConversationCell.m
//  HHChatKit
//
//  Created by Henry on 2020/8/17.
//  Copyright © 2020 Henry. All rights reserved.
//

#import "HHConversationCell.h"
#import "HHBadge.h"
#import "UIImageView+HHChat.h"
#import "UIView+HHLayout.h"
#import <SDWebImage/SDWebImage.h>
#import "HHImageCache.h"
#import "NSDate+HHChat.h"
#import "UIImageView+HHChat.h"
#import "UIColor+HHKeyBoard.h"

@interface HHConversationCell ()

/// 头像
@property (nonatomic, strong) UIImageView *avatarView;

/// 用户名
@property (nonatomic, strong) UILabel *nameLabel;

/// 正文
@property (nonatomic, strong) UILabel *detailLabel;

/// 时间
@property (nonatomic, strong) UILabel *timeLabel;

/// 气泡
@property (nonatomic, strong) HHBadge *badge;

@property (nonatomic, strong) UILabel *headStateLabel;

@end

@implementation HHConversationCell

+ (NSString *)cellId {
    return NSStringFromClass(self);
}

+ (CGFloat)viewHeight {
    return HEIGHT_CONVERSATION_CELL;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.badge.backgroundColor = [UIColor redColor];
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    self.badge.backgroundColor = [UIColor redColor];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self p_initViews];
        
        self.separatorInset = UIEdgeInsetsMake(0, 12, 0, 0);
//        self.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    return self;
}

- (void)p_initViews {
    _avatarView = [[UIImageView alloc] init];
    _avatarView.backgroundColor = [UIColor grayColor];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont systemFontOfSize:16];
    _nameLabel.textColor = [UIColor blackColor];

    _detailLabel = [[UILabel alloc] init];
    _detailLabel.font = [UIFont systemFontOfSize:14];
    _detailLabel.textColor = [UIColor lightGrayColor];

    _timeLabel = [[UILabel alloc] init];
    _timeLabel.font = [UIFont systemFontOfSize:12];
    _timeLabel.textColor = [UIColor lightGrayColor];

    _badge = [[HHBadge alloc] init];
    
    _headStateLabel = [[UILabel alloc] init];
    _headStateLabel.font = [UIFont systemFontOfSize:10];
    _headStateLabel.textColor = [UIColor whiteColor];
    _headStateLabel.backgroundColor = [UIColor hh_colorWithString:@"#81a0b4"];
    _headStateLabel.textAlignment = NSTextAlignmentCenter;
    _headStateLabel.adjustsFontSizeToFitWidth = YES;
    _headStateLabel.text = @"医医";

    [self.contentView addSubview:_avatarView];
    [self.contentView addSubview:_nameLabel];
    [self.contentView addSubview:_detailLabel];
    [self.contentView addSubview:_timeLabel];
    [self.contentView addSubview:_badge];
    [_avatarView addSubview:_headStateLabel];

}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat height = [HHConversationCell viewHeight];
    self.mm_h = height;
    CGFloat imgHeight = height-2*(10);

    self.avatarView.mm_width(imgHeight).mm_height(imgHeight).mm_left(10 + 4).mm_top(10);

    self.timeLabel.mm_sizeToFit().mm_top(14).mm_right(10 + 4);
    self.nameLabel.mm_sizeToFitThan(120, 30).mm_top(10-2).mm_left(self.avatarView.mm_maxX+10).mm_flexToRight(self.timeLabel.mm_w+self.timeLabel.mm_r);
    
    self.badge.mm_right(10 + 4).mm_bottom(12);
    self.detailLabel.mm_sizeToFit().mm_left(self.nameLabel.mm_x).mm_bottom(10+2).mm_flexToRight(self.mm_w-self.badge.mm_x);
    
    self.headStateLabel.mm_sizeToFit().mm_bottom(3).mm_flexToRight(0).mm_height(15);
    
    [self.avatarView hh_setRoundedCorners:imgHeight/2];
    
}

- (void)setConversation:(HHConversation *)conversation {
    _conversation = conversation;
    
    if (conversation.avatarPath.length > 0) {
//        NSString *path = [NSFileManager pathUserAvatar:conversation.avatarPath];
//        [self.avatarView setImage:[UIImage imageNamed:path]];
    } else {
        [self.avatarView sd_setImageWithURL:[NSURL URLWithString:conversation.avatarURL] placeholderImage:[[HHImageCache sharedInstance] getImageFromMessageCache:@"default_head"]];
    }
    
    self.nameLabel.text = conversation.partnerName;
    self.detailLabel.text = conversation.content;
    self.timeLabel.text = [conversation.date shortTimeMessageString];
    
    [self updateBadge];

}

- (void)updateBadge {
    CGSize size = [HHBadge badgeSizeWithValue:self.conversation.badgeValue];
    self.badge.badgeValue = self.conversation.badgeValue;
    
    self.badge.mm_width(size.width).mm_height(size.height);
}

@end
