//
//  HHMessageDataProviderService.h
//  HHChatKit
//
//  Created by Henry on 2020/8/13.
//  Copyright © 2020 Henry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HHMessage.h"
#import "HHVoiceMessageCellData.h"
#import "HHTextMessageCellData.h"
#import "HHImageMessageCellData.h"

NS_ASSUME_NONNULL_BEGIN

@interface HHMessageDataProviderService : NSObject

+ (HHMessage *)getMessage:(HHMessageCellData *)msg;

+ (HHMessageCellData *)getMessageCellDataWithElem:(HHElem *)elem message:(HHMessage *)message;

+ (HHMessageCellData *)getMessageCellData:(NSString *)text;
+ (HHMessageCellData *)getMessageCellDataWithVoice:(NSDictionary *)voice;
+ (HHMessageCellData *)getMessageCellDataWithImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
