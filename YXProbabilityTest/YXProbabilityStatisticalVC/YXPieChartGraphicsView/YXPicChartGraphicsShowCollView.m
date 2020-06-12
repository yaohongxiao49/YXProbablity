//
//  YXPicChartGraphicsShowCollView.m
//  YXGraphicsTest
//
//  Created by ios on 2020/6/12.
//  Copyright © 2020 August. All rights reserved.
//

#import "YXPicChartGraphicsShowCollView.h"
#import "YXPicChartGraphicsShowCollCell.h"

@interface YXPicChartGraphicsShowCollView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation YXPicChartGraphicsShowCollView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark - 计算字符串所占宽
- (CGFloat)strWidthWithStr:(NSString *)str height:(CGFloat)height font:(UIFont *)font {
    
    CGSize newSize = [self strSizeWithStr:str size:CGSizeMake(CGFLOAT_MAX, height) font:font];
    
    return newSize.width;
}
- (CGSize)strSizeWithStr:(NSString *)str size:(CGSize)size font:(UIFont *)font {
    
    if (str.length == 0) {
        return CGSizeZero;
    }
    
    CGSize newSize = [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil] context:nil].size;
    
    return newSize;
}

#pragma mark - <UICollectionViewDataSource, UICollectionViewDelegate>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _dataSourceArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YXPicChartGraphicsShowCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([YXPicChartGraphicsShowCollCell class]) forIndexPath:indexPath];
    [cell reloadValueByIndexPath:indexPath arr:_dataSourceArr];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.yxPicChartGraphicsShowCollViewBlock) {
        self.yxPicChartGraphicsShowCollViewBlock(indexPath.row);
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YXPicChartGraphicsModel *model = _dataSourceArr[indexPath.row];
    CGFloat width = 20 + [self strWidthWithStr:model.title height:self.bounds.size.height font:[UIFont systemFontOfSize:14]];
    return CGSizeMake(width, self.bounds.size.height);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}

#pragma mark - setting
- (void)setDataSourceArr:(NSMutableArray *)dataSourceArr {
    
    _dataSourceArr = dataSourceArr;
    [_collectionView reloadData];
}

#pragma mark - 初始化视图
- (void)initView {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_collectionView];
    
    [_collectionView registerNib:[UINib nibWithNibName:[YXPicChartGraphicsShowCollCell.class description] bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([YXPicChartGraphicsShowCollCell class])];
}

@end
