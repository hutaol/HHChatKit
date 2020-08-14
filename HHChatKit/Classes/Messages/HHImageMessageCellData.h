//
//  HHImageMessageCellData.h
//  HHChatKit
//
//  Created by Henry on 2020/8/13.
//  Copyright © 2020 Henry. All rights reserved.
//

#import "HHMessageCellData.h"

NS_ASSUME_NONNULL_BEGIN

@interface HHImageMessageCellData : HHMessageCellData

/// 图像缩略图
@property (nonatomic, strong) UIImage *thumbImage;

/// 图像大图
@property (nonatomic, strong) UIImage *largeImage;

/// 图像原图
@property (nonatomic, strong) UIImage *originImage;

@end

NS_ASSUME_NONNULL_END
