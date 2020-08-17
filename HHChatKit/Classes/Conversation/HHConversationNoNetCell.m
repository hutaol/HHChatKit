//
//  HHConversationNoNetCell.m
//  HHChatKit
//
//  Created by Henry on 2020/8/17.
//  Copyright © 2020 Henry. All rights reserved.
//

#import "HHConversationNoNetCell.h"
#import "UIColor+HHKeyBoard.h"
#import "UIView+HHLayout.h"
#import "HHImageCache.h"

@interface HHConversationNoNetCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *iconView;

@end

@implementation HHConversationNoNetCell

+ (NSString *)cellId {
    return NSStringFromClass(self);
}

+ (CGFloat)viewHeight {
    return 44.f;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self p_initViews];
        self.contentView.backgroundColor = [UIColor hh_colorWithString:@"#FFDFE0"];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    return self;
}

- (void)p_initViews {
    _iconView = [[UIImageView alloc] init];
    _iconView.image = [[HHImageCache sharedInstance] getImageFromMessageCache:@"msg_error"];

    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"当前网络不可用，请检查你的网络设置";
    _titleLabel.textColor = [UIColor grayColor];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    
    [self.contentView addSubview:_iconView];
    [self.contentView addSubview:_titleLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.iconView.mm_left(20).mm_width(20).mm_height(20).mm__centerY(self.contentView.mm_centerY);
    self.titleLabel.mm_sizeToFit().mm_left(self.iconView.mm_maxX+20).mm_flexToRight(10).mm__centerY(self.contentView.mm_centerY);
}

@end
