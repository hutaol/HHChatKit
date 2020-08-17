//
//  HHConversationManager.m
//  HHChatKit
//
//  Created by Henry on 2020/8/17.
//  Copyright © 2020 Henry. All rights reserved.
//

#import "HHConversationManager.h"

@implementation HHConversationManager

static HHConversationManager *_sharedInstance = nil;
static dispatch_once_t onceToken = 0;

+ (instancetype)sharedInstance {
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

@end
