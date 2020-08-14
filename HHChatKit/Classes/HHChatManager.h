//
//  HHChatManager.h
//  HHChatKit
//
//  Created by Henry on 2020/8/12.
//  Copyright © 2020 Henry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HHChatCallback.h"
#import "HHMessage.h"

NS_ASSUME_NONNULL_BEGIN

@interface HHChatManager : NSObject

@property (nonatomic, strong) id<HHMessageListener> messageListener;

+ (instancetype)shareManager;

- (void)initKit:(NSString *)url;

- (int)sendMessage:(HHMessage *)msg cb:(id<HHChatCallback>)cb;

@end

NS_ASSUME_NONNULL_END
