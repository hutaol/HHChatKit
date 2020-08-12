//
//  HHChatMessage.m
//  HHChatKit
//
//  Created by Henry on 2020/8/12.
//  Copyright © 2020 Henry. All rights reserved.
//

#import "HHChatMessage.h"

@implementation HHElem

@end

@implementation HHTextElem

@end

@implementation HHImageElem

@end

@implementation HHFileElem

@end

@implementation HHSoundElem

@end

@implementation HHCustomElem

@end

@implementation HHFaceElem

@end

@interface HHChatMessage ()

@property (nonatomic, strong) NSMutableArray *elemArray;

@property (nonatomic, assign) BOOL readed;

@end

@implementation HHChatMessage

- (NSMutableArray *)elemArray {
    if (!_elemArray) {
        _elemArray = [NSMutableArray array];
    }
    return _elemArray;
}

- (int)addElem:(HHElem *)elem {
    [self.elemArray addObject:elem];
    return 0;
}

- (HHElem *)getElem:(int)index {
    if (self.elemArray.count > index) {
        return [self.elemArray objectAtIndex:index];
    }
    return nil;
}

- (int)elemCount {
    return (int)self.elemArray.count;
}

- (BOOL)isReaded {
    return self.readed;
}

- (HHMessageStatus)status {
    return 0;
}

- (BOOL)isSelf {
    return NO;
}

- (NSString *)sender {
    return @"";
}

- (BOOL)remove {
    return NO;
}

- (NSString *)msgId {
    return @"";
}

- (NSDate *)timestamp {
    return [NSDate new];
}

@end
