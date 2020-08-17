//
//  HHKeyBoardMoreCell.m
//  YYT
//
//  Created by Henry on 2020/8/7.
//  Copyright © 2020 eastraycloud. All rights reserved.
//

#import "HHKeyBoardMoreCell.h"
#import "UIView+HHLayout.h"
#import "UIImage+HHKeyBoard.h"

@implementation HHKeyBoardMoreCell

+ (NSString *)cellId {
    return NSStringFromClass(self);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.contentView addSubview:self.iconButton];
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.iconButton.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.width);
    self.titleLabel.frame = CGRectMake(0, self.iconButton.frame.size.height+self.iconButton.frame.origin.y, self.contentView.frame.size.width, self.contentView.frame.size.height-self.iconButton.frame.size.height+self.iconButton.frame.origin.y);
    
}

- (void)setItem:(HHKeyBoardMoreItem *)item {
    _item = item;
    if (item == nil) {
        self.titleLabel.hidden = YES;
        self.iconButton.hidden = YES;
        self.userInteractionEnabled = NO;
        return;
    }
    self.userInteractionEnabled = YES;
    self.titleLabel.hidden = NO;
    self.iconButton.hidden = NO;
    self.titleLabel.text = item.title;
    [self.iconButton setImage:[UIImage imageNamed:item.imagePath] forState:UIControlStateNormal];
}

- (void)iconButtonDown:(UIButton *)sender {
    self.clickBlock(self.item);
}

- (UIButton *)iconButton {
    if (_iconButton == nil) {
        _iconButton = [[UIButton alloc] init];
        _iconButton.layer.masksToBounds = YES;
        _iconButton.layer.cornerRadius = 10;
        [_iconButton setBackgroundImage:[UIImage hh_imageWithColor:[UIColor lightGrayColor]] forState:UIControlStateHighlighted];
        [_iconButton addTarget:self action:@selector(iconButtonDown:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _iconButton;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end
