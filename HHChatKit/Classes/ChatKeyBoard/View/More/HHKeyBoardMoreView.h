//
//  HHKeyBoardMoreView.h
//  YYT
//
//  Created by Henry on 2020/8/7.
//  Copyright © 2020 eastraycloud. All rights reserved.
//

#import "HHBaseKeyboard.h"
#import "HHKeyBoardMoreItem.h"

NS_ASSUME_NONNULL_BEGIN

@protocol HHKeyBoardMoreViewDelegate <NSObject>

@optional
- (void)keyboardMore:(id)keyboard didSelectedFunctionItem:(HHKeyBoardMoreItem *)funcItem;

@end

@interface HHKeyBoardMoreView : HHBaseKeyboard <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) id<HHKeyBoardMoreViewDelegate> delegate;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) NSMutableArray *keyboardMoreData;

@property (nonatomic, assign, readonly) NSInteger pageItemCount;

@end

NS_ASSUME_NONNULL_END
