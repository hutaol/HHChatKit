//
//  HHConversationCell.h
//  HHChatKit
//
//  Created by Henry on 2020/8/17.
//  Copyright © 2020 Henry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHConversation.h"

#define     HEIGHT_CONVERSATION_CELL        70.0f

NS_ASSUME_NONNULL_BEGIN

@interface HHConversationCell : UITableViewCell

@property (nonatomic, strong) HHConversation *conversation;

+ (NSString *)cellId;
+ (CGFloat)viewHeight;

@end

NS_ASSUME_NONNULL_END
