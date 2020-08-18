//
//  HHHeader.h
//  HHChatKit
//
//  Created by Henry on 2020/8/13.
//  Copyright © 2020 Henry. All rights reserved.
//

#ifndef HHHeader_h
#define HHHeader_h

#ifndef weakify
    #if DEBUG
        #if __has_feature(objc_arc)
            #define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
        #else
            #define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
        #endif
    #else
        #if __has_feature(objc_arc)
            #define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
        #else
            #define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
        #endif
    #endif
#endif

#ifndef strongify
    #if DEBUG
        #if __has_feature(objc_arc)
            #define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
        #else
            #define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
        #endif
    #else
        #if __has_feature(objc_arc)
            #define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
        #else
            #define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
        #endif
    #endif
#endif

#define TMessageController_Header_Height 40

static NSString *TextMessageCell_ReuseId = @"TextMessageCell_ReuseId";
static NSString *ImageMessageCell_ReuseId = @"ImageMessageCell_ReuseId";
static NSString *VoiceMessageCell_ReuseId = @"VoiceMessageCell_ReuseId";
static NSString *CustomMessageCell_ReuseId = @"CustomMessageCell_ReuseId";
static NSString *SystemMessageCell_ReuseId = @"SystemMessageCell_ReuseId";

#endif /* HHHeader_h */
