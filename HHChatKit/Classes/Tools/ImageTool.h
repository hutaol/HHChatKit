//
//  ImageTool.h
//  HHChatKit
//
//  Created by Henry on 2020/8/14.
//  Copyright © 2020 Henry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ImagePickerCompletion)(UIImage *image);
typedef void (^ImagePickerMultipleCompletion)(NSArray <UIImage *> *images);

@interface ImageTool : NSObject

+ (void)imagePickerWithController:(UIViewController *)vc allowCrop:(BOOL)allowCrop completion:(ImagePickerCompletion)completion;

+ (void)imagePickerMultipleWithController:(UIViewController *)vc count:(NSInteger)count completion:(ImagePickerMultipleCompletion)completion;

+ (void)cameraWithController:(UIViewController *)vc completion:(ImagePickerCompletion)completion;

+ (void)showImageWithController:(UIViewController *)vc source:(NSArray *)source index:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
