//
//  HHKeyBoardMoreItem.h
//  YYT
//
//  Created by Henry on 2020/8/7.
//  Copyright © 2020 eastraycloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, HHKeyboardMoreItemType) {
    HHKeyboardMoreItemTypeNone  = 0,
    HHKeyboardMoreItemTypePhoto = 1,
    HHKeyboardMoreItemTypeCamera = 2,
    HHKeyboardMoreItemTypeAudio = 3,
    HHKeyboardMoreItemTypeOnlineMeeting = 4,
    HHKeyboardMoreItemTypeOnlineMeetingTip = 5,
    HHKeyboardMoreItemTypeNetworkCall = 6,
    HHKeyboardMoreItemTypeDoubleLiveMeeting = 7,
    HHKeyboardMoreItemTypeUseful = 8,
    HHKeyboardMoreItemTypeVirtualDesktop = 9,
    HHKeyboardMoreItemTypeImageSynchronization = 10,
    HHKeyboardMoreItemTypeOnlineTrain = 11,
    HHKeyboardMoreItemTypeOnlineLive = 12,
    HHKeyboardMoreItemTypeInterfaceService = 13,
};

@interface HHKeyBoardMoreItem : NSObject

@property (nonatomic, assign) HHKeyboardMoreItemType type;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIImage *image;

+ (instancetype)moreItemWithType:(HHKeyboardMoreItemType)type title:(NSString *)title image:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
