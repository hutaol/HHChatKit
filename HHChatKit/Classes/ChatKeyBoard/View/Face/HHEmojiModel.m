//
//  HHEmojiModel.m
//  YYT
//
//  Created by Henry on 2020/8/7.
//  Copyright © 2020 eastraycloud. All rights reserved.
//

#import "HHEmojiModel.h"

@implementation HHEmojiModel

@end

@implementation HHFaceModel

@end

@implementation HHGroupEmojiModel

+ (instancetype)initEmojiWithPlist:(NSString *)plist image:(NSString *)image {
    NSString *path = [NSBundle.mainBundle pathForResource:plist ofType:nil];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray<HHEmojiModel *> *temArr = [NSMutableArray array];
    
    //读取plist里面的文字表情
    for (NSString *title in array) {
        HHEmojiModel *model = [[HHEmojiModel alloc] init];
        model.title = title;
        [temArr addObject:model];
    }
    
    NSInteger singlePage = 3 * 7 - 1;
    NSInteger page = ceil(array.count / (CGFloat)singlePage);
    
    //将不够最后一页的地方补上空模型对象，为了让删除按钮在最后
    for (int i = 0; i < page * singlePage - array.count; i++) {
        HHEmojiModel *model = [[HHEmojiModel alloc] init];
        [temArr addObject:model];
    }
    
    //将删除按钮已插入的形式放入数组
    for (int i = 0; i < page; i++) {
        HHEmojiModel *model = [[HHEmojiModel alloc] init];
        model.image = @"icon_emoji_delete";
        [temArr insertObject:model atIndex:(i+1) * singlePage + i];
    }
    
    HHGroupEmojiModel *groupModel = [[HHGroupEmojiModel alloc] init];
    groupModel.groupImage = image;
    groupModel.emojis = temArr;
    groupModel.type = HHEmojiTypeSmall;
    groupModel.totalPages = page;
    
    return groupModel;
}

+ (instancetype)initEmojiWithPlist:(NSString *)plist fileName:(NSString *)fileName image:(NSString *)image {
    
    NSString *path = [NSBundle.mainBundle pathForResource:plist ofType:nil];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray<HHEmojiModel *> *tempArr = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        HHEmojiModel *model = [[HHEmojiModel alloc] init];
        model.image = [NSString stringWithFormat:@"%@%d.png", fileName, i+1];
        model.title = array[i][@"name"];
        
        [tempArr addObject:model];
    }
    
    NSInteger singlePage = 3 * 7 - 1;
    NSInteger page = ceil(tempArr.count / (CGFloat)singlePage);
    
    //将不够最后一页的地方补上空模型（无title&image）对象，为了让删除按钮在最后
    for (int i = 0; i < page * singlePage - array.count; i++) {
        HHEmojiModel *model = [[HHEmojiModel alloc] init];
        [tempArr addObject:model];
    }
    
    //将删除按钮已插入的形式放入数组
    for (int i = 0; i < page; i++) {
        HHEmojiModel *model = [[HHEmojiModel alloc] init];
        model.image = @"icon_emoji_delete";
        model.title = @"delete";
        [tempArr insertObject:model atIndex:(i+1) * singlePage + i];
    }
    
    HHGroupEmojiModel *groupModel = [[HHGroupEmojiModel alloc] init];
    groupModel.emojis = tempArr;
    groupModel.groupImage = image;
    groupModel.type = HHEmojiTypeSmall;
    groupModel.totalPages = page;
    
    return groupModel;
}


+ (instancetype)initFaceWithFileName:(nullable NSString *)name count:(NSInteger)count image:(NSString *)image {
    
    NSMutableArray<HHFaceModel *> *tempArr = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        HHFaceModel *model = [[HHFaceModel alloc] init];
        if (!name) {
            model.image = [NSString stringWithFormat:@"%03d.png", i];
        }else {
            model.image = [NSString stringWithFormat:@"%@%d.jpg", name, i];
        }
        
        [tempArr addObject:model];
    }
    
    HHGroupEmojiModel *groupModel = [[HHGroupEmojiModel alloc] init];
    groupModel.faces = tempArr;
    groupModel.groupImage = image;
    groupModel.type = HHEmojiTypeBig;
    groupModel.totalPages = ceil(count / (CGFloat)(2 * 4));
    
    return groupModel;
}

@end
