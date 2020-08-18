//
//  HHKeyBoardMoreItem.m
//  YYT
//
//  Created by Henry on 2020/8/7.
//  Copyright © 2020 eastraycloud. All rights reserved.
//

#import "HHKeyBoardMoreItem.h"

@implementation HHKeyBoardMoreItem

+ (instancetype)moreItemWithType:(HHKeyboardMoreItemType)type title:(NSString *)title image:(UIImage *)image {
    HHKeyBoardMoreItem *item = [[HHKeyBoardMoreItem alloc] init];
    item.type = type;
    item.title = title;
    item.image = image;
    return item;
}

@end
