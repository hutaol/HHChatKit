//
//  HHCommonTableViewCell.h
//  HHChatKit
//
//  Created by Henry on 2020/8/13.
//  Copyright © 2020 Henry. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHCommonCellData : NSObject

@property (strong) NSString *reuseId;
@property (nonatomic, assign) SEL cselector;

- (CGFloat)heightOfWidth:(CGFloat)width;

@end

@interface HHCommonTableViewCell : UITableViewCell

@property (readonly) HHCommonCellData *data;
@property UIColor *colorWhenTouched;
@property BOOL changeColorWhenTouched;

- (void)fillWithData:(HHCommonCellData *)data;

@end

NS_ASSUME_NONNULL_END
