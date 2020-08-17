//
//  HHConversation.m
//  HHChatKit
//
//  Created by Henry on 2020/8/17.
//  Copyright © 2020 Henry. All rights reserved.
//

#import "HHConversation.h"

@implementation HHConversation

- (BOOL)isRead {
    return self.unreadCount <= 0;
}

- (NSString *)badgeValue {
    if (self.isRead) {
        return nil;
    }
    if (self.convType == HHConversationTypePersonal || self.convType == HHConversationTypeGroup) {
        return self.unreadCount <= 99 ? @(self.unreadCount).stringValue : @"99+";
    } else {
        return @"";
    }
}

@end
