#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "HHBaseKeyboard.h"
#import "HHEmojiModel.h"
#import "HHKeyboardDelegate.h"
#import "HHKeyBoardFaceView.h"
#import "HHKeyBoardHeader.h"
#import "HHKeyBoardMoreCell.h"
#import "HHKeyBoardMoreFlowLayout.h"
#import "HHKeyBoardMoreItem.h"
#import "HHKeyBoardMoreView.h"
#import "HHKeyboardProtocol.h"
#import "HHKeyBoardTextView.h"
#import "HHKeyBoardView.h"
#import "NSString+HHKeyBoard.h"
#import "UIButton+HHKeyBoard.h"
#import "UIColor+HHKeyBoard.h"
#import "UIImage+HHKeyBoard.h"
#import "UIScrollView+HHKeyBoard.h"
#import "UIView+HHKeyBoard.h"
#import "HHChatCallback.h"
#import "HHChatComm.h"
#import "HHChatManager.h"
#import "HHChatMessage.h"
#import "HHCodingModel.h"
#import "HHSocketManager.h"

FOUNDATION_EXPORT double HHChatKitVersionNumber;
FOUNDATION_EXPORT const unsigned char HHChatKitVersionString[];

