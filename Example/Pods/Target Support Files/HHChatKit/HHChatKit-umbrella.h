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

#import "HHAudioRecorder.h"
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
#import "HHVoiceAnimationView.h"
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
#import "HHMessage.h"
#import "HHSocketManager.h"
#import "lame.h"
#import "HHBubbleMessageCell.h"
#import "HHBubbleMessageCellData.h"
#import "HHCommonTableViewCell.h"
#import "HHHeader.h"
#import "HHHelper.h"
#import "HHImageCache.h"
#import "HHImageMessageCell.h"
#import "HHImageMessageCellData.h"
#import "HHMessageCell.h"
#import "HHMessageCellData.h"
#import "HHMessageCellLayout.h"
#import "HHMessageDataProviderService.h"
#import "HHMessagesViewController.h"
#import "HHSystemMessageCell.h"
#import "HHSystemMessageCellData.h"
#import "HHTextMessageCell.h"
#import "HHTextMessageCellData.h"
#import "HHVoiceMessageCell.h"
#import "HHVoiceMessageCellData.h"
#import "NSDate+HHChat.h"
#import "NSString+HHChat.h"
#import "UIImageView+HHChat.h"
#import "UIView+HHLayout.h"
#import "ImageTool.h"
#import "LameTool.h"
#import "PathTool.h"
#import "ToastTool.h"

FOUNDATION_EXPORT double HHChatKitVersionNumber;
FOUNDATION_EXPORT const unsigned char HHChatKitVersionString[];

