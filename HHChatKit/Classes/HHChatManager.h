//
//  HHChatManager.h
//  HHChatKit
//
//  Created by Henry on 2020/8/12.
//  Copyright © 2020 Henry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HHChatCallback.h"
#import "HHChatMessage.h"

NS_ASSUME_NONNULL_BEGIN

@interface HHChatManager : NSObject

+ (instancetype)shareManager;

- (void)initKit:(NSString *)url;

- (int)sendMessage:(HHChatMessage *)msg cb:(id<HHChatCallback>)cb;

@end

NS_ASSUME_NONNULL_END
