//
//  HHConversationManager.h
//  HHChatKit
//
//  Created by Henry on 2020/8/17.
//  Copyright © 2020 Henry. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHConversationManager : NSObject

@property (nonatomic, strong, nullable) NSMutableArray *convDatas;

+ (instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
