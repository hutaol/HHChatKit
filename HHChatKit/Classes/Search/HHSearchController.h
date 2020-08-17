//
//  HHSearchController.h
//  HHChatKit
//
//  Created by Henry on 2020/8/17.
//  Copyright © 2020 Henry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHSearchResultControllerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface HHSearchController : UISearchController

+ (HHSearchController *)createWithResultsContrller:(UIViewController<HHSearchResultControllerProtocol> *)resultVC;

@end

NS_ASSUME_NONNULL_END
