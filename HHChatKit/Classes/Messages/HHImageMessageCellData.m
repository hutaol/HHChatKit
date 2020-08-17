//
//  HHImageMessageCellData.m
//  HHChatKit
//
//  Created by Henry on 2020/8/13.
//  Copyright © 2020 Henry. All rights reserved.
//

#import "HHImageMessageCellData.h"
#import "HHKeyBoardHeader.h"

@implementation HHImageMessageCellData

- (CGSize)contentSize {
    
    CGSize size = CGSizeZero;
    BOOL isDir = NO;
    if (![self.path isEqualToString:@""] &&
       [[NSFileManager defaultManager] fileExistsAtPath:self.path isDirectory:&isDir]) {
        if (!isDir) {
            size = [UIImage imageWithContentsOfFile:self.path].size;
        }
    }
    
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        return size;
    }
    
    CGFloat heightMax = kbScreenWidth * 0.4;
    if (size.height > size.width) {
        size.width = size.width / size.height * heightMax;
        size.height = heightMax;
    } else {
        size.height = size.height / size.width * heightMax;
        size.width = heightMax;
    }
    return size;
}

@end
