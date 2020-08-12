//
//  HHKeyBoardHeader.h
//  HHChatKit
//
//  Created by Henry on 2020/8/12.
//  Copyright © 2020 Henry. All rights reserved.
//

#ifndef HHKeyBoardHeader_h
#define HHKeyBoardHeader_h

#define kbIpad             (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define kbPortrait UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)

// 主窗口的宽、高
#define kbScreenWidth [UIScreen mainScreen].bounds.size.width
#define kbScreenHeight [UIScreen mainScreen].bounds.size.height


#define kbHeightStatusBar [[UIApplication sharedApplication] statusBarFrame].size.height
#define kbHeightNav (kbIpad ? 50.0 : 44.0)
#define kbHeightNavBar (kbHeightStatusBar + kbHeightNav)

#define kbHeightSafeBottom ([[UIApplication sharedApplication] statusBarFrame].size.height>20?34:0)
#define kbHeightTabBar (kbHeightSafeBottom + 49)


#define kbGetImage(image, imgName, bundleName, secondBName){\
NSString * path = [[NSBundle mainBundle] pathForResource:bundleName ofType:@"bundle"];\
NSString *secondP = [path stringByAppendingPathComponent:secondBName];\
NSString *imgNameFile = [secondP stringByAppendingPathComponent:imgName];\
image = [UIImage imageWithContentsOfFile:imgNameFile];\
}\

#endif /* HHKeyBoardHeader_h */
