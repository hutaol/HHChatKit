//
//  HHChatCallback.h
//  HHChatKit
//
//  Created by Henry on 2020/8/12.
//  Copyright © 2020 Henry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HHChatComm.h"

@protocol HHChatCallback <NSObject>

- (void)onSucc;

- (void)onErr:(int)errCode errMsg:(NSString *)errMsg;

@end
