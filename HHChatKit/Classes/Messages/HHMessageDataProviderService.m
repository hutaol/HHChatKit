//
//  HHMessageDataProviderService.m
//  HHChatKit
//
//  Created by Henry on 2020/8/13.
//  Copyright © 2020 Henry. All rights reserved.
//

#import "HHMessageDataProviderService.h"
#import "HHHelper.h"
#import "NSString+HHKeyBoard.h"
#import "PathTool.h"
#import "NSDate+HHChat.h"

@implementation HHMessageDataProviderService

+ (HHMessage *)getMessage:(HHMessageCellData *)cellData {
    if ([cellData isKindOfClass:[HHTextMessageCellData class]]) {
        HHTextMessageCellData *data = (HHTextMessageCellData *)cellData;
        HHMessage *message = [[HHMessage alloc] init];
        TIMTextElem *elem = [[TIMTextElem alloc] init];
        elem.text = data.content;
        [message addElem:elem];
        return message;
    } else if ([cellData isKindOfClass:[HHVoiceMessageCellData class]]) {
        HHVoiceMessageCellData *data = (HHVoiceMessageCellData *)cellData;
        HHMessage *message = [[HHMessage alloc] init];
        TIMSoundElem *elem = [[TIMSoundElem alloc] init];
        elem.path = data.path;
        elem.second = data.duration;
        elem.dataSize = data.length;
        [message addElem:elem];

        return message;
    } else if ([cellData isKindOfClass:[HHImageMessageCellData class]]) {
        HHImageMessageCellData *data = (HHImageMessageCellData *)cellData;
        HHMessage *message = [[HHMessage alloc] init];
        TIMImageElem *elem = [[TIMImageElem alloc] init];
//        elem.imageList
        [message addElem:elem];

        return message;
    }

    return nil;
}

+ (HHMessageCellData *)getMessageCellData:(NSString *)text {
    HHTextMessageCellData *data = [[HHTextMessageCellData alloc] initWithDirection:MsgDirectionOutgoing];
    data.content = text;
    [self addCommonData:data];
    return data;
}

+ (HHMessageCellData *)getMessageCellDataWithVoice:(NSDictionary *)voice {
    NSString *path = voice[@"path"];
    int duration = [voice[@"duration"] intValue];
    int length = (int)[[[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil] fileSize];
    
    NSString *name = [path lastPathComponent];
    NSString *toPath = [HHHelper pathUserChatVoice:name];
    [PathTool moveSourceFile:path toDesPath:toPath];
    
    HHVoiceMessageCellData *data = [[HHVoiceMessageCellData alloc] initWithDirection:MsgDirectionOutgoing];
    data.path = toPath;
    data.duration = duration;
    data.length = length;
//    uiVoice.url = voice[@"url"];
    
    [self addCommonData:data];
    
    return data;
}

+ (HHMessageCellData *)getMessageCellDataWithImage:(UIImage *)image {
    HHImageMessageCellData *data = [[HHImageMessageCellData alloc] initWithDirection:MsgDirectionOutgoing];
    data.thumbImage = image;
    
    NSData *imgData = UIImageJPEGRepresentation(image, 0.75);

    NSString *name = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
    name = [name md5];
    NSString *imagePath = [HHHelper pathUserChatImage:name];
    
    [[NSFileManager defaultManager] createFileAtPath:imagePath contents:imgData attributes:nil];
    
    data.path = imagePath;
    
    int length = (int)[[[NSFileManager defaultManager] attributesOfItemAtPath:imagePath error:nil] fileSize];

    data.length = length;
    
    [self addCommonData:data];
    
    return data;
}

// TODO
+ (void)addCommonData:(HHMessageCellData *)data {
    data.time = [NSDate timestamp:[NSDate new]];
    
    data.avatarUrl = [NSURL URLWithString:[HHHelper randAvatarUrl]];
    data.name = @"user";
    data.showName = NO;
    
}

+ (HHMessageCellData *)getMessageCellDataWithElem:(TIMElem *)elem message:(HHMessage *)message {
    HHMessageCellData *data = nil;

    if ([elem isKindOfClass:[TIMTextElem class]]) {

        TIMTextElem *textElem = (TIMTextElem *)elem;

        HHTextMessageCellData *textData = [[HHTextMessageCellData alloc] initWithDirection:(message.isSelf ? MsgDirectionOutgoing : MsgDirectionIncoming)];
        textData.content = textElem.text;
        data = textData;
        
    } else if ([elem isKindOfClass:[TIMImageElem class]]) {
        TIMImageElem *imageElem = (TIMImageElem *)elem;

        HHImageMessageCellData *imageData = [[HHImageMessageCellData alloc] initWithDirection:message.isSelf ? MsgDirectionOutgoing : MsgDirectionIncoming];
//        imageData.largeImage = imageElem
        
        data = imageData;

    } else if ([elem isKindOfClass:[TIMSoundElem class]]) {
        TIMSoundElem *soundElem = (TIMSoundElem *)elem;
        HHVoiceMessageCellData *soundData = [[HHVoiceMessageCellData alloc] initWithDirection:(message.isSelf ? MsgDirectionOutgoing : MsgDirectionIncoming)];
        soundData.duration = soundElem.second;
        soundData.length = soundElem.dataSize;
            
        data = soundData;

    } else if ([elem isKindOfClass:[TIMCustomElem class]]) {
//        data = [self getCustomCellData:message fromElem:(TIMCustomElem *)elem];
    }
    
    data.name = message.sender;
    data.time = message.timestamp;
    
    data.innerMessage = message;
    
    return data;
}

@end
