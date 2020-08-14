//
//  HHMessageDataProviderService.m
//  HHChatKit
//
//  Created by Henry on 2020/8/13.
//  Copyright © 2020 Henry. All rights reserved.
//

#import "HHMessageDataProviderService.h"
#import "HHHelper.h"

@implementation HHMessageDataProviderService

+ (HHMessage *)getMessage:(HHMessageCellData *)cellData {
    if ([cellData isKindOfClass:[HHTextMessageCellData class]]) {
        HHTextMessageCellData *data = (HHTextMessageCellData *)cellData;
        HHMessage *message = [[HHMessage alloc] init];
        HHTextElem *elem = [[HHTextElem alloc] init];
        elem.text = data.content;
        [message addElem:elem];
        return message;
    } else if ([cellData isKindOfClass:[HHVoiceMessageCellData class]]) {
        HHVoiceMessageCellData *data = (HHVoiceMessageCellData *)cellData;
        HHMessage *message = [[HHMessage alloc] init];
        HHSoundElem *elem = [[HHSoundElem alloc] init];
        elem.path = data.path;
        elem.second = data.duration;
        elem.dataSize = data.length;
        [message addElem:elem];

        return message;
    } else if ([cellData isKindOfClass:[HHImageMessageCellData class]]) {
        HHImageMessageCellData *data = (HHImageMessageCellData *)cellData;
        HHMessage *message = [[HHMessage alloc] init];
        HHImageElem *elem = [[HHImageElem alloc] init];
//        elem.imageList
        [message addElem:elem];

        return message;
    }

    return nil;
}

+ (HHMessageCellData *)getMessageCellData:(NSString *)text {
    HHTextMessageCellData *data = [[HHTextMessageCellData alloc] initWithDirection:MsgDirectionOutgoing];
    data.content = text;
    data.avatarUrl = [NSURL URLWithString:[HHHelper randAvatarUrl]];
    
    return data;
}

+ (HHMessageCellData *)getMessageCellDataWithVoice:(NSDictionary *)voice {
    NSString *path = voice[@"path"];
    int duration = [voice[@"duration"] intValue];
    int length = (int)[[[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil] fileSize];
    
    HHVoiceMessageCellData *data = [[HHVoiceMessageCellData alloc] initWithDirection:MsgDirectionOutgoing];
    data.path = path;
    data.duration = duration;
    data.length = length;
//    uiVoice.url = voice[@"url"];
    data.avatarUrl = [NSURL URLWithString:[HHHelper randAvatarUrl]];

    return data;
}

+ (HHMessageCellData *)getMessageCellDataWithElem:(HHElem *)elem message:(HHMessage *)message {
    HHMessageCellData *data = nil;

    if ([elem isKindOfClass:[HHTextElem class]]) {

        HHTextElem *textElem = (HHTextElem *)elem;

        HHTextMessageCellData *textData = [[HHTextMessageCellData alloc] initWithDirection:(message.isSelf ? MsgDirectionOutgoing : MsgDirectionIncoming)];
        textData.content = textElem.text;
        data = textData;
        
    } else if ([elem isKindOfClass:[HHImageElem class]]) {
//        data = [self getImageCellData:message formElem:(TIMImageElem *)elem];
    } else if ([elem isKindOfClass:[HHSoundElem class]]) {
        HHSoundElem *soundElem = (HHSoundElem *)elem;
        HHVoiceMessageCellData *soundData = [[HHVoiceMessageCellData alloc] initWithDirection:(message.isSelf ? MsgDirectionOutgoing : MsgDirectionIncoming)];
        soundData.duration = soundElem.second;
        soundData.length = soundElem.dataSize;
            
        data = soundData;

    } else if ([elem isKindOfClass:[HHCustomElem class]]) {
//        data = [self getCustomCellData:message fromElem:(TIMCustomElem *)elem];
    }
    
    data.innerMessage = message;
    
    return data;
}

@end
