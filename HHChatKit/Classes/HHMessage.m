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

@implementation TIMElem

@end

@implementation TIMTextElem

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.type = NSStringFromClass([TIMTextElem class]);
    }
    return self;
}

@end

@implementation TIMImageElem

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.type = NSStringFromClass([TIMImageElem class]);
    }
    return self;
}

@end

@implementation TIMFileElem

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.type = NSStringFromClass([TIMFileElem class]);
    }
    return self;
}

@end

@implementation TIMSoundElem

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.type = NSStringFromClass([TIMSoundElem class]);
    }
    return self;
}

@end

@implementation TIMCustomElem

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.type = NSStringFromClass([TIMCustomElem class]);
    }
    return self;
}

@end

@implementation TIMFaceElem

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.type = NSStringFromClass([TIMFaceElem class]);
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
//    return @{@"elemArray" : [TIMTextElem class]};
//}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSArray *arr = dic[@"elemArray"];
    NSMutableArray *mArr = [NSMutableArray array];
    for (NSDictionary *dict in arr) {
        NSString *type = dict[@"type"];
        if ([type isEqualToString:NSStringFromClass([TIMTextElem class])]) {
            TIMTextElem *elem = [TIMTextElem yy_modelWithDictionary:dict];
            [mArr addObject:elem];
        } else if ([type isEqualToString:NSStringFromClass([TIMImageElem class])]) {
            // TODO image
            TIMImageElem *elem = [TIMImageElem yy_modelWithDictionary:dict];
            [mArr addObject:elem];

        } else if ([type isEqualToString:NSStringFromClass([TIMFileElem class])]) {
            TIMFileElem *elem = [TIMFileElem yy_modelWithDictionary:dict];
            [mArr addObject:elem];

        } else if ([type isEqualToString:NSStringFromClass([TIMSoundElem class])]) {
            TIMSoundElem *elem = [TIMSoundElem yy_modelWithDictionary:dict];
            [mArr addObject:elem];

        } else if ([type isEqualToString:NSStringFromClass([TIMCustomElem class])]) {
            TIMCustomElem *elem = [TIMCustomElem yy_modelWithDictionary:dict];
            [mArr addObject:elem];

        } else if ([type isEqualToString:NSStringFromClass([TIMFaceElem class])]) {
            TIMFaceElem *elem = [TIMFaceElem yy_modelWithDictionary:dict];
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

- (int)addElem:(TIMElem *)elem {
    [self.elemArray addObject:elem];
    return 0;
}

- (TIMElem *)getElem:(int)index {
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
