//
//  HHConversationSearchResultController.h
//  HHChatKit
//
//  Created by Henry on 2020/8/17.
//  Copyright © 2020 Henry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHSearchResultControllerProtocol.h"
#import "HHConversation.h"

NS_ASSUME_NONNULL_BEGIN

@interface HHConversationSearchResultController : UITableViewController <HHSearchResultControllerProtocol>

@property (nonatomic, copy) void (^itemSelectedAction)(HHConversationSearchResultController *searchVC, HHConversation *conv);

@end

NS_ASSUME_NONNULL_END
