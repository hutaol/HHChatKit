//
//  HHKeyBoardTextView.m
//  YYT
//
//  Created by Henry on 2020/8/7.
//  Copyright © 2020 eastraycloud. All rights reserved.
//

#import "HHKeyBoardTextView.h"
#import "UIColor+HHKeyBoard.h"

@implementation HHKeyBoardTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _placeHolder = nil;
        _placeHolderColor = [UIColor hh_colorWithString:@"#999999"];
        self.font = [UIFont systemFontOfSize:17];
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 3.f;
        self.layer.borderColor = [UIColor hh_colorWithString:@"#e0e0e0"].CGColor;
        self.layer.borderWidth = 0.5f;
        self.textContainerInset = UIEdgeInsetsMake(10.f, 8.f, 8.f, 10.f);
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.scrollEnabled = NO;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(textViewNotification:)
                                                     name:UITextViewTextDidChangeNotification
                                                   object:self];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(textViewNotification:)
                                                     name:UITextViewTextDidBeginEditingNotification
                                                   object:self];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(textViewNotification:)
                                                     name:UITextViewTextDidEndEditingNotification
                                                   object:self];
    }
    return self;
}

- (void)textViewNotification:(NSNotification *)noti {
    [self setNeedsDisplay];
}

- (void)setPlaceHolder:(NSString *)placeHolder {
    _placeHolder = placeHolder;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (self.text.length == 0 && self.placeHolder) {
        [self.placeHolderColor set];
        [self.placeHolder drawInRect:CGRectInset(rect, 10.f, 7.f) withAttributes:[self placeholderTextAttributes]];
    }
}

- (NSDictionary *)placeholderTextAttributes {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    paragraphStyle.alignment = self.textAlignment;
    NSDictionary *params = @{ NSFontAttributeName : self.font,
                              NSForegroundColorAttributeName : _placeHolderColor,
                              NSParagraphStyleAttributeName : paragraphStyle };
    return params;
}

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

@end
