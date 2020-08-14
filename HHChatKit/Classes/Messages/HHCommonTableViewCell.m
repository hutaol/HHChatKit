//
//  HHCommonTableViewCell.m
//  HHChatKit
//
//  Created by Henry on 2020/8/13.
//  Copyright © 2020 Henry. All rights reserved.
//

#import "HHCommonTableViewCell.h"

@implementation HHCommonCellData

- (CGFloat)heightOfWidth:(CGFloat)width {
    return 44;
}

@end


@interface HHCommonTableViewCell ()

@property HHCommonCellData *data;
@property UITapGestureRecognizer *tapRecognizer;

@end

@implementation HHCommonTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style
                    reuseIdentifier:reuseIdentifier]) {
        _tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
        _tapRecognizer.delegate = self;
        _tapRecognizer.cancelsTouchesInView = NO;
        
        _colorWhenTouched = [UIColor colorWithRed:219.0/255.0 green:219.0/255.0  blue:219.0/255.0  alpha:1];
        _changeColorWhenTouched = NO;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)tapGesture:(UIGestureRecognizer *)gesture {
    if (self.data.cselector) {
        UIViewController *vc = self.hh_viewController;
        if ([vc respondsToSelector:self.data.cselector]) {
            self.selected = YES;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [vc performSelector:self.data.cselector withObject:self];
#pragma clang diagnostic pop
        }
    }
}

- (void)fillWithData:(HHCommonCellData *)data {
    self.data = data;
    if (data.cselector) {
        [self addGestureRecognizer:self.tapRecognizer];
    } else {
        [self removeGestureRecognizer:self.tapRecognizer];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.changeColorWhenTouched) {
        self.backgroundColor = self.colorWhenTouched;
    }
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.changeColorWhenTouched) {
        self.backgroundColor = [UIColor whiteColor];
    }
}


- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.changeColorWhenTouched) {
        self.backgroundColor = [UIColor whiteColor];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.changeColorWhenTouched) {
        self.backgroundColor = [UIColor whiteColor];
    }
}

- (UIViewController *)hh_viewController {
    UIView *view = self;
    while (view) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
        view = view.superview;
    }
    return nil;
}

@end
