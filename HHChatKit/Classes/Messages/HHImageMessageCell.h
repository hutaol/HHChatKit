//
//  HHImageMessageCell.h
//  HHChatKit
//
//  Created by Henry on 2020/8/13.
//  Copyright © 2020 Henry. All rights reserved.
//

#import "HHMessageCell.h"
#import "HHImageMessageCellData.h"

NS_ASSUME_NONNULL_BEGIN

@interface HHImageMessageCell : HHMessageCell

@property (nonatomic, strong) UIImageView *thumb;

@property (nonatomic, strong) UILabel *progress;

@property HHImageMessageCellData *imageData;

- (void)fillWithData:(HHImageMessageCellData *)data;

@end

NS_ASSUME_NONNULL_END
