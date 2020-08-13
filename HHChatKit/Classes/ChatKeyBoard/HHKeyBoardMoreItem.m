//
//  HHKeyBoardMoreItem.m
//  YYT
//
//  Created by Henry on 2020/8/7.
//  Copyright © 2020 eastraycloud. All rights reserved.
//

#import "HHKeyBoardMoreItem.h"

@implementation HHKeyBoardMoreItem

+ (instancetype)moreItemWithType:(HHKeyboardMoreItemType)type title:(NSString *)title imagePath:(NSString *)imagePath {
    HHKeyBoardMoreItem *item = [[HHKeyBoardMoreItem alloc] init];
    item.type = type;
    item.title = title;
    item.imagePath = imagePath;
    return item;
}

@end
