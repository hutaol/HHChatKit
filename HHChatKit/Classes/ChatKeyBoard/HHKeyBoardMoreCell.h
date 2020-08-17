//
//  HHKeyBoardMoreCell.h
//  YYT
//
//  Created by Henry on 2020/8/7.
//  Copyright © 2020 eastraycloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHKeyBoardMoreItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface HHKeyBoardMoreCell : UICollectionViewCell

@property (nonatomic, strong) UIButton *iconButton;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong, nullable) HHKeyBoardMoreItem *item;

@property (nonatomic, strong) void(^clickBlock)(HHKeyBoardMoreItem *item);

+ (NSString *)cellId;

@end

NS_ASSUME_NONNULL_END
