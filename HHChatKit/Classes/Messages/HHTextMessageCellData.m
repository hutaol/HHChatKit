//
//  HHTextMessageCellData.m
//  HHChatKit
//
//  Created by Henry on 2020/8/13.
//  Copyright © 2020 Henry. All rights reserved.
//

#import "HHTextMessageCellData.h"
#import "HHKeyBoardHeader.h"
#import "NSString+HHKeyBoard.h"


#ifndef CGFLOAT_CEIL
#ifdef CGFLOAT_IS_DOUBLE
#define CGFLOAT_CEIL(value) ceil(value)
#else
#define CGFLOAT_CEIL(value) ceilf(value)
#endif
#endif

@interface HHTextMessageCellData ()

@property CGSize textSize;
@property CGPoint textOrigin;

@end

@implementation HHTextMessageCellData

- (instancetype)initWithDirection:(HHMsgDirection)direction {
    self = [super initWithDirection:direction];
    if (self) {
        if (direction == MsgDirectionIncoming) {
            _textColor = [[self class] incommingTextColor];
            _textFont = [[self class] incommingTextFont];
            self.cellLayout = [HHMessageCellLayout incommingTextMessageLayout];
        } else {
            _textColor = [[self class] outgoingTextColor];
            _textFont = [[self class] outgoingTextFont];
            self.cellLayout = [HHMessageCellLayout outgoingTextMessageLayout];
        }
    }
    return self;
}

