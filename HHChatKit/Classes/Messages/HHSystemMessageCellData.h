//
//  HHSystemMessageCellData.h
//  HHChatKit
//
//  Created by Henry on 2020/8/13.
//  Copyright © 2020 Henry. All rights reserved.
//

#import "HHMessageCellData.h"

NS_ASSUME_NONNULL_BEGIN

@interface HHSystemMessageCellData : HHMessageCellData

@property (nonatomic, strong) NSString *content;

@property (nonatomic, strong) NSString *dotime;

@property UIFont *contentFont;

@property UIColor *contentColor;

@end

NS_ASSUME_NONNULL_END
