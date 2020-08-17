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

#import "NSDate+HHChat.h"
#import "NSString+HHChat.h"
#import "NSString+HHKeyBoard.h"
#import "UIButton+HHKeyBoard.h"
#import "UIColor+HHKeyBoard.h"
#import "UIImage+HHKeyBoard.h"
#import "UIImageView+HHChat.h"
#import "UIScrollView+HHKeyBoard.h"
#import "UIView+HHLayout.h"
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
#import "HHBadge.h"
#import "HHConversation.h"
#import "HHConversationCell.h"
#import "HHConversationManager.h"
#import "HHConversationNoNetCell.h"
#import "HHConversationSearchResultController.h"
#import "HHConversationViewController.h"
#import "HHChatCallback.h"
#import "HHChatComm.h"
#import "HHChatManager.h"
#import "HHCodingModel.h"
#import "HHHeader.h"
#import "HHHelper.h"
#import "HHMessage.h"
#import "HHSocketManager.h"
#import "lame.h"
#import "HHBubbleMessageCell.h"
#import "HHBubbleMessageCellData.h"
#import "HHCommonTableViewCell.h"
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
#import "HHSearchController.h"
#import "HHSearchResultControllerProtocol.h"
#import "HHAudioPlayer.h"
#import "HHAudioRecorder.h"
#import "ImageTool.h"
#import "LameTool.h"
#import "PathTool.h"
#import "ToastTool.h"

FOUNDATION_EXPORT double HHChatKitVersionNumber;
FOUNDATION_EXPORT const unsigned char HHChatKitVersionString[];