- (CGSize)contentSize {
    
    CGFloat textWidthMax = kbScreenWidth * 0.7;
    
    CGRect rect = [self.attributedString boundingRectWithSize:CGSizeMake(textWidthMax, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    CGSize size = CGSizeMake(CGFLOAT_CEIL(rect.size.width), CGFLOAT_CEIL(rect.size.height));
    self.textSize = size;
    self.textOrigin = CGPointMake(self.cellLayout.bubbleInsets.left, self.cellLayout.bubbleInsets.top+self.bubbleTop);

    size.height += self.cellLayout.bubbleInsets.top+self.cellLayout.bubbleInsets.bottom;
    size.width += self.cellLayout.bubbleInsets.left+self.cellLayout.bubbleInsets.right;

    if (self.direction == MsgDirectionIncoming) {
        size.height = MAX(size.height, [HHBubbleMessageCellData incommingBubble].size.height);
    } else {
        size.height = MAX(size.height, [HHBubbleMessageCellData outgoingBubble].size.height);
    }
    
    return size;
}

- (NSAttributedString *)attributedString {
    if (!_attributedString) {
        _attributedString = [self formatMessageString:_content];
    }
    return _attributedString;
}

// TODO Face
- (NSAttributedString *)formatMessageString:(NSString *)text {
    
    text = [text trim];
    
    // 先判断text是否存在
    if (text == nil || text.length == 0) {
        NSLog(@"TextMessageCell formatMessageString failed , current text is nil");
        return [[NSMutableAttributedString alloc] initWithString:@""];
    }
    // 1、创建一个可变的属性字符串
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:text];
    
    [attributeString addAttribute:NSFontAttributeName value:self.textFont range:NSMakeRange(0, attributeString.length)];
    return attributeString;
    
//    if ([TUIKit sharedInstance].config.faceGroups.count == 0) {
//        [attributeString addAttribute:NSFontAttributeName value:self.textFont range:NSMakeRange(0, attributeString.length)];
//        return attributeString;
//    }
//
//    // 2、通过正则表达式来匹配字符串
//    NSString *regex_emoji = @"\\[[a-zA-Z0-9\\/\\u4e00-\\u9fa5]+\\]"; // 匹配表情
//
//    NSError *error = nil;
//    NSRegularExpression *re = [NSRegularExpression regularExpressionWithPattern:regex_emoji options:NSRegularExpressionCaseInsensitive error:&error];
//    if (!re) {
//        NSLog(@"%@", [error localizedDescription]);
//        return attributeString;
//    }
//
//    NSArray *resultArray = [re matchesInString:text options:0 range:NSMakeRange(0, text.length)];
//
//    TFaceGroup *group = [TUIKit sharedInstance].config.faceGroups[0];
//
//    // 3、获取所有的表情以及位置
//    // 用来存放字典，字典中存储的是图片和图片对应的位置
//    NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:resultArray.count];
//    // 根据匹配范围来用图片进行相应的替换
//    for(NSTextCheckingResult *match in resultArray) {
//        // 获取数组元素中得到range
//        NSRange range = [match range];
//        // 获取原字符串中对应的值
//        NSString *subStr = [text substringWithRange:range];
//
//        for (TFaceCellData *face in group.faces) {
//            if ([face.name isEqualToString:subStr]) {
//                // face[i][@"png"]就是我们要加载的图片
//                // 新建文字附件来存放我们的图片,iOS7才新加的对象
//                NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
//                // 给附件添加图片
//                textAttachment.image = [[TUIImageCache sharedInstance] getFaceFromCache:face.path];
//                //调整一下图片的位置,如果你的图片偏上或者偏下，调整一下bounds的y值即可
//                textAttachment.bounds = CGRectMake(0, -4, 20, 20);
//                //把附件转换成可变字符串，用于替换掉源字符串中的表情文字
//                NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
//                //把图片和图片对应的位置存入字典中
//                NSMutableDictionary *imageDic = [NSMutableDictionary dictionaryWithCapacity:2];
//                [imageDic setObject:imageStr forKey:@"image"];
//                [imageDic setObject:[NSValue valueWithRange:range] forKey:@"range"];
//                //把字典存入数组中
//                [imageArray addObject:imageDic];
//                break;
//            }
//        }
//    }
//
//    //4、从后往前替换，否则会引起位置问题
//    for (int i = (int)imageArray.count -1; i >= 0; i--) {
//        NSRange range;
//        [imageArray[i][@"range"] getValue:&range];
//        //进行替换
//        [attributeString replaceCharactersInRange:range withAttributedString:imageArray[i][@"image"]];
//    }
//
//    [attributeString addAttribute:NSFontAttributeName value:self.textFont range:NSMakeRange(0, attributeString.length)];
//
//    return attributeString;
}

static UIColor *sOutgoingTextColor;

+ (UIColor *)outgoingTextColor {
    if (!sOutgoingTextColor) {
        sOutgoingTextColor = [UIColor blackColor];
    }
    return sOutgoingTextColor;
}

+ (void)setOutgoingTextColor:(UIColor *)outgoingTextColor {
    sOutgoingTextColor = outgoingTextColor;
}

static UIFont *sOutgoingTextFont;

+ (UIFont *)outgoingTextFont {
    if (!sOutgoingTextFont) {
        sOutgoingTextFont = [UIFont systemFontOfSize:17];
    }
    return sOutgoingTextFont;
}

+ (void)setOutgoingTextFont:(UIFont *)outgoingTextFont {
    sOutgoingTextFont = outgoingTextFont;
}

static UIColor *sIncommingTextColor;

+ (UIColor *)incommingTextColor {
    if (!sIncommingTextColor) {
        sIncommingTextColor = [UIColor blackColor];
    }
    return sIncommingTextColor;
}

+ (void)setIncommingTextColor:(UIColor *)incommingTextColor {
    sIncommingTextColor = incommingTextColor;
}

static UIFont *sIncommingTextFont;

+ (UIFont *)incommingTextFont {
    if (!sIncommingTextFont) {
        sIncommingTextFont = [UIFont systemFontOfSize:17];
    }
    return sIncommingTextFont;
}

+ (void)setIncommingTextFont:(UIFont *)incommingTextFont {
    sIncommingTextFont = incommingTextFont;
}

@end
