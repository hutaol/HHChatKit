//
//  HHImageMessageCell.m
//  HHChatKit
//
//  Created by Henry on 2020/8/13.
//  Copyright © 2020 Henry. All rights reserved.
//

#import "HHImageMessageCell.h"
#import "UIView+HHLayout.h"
#import "UIImageView+HHChat.h"

@implementation HHImageMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _thumb = [[UIImageView alloc] init];
        _thumb.contentMode = UIViewContentModeScaleAspectFill;
        _thumb.backgroundColor = [UIColor grayColor];
        [self.container addSubview:_thumb];
        _thumb.mm_fill();
        _thumb.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        _progress = [[UILabel alloc] init];
        _progress.textColor = [UIColor whiteColor];
        _progress.font = [UIFont systemFontOfSize:15];
        _progress.textAlignment = NSTextAlignmentCenter;
        _progress.layer.cornerRadius = 5.0;
        _progress.hidden = YES;
        _progress.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        [_progress.layer setMasksToBounds:YES];
        [self.container addSubview:_progress];
        _progress.mm_fill();
        _progress.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        self.thumb.image = self.imageData.thumbImage;

        if (!self.thumb.image) {
            self.thumb.image = self.imageData.originImage;
        }
        
        
        // MsgDirectionIncoming
//        [self.KVOController observe:self keyPath:@"imageData.thumbProgress" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld block:^(id observer, id object, NSDictionary *change) {
//            @strongify(self)
//            if (self.imageData.direction == MsgDirectionIncoming) {
//                int progress = (int)self.imageData.thumbProgress;
//                self.progress.text = [NSString stringWithFormat:@"%d%%", progress];
//                self.progress.hidden = (progress >= 100 || progress == 0);
//            }
//        }];
        
        // MsgDirectionOutgoing
//        [self.KVOController observe:self keyPath:@"imageData.uploadProgress" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld block:^(id observer, id object, NSDictionary *change) {
//            @strongify(self)
//            if (self.imageData.direction == MsgDirectionOutgoing) {
//                int progress = (int)self.imageData.uploadProgress;
//
//                if (progress >= 100 || progress == 0) {
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        [self.indicator stopAnimating];
//                    });
//                } else {
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        [self.indicator startAnimating];
//                    });
//                }
//            }
//        }];
        
    }
    return self;
}

- (void)fillWithData:(HHImageMessageCellData *)data {
    [super fillWithData:data];
    
    self.imageData = data;
//    _thumb.image = nil;

    // TODO self.imageData 存在才行
    if (data.thumbImage || data.originImage) {
        _thumb.image = data.thumbImage ?: data.originImage;

    } else {
        _thumb.image = [UIImage imageWithContentsOfFile:data.path];
//        [data downloadImage:TImage_Type_Thumb];
    }
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.messageData.direction == MsgDirectionIncoming) {
        self.thumb.mm_left(10);
    } else {
        self.thumb.mm_flexToRight(10);
    }
    
    [self.thumb hh_setRoundedCorners:4];

}

@end
