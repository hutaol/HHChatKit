//
//  HHKeyBoardMoreItem.h
//  YYT
//
//  Created by Henry on 2020/8/7.
//  Copyright © 2020 eastraycloud. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, HHKeyboardMoreItemType) {
    HHKeyboardMoreItemTypeNone,
    HHKeyboardMoreItemTypeImage,
    HHKeyboardMoreItemTypePhoto,
    HHKeyboardMoreItemTypeAudio,
    HHKeyboardMoreItemTypeOnlineMeeting,
    HHKeyboardMoreItemTypeOnlineMeetingTip,
    HHKeyboardMoreItemTypeNetworkCall,
    HHKeyboardMoreItemTypeDoubleLiveMeeting,
    HHKeyboardMoreItemTypeUseful,
    HHKeyboardMoreItemTypeVirtualDesktop,
    HHKeyboardMoreItemTypeImageSynchronization,
    HHKeyboardMoreItemTypeOnlineTrain,
    HHKeyboardMoreItemTypeOnlineLive,
    HHKeyboardMoreItemTypeInterfaceService,
};

@interface HHKeyBoardMoreItem : NSObject

@property (nonatomic, assign) HHKeyboardMoreItemType type;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *imagePath;

+ (instancetype)moreItemWithType:(HHKeyboardMoreItemType)type title:(NSString *)title imagePath:(NSString *)imagePath;

@end

NS_ASSUME_NONNULL_END
