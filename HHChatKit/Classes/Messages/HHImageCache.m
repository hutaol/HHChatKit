//
//  HHImageCache.m
//  HHChatKit
//
//  Created by Henry on 2020/8/13.
//  Copyright © 2020 Henry. All rights reserved.
//

#import "HHImageCache.h"
#import "HHHelper.h"

@interface HHImageCache ()

@property (nonatomic, strong) NSMutableDictionary *resourceCache;
@property (nonatomic, strong) NSMutableDictionary *faceCache;

@end

@implementation HHImageCache

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static HHImageCache *instance;
    dispatch_once(&onceToken, ^{
        instance = [[HHImageCache alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _resourceCache = [NSMutableDictionary dictionary];
        _faceCache = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)addResourceToCache:(NSString *)path {
    __weak typeof(self) ws = self;
    [HHHelper asyncDecodeImage:path complete:^(NSString *key, UIImage *image) {
        __strong __typeof(ws) strongSelf = ws;
        [strongSelf.resourceCache setValue:image forKey:key];
    }];
}

- (UIImage *)getResourceFromCache:(NSString *)path {
    if (path.length == 0) {
        return nil;
    }
    UIImage *image = [_resourceCache objectForKey:path];
    if (!image) {
        image = [UIImage imageWithContentsOfFile:path];
        if (!image) {
            image = [UIImage imageNamed:path];
        } else {
            [self addResourceToCache:path];
        }
    }
    return image;
}

- (UIImage *)getImageFromMessageCache:(NSString *)name {
    return [self getResourceFromCache:TResource(name)];
}

- (void)addFaceToCache:(NSString *)path {
    __weak typeof(self) ws = self;
    [HHHelper asyncDecodeImage:path complete:^(NSString *key, UIImage *image) {
        __strong __typeof(ws) strongSelf = ws;
        [strongSelf.faceCache setValue:image forKey:key];
    }];
}

- (UIImage *)getFaceFromCache:(NSString *)path {
    if (path.length == 0) {
        return nil;
    }
    UIImage *image = [_faceCache objectForKey:path];
    if (!image) {
        image = [UIImage imageWithContentsOfFile:path];
        if (!image) {
            image = [UIImage imageNamed:path];
        } else {
            [self addFaceToCache:path];
        }
    }
    return image;
}



@end
