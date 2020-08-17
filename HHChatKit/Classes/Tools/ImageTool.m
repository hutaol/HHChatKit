//
//  ImageTool.m
//  HHChatKit
//
//  Created by Henry on 2020/8/14.
//  Copyright © 2020 Henry. All rights reserved.
//

#import "ImageTool.h"
#import <ZLPhotoBrowser/ZLPhotoBrowser.h>
#import <YBImageBrowser/YBImageBrowser.h>
#import "HHKeyBoardHeader.h"

@implementation ImageTool

+ (void)imagePickerWithController:(UIViewController *)vc allowCrop:(BOOL)allowCrop completion:(ImagePickerCompletion)completion {
    
    ZLPhotoActionSheet *ac = [[ZLPhotoActionSheet alloc] init];
    // 相册参数配置，configuration有默认值，可直接使用并对其属性进行修改
    //设置照片最大选择数
    ac.configuration.maxSelectCount = 1;
    //是否在选择图片后直接进入编辑界面
    ac.configuration.editAfterSelectThumbnailImage = allowCrop;
    //是否保存编辑后的图片
    ac.configuration.saveNewImageAfterEdit = NO;
    //设置相册内部显示拍照按钮
    ac.configuration.allowTakePhotoInLibrary = NO;
    //设置编辑比例
    ac.configuration.clipRatios = @[GetClipRatio(1, 1)];
    // 是否允许编辑图片
    ac.configuration.allowEditImage = allowCrop;

    ac.sender = vc;
    // 选择回调
    [ac setSelectImageBlock:^(NSArray<UIImage *> * _Nonnull images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
        //your codes
        completion([images firstObject]);
    }];
    // 调用相册
    [ac showPhotoLibrary];
    

}

+ (void)imagePickerMultipleWithController:(UIViewController *)vc count:(NSInteger)count completion:(ImagePickerMultipleCompletion)completion {
    ZLPhotoActionSheet *ac = [[ZLPhotoActionSheet alloc] init];
    // 相册参数配置，configuration有默认值，可直接使用并对其属性进行修改
    // 设置照片最大选择数
    ac.configuration.maxSelectCount = count;
    // 设置相册内部显示拍照按钮
    ac.configuration.allowTakePhotoInLibrary = NO;
    // 是否保存编辑后的图片
    ac.configuration.saveNewImageAfterEdit = NO;
    // 是否允许编辑图片
    ac.configuration.allowEditImage = NO;

    ac.sender = vc;
    // 选择回调
    [ac setSelectImageBlock:^(NSArray<UIImage *> * _Nonnull images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
        //your codes
        completion(images);
    }];
    // 调用相册
    [ac showPhotoLibrary];

}

+ (void)cameraWithController:(UIViewController *)vc completion:(ImagePickerCompletion)completion {
    // 直接调用相机
    ZLCustomCamera *camera = [[ZLCustomCamera alloc] init];
    camera.allowTakePhoto = YES;
    camera.allowRecordVideo = NO;
    
    camera.doneBlock = ^(UIImage *image, NSURL *videoUrl) {
        // 自己需要在这个地方进行图片或者视频的保存
        if (completion) {
            completion(image);
        }
    };

    [vc showDetailViewController:camera sender:nil];
}

+ (void)showImageWithController:(UIViewController *)vc source:(NSArray *)source index:(NSInteger)index {
    NSMutableArray *arrImages = [NSMutableArray array];
        
        for (int i = 0; i < source.count; i ++) {
            id obj = source[i];
            if ([obj isKindOfClass:[NSURL class]]) {
                YBIBImageData *data = [[YBIBImageData alloc] init];
                data.imageURL = obj;
    //            data.thumbURL =
                [arrImages addObject:data];
            } else if ([obj isKindOfClass:[NSString class]]) {
                YBIBImageData *data = [[YBIBImageData alloc] init];
                data.imageURL = [NSURL URLWithString:obj];
                [arrImages addObject:data];
            } else if ([obj isKindOfClass:[UIImage class]]) {
                YBIBImageData *data = [[YBIBImageData alloc] init];
                data.thumbImage = obj;
                [arrImages addObject:data];
            }
        }
        
        YBImageBrowser *browser = [[YBImageBrowser alloc] init];
        browser.dataSourceArray = arrImages;
        browser.currentPage = index;
        browser.supportedOrientations = kbIpad ? UIInterfaceOrientationMaskAll : UIInterfaceOrientationMaskPortrait;
        [browser show];
}

@end
