//
//  HHMessage.m
//  HHChatKit
//
//  Created by Henry on 2020/8/12.
//  Copyright © 2020 Henry. All rights reserved.
//

#import "HHMessage.h"
#import <YYModel/YYModel.h>
#import "NSDate+HHChat.h"
#import "HHChatManager.h"

@implementation HHElem

@end

@implementation HHTextElem

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.type = NSStringFromClass([HHTextElem class]);
    }
    return self;
}

@end

@implementation HHImageElem

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.type = NSStringFromClass([HHImageElem class]);
    }
    return self;
}

@end

@implementation HHFileElem

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.type = NSStringFromClass([HHFileElem class]);
    }
    return self;
}

@end

@implementation HHSoundElem

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.type = NSStringFromClass([HHSoundElem class]);
    }
    return self;
}

@end

@implementation HHCustomElem

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.type = NSStringFromClass([HHCustomElem class]);
    }
    return self;
}

@end

@implementation HHFaceElem

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.type = NSStringFromClass([HHFaceElem class]);
    }
    return self;
}

@end

@interface HHMessage ()

@property (nonatomic, strong) NSMutableArray *elemArray;

@property (nonatomic, assign) BOOL readed;

@end

@implementation HHMessage

//+ (NSDictionary *)modelContainerPropertyGenericClass {
//    return @{@"elemArray" : [HHTextElem class]};
//}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSArray *arr = dic[@"elemArray"];
    NSMutableArray *mArr = [NSMutableArray array];
    for (NSDictionary *dict in arr) {
        NSString *type = dict[@"type"];
        if ([type isEqualToString:NSStringFromClass([HHTextElem class])]) {
            HHTextElem *elem = [HHTextElem yy_modelWithDictionary:dict];
            [mArr addObject:elem];
        } else if ([type isEqualToString:NSStringFromClass([HHImageElem class])]) {
            // TODO image
            HHImageElem *elem = [HHImageElem yy_modelWithDictionary:dict];
            [mArr addObject:elem];

        } else if ([type isEqualToString:NSStringFromClass([HHFileElem class])]) {
            HHFileElem *elem = [HHFileElem yy_modelWithDictionary:dict];
            [mArr addObject:elem];

        } else if ([type isEqualToString:NSStringFromClass([HHSoundElem class])]) {
            HHSoundElem *elem = [HHSoundElem yy_modelWithDictionary:dict];
            [mArr addObject:elem];

        } else if ([type isEqualToString:NSStringFromClass([HHCustomElem class])]) {
            HHCustomElem *elem = [HHCustomElem yy_modelWithDictionary:dict];
            [mArr addObject:elem];

        } else if ([type isEqualToString:NSStringFromClass([HHFaceElem class])]) {
            HHFaceElem *elem = [HHFaceElem yy_modelWithDictionary:dict];
            [mArr addObject:elem];
        }
    }

    _elemArray = mArr;
    
    return YES;
}

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

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.msgId = [NSDate timestamp:[NSDate new]];
        self.timestamp = [NSDate timestamp:[NSDate new]];
        self.status = HHMessageStatusSending;
        self.isReaded = NO;
        self.isSelf = YES;
        self.sender = [[HHChatManager shareManager] getLoginUser];
    }
    return self;
}

@end
