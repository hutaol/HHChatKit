//
//  HHKeyBoardMoreView.m
//  YYT
//
//  Created by Henry on 2020/8/7.
//  Copyright © 2020 eastraycloud. All rights reserved.
//

#import "HHKeyBoardMoreView.h"
#import "HHKeyBoardMoreCell.h"
#import "HHKeyBoardMoreFlowLayout.h"
#import "UIColor+HHKeyBoard.h"
#import "UIView+HHKeyBoard.h"
#import "HHKeyBoardHeader.h"

#define kPageControlHeight        10
#define kSpaceTop        10
#define kCellWidth       60

@implementation HHKeyBoardMoreView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor hh_colorWithString:@"#f5f5f5"];
        [self addSubview:self.collectionView];
        [self addSubview:self.pageControl];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.mm_left(0).mm_top(0).mm_flexToRight(0).mm_flexToBottom((kbHeightSafeBottom+kPageControlHeight));
    self.pageControl.mm_left(0).mm_top(self.collectionView.mm_h).mm_flexToRight(0).mm_height(kPageControlHeight);
}

- (void)setKeyboardMoreData:(NSMutableArray *)keyboardMoreData {
    _keyboardMoreData = keyboardMoreData;
    
    // TODO <5
    if (keyboardMoreData.count < 5) {
//        self.height = 125+10;
    }
    
    NSInteger page = (int)ceilf(keyboardMoreData.count / 8.f);

    self.pageControl.numberOfPages = page;

    self.pageControl.currentPage = 0;
    [self.collectionView reloadData];
    
    if (page == 1) {
        self.pageControl.hidden = YES;
    } else {
        self.pageControl.hidden = NO;
    }
}

#pragma mark - Delegate & DataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.keyboardMoreData.count / self.pageItemCount + (self.keyboardMoreData.count % self.pageItemCount == 0 ? 0 : 1);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.pageItemCount;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HHKeyBoardMoreCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[HHKeyBoardMoreCell cellId] forIndexPath:indexPath];

    NSUInteger index = indexPath.section * self.pageItemCount + indexPath.row;
    NSUInteger tIndex = [self p_transformIndex:index];  // 矩阵坐标转置
    if (tIndex >= self.keyboardMoreData.count) {
        [cell setItem:nil];
    } else {
        [cell setItem:self.keyboardMoreData[tIndex]];
    }
    
    __weak typeof(self) weakSelf = self;
    cell.clickBlock = ^(HHKeyBoardMoreItem * _Nonnull item) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(keyboardMore:didSelectedFunctionItem:)]) {
            [weakSelf.delegate keyboardMore:weakSelf didSelectedFunctionItem:item];
        }
    };
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(kCellWidth, (collectionView.frame.size.height - kSpaceTop) / 2 * 0.93);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return (collectionView.frame.size.width - kCellWidth * self.pageItemCount / 2) / (self.pageItemCount / 2 + 1);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return (collectionView.frame.size.height - kSpaceTop) / 2 * 0.07;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    CGFloat space = (collectionView.frame.size.width - kCellWidth * self.pageItemCount / 2) / (self.pageItemCount / 2 + 1);
    return UIEdgeInsetsMake(kSpaceTop, space, 0, space);
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.pageControl.currentPage = (int)(scrollView.contentOffset.x / self.frame.size.width);
}

- (void)pageControlChanged:(UIPageControl *)pageControl {
    [self.collectionView scrollRectToVisible:CGRectMake(self.collectionView.frame.size.width * pageControl.currentPage, 0, self.collectionView.frame.size.width, self.collectionView.frame.size.height) animated:YES];
}

#pragma mark - Private Methods

- (NSUInteger)p_transformIndex:(NSUInteger)index {
    NSUInteger page = index / self.pageItemCount;
    index = index % self.pageItemCount;
    NSUInteger x = index / 2;
    NSUInteger y = index % 2;
    return self.pageItemCount / 2 * y + x + page * self.pageItemCount;
}

#pragma mark - Getters

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.pagingEnabled = YES;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.scrollsToTop = NO;
        _collectionView.bounces = YES;
        [_collectionView registerClass:[HHKeyBoardMoreCell class] forCellWithReuseIdentifier:[HHKeyBoardMoreCell cellId]];
        
    }
    return _collectionView;
}

- (UIPageControl *)pageControl {
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.currentPageIndicatorTintColor = [UIColor darkGrayColor];
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        _pageControl.userInteractionEnabled = NO;
        _pageControl.currentPage = 0;
        [_pageControl addTarget:self action:@selector(pageControlChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _pageControl;
}

- (CGFloat)keyboardHeight {
    return 215 + kbHeightSafeBottom;
}

- (NSInteger)pageItemCount {
    return 8;
}

@end
