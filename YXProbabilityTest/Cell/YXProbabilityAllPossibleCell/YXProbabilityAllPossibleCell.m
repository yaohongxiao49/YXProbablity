//
//  YXProbabilityAllPossibleCell.m
//  YXProbabilityTest
//
//  Created by ios on 2021/6/18.
//  Copyright © 2021 August. All rights reserved.
//

#import "YXProbabilityAllPossibleCell.h"
#import "YXProbabilityCollectionViewCell.h"

@interface YXProbabilityAllPossibleCell () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *dataSourceArr;

@end

@implementation YXProbabilityAllPossibleCell

- (void)reloadValueByIndexPath:(NSIndexPath *)indexPath arr:(NSArray *)arr {
    
    YXProbabilityAllPossibleModel *model = arr[indexPath.row];
    self.titleLab.text = [NSString stringWithFormat:@"中四：%ld，中五：%ld，中六：%ld，中七：%ld", model.fourCount, model.fiveCount, model.sixCount, model.sevenCount];
    
    [self judgeBallArrByBall:model.item];
}

#pragma mark - 组装球数据
- (void)judgeBallArrByBall:(NSString *)ball {
    
    self.dataSourceArr = [[NSMutableArray alloc] init];
    NSArray *ballArr = [ball componentsSeparatedByString:@" "];
    for (NSInteger i = 0; i < ballArr.count; i++) {
        YXProbabilityBallInfoModel *ballModel = [[YXProbabilityBallInfoModel alloc] init];
        ballModel.value = ballArr[i];
        ballModel.boolBlue = (i == ballArr.count - 1) ? YES : NO;
        [self.dataSourceArr addObject:ballModel];
    }
    [self.collectionView reloadData];
}

#pragma mark - <UICollectionViewDataSource, UICollectionViewDelegate>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataSourceArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YXProbabilityCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([YXProbabilityCollectionViewCell class]) forIndexPath:indexPath];
    [cell reloadValueByIndexPath:indexPath arr:(NSArray *)self.dataSourceArr oldArr:@[]];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(30, 30);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(10, 15, 10, 15);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionHeadersPinToVisibleBounds = YES;
    
    [self.collectionView setCollectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    [self.collectionView registerNib:[UINib nibWithNibName:[YXProbabilityCollectionViewCell.class description] bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([YXProbabilityCollectionViewCell class])];
}

#pragma mark - 懒加载
- (NSMutableArray *)dataSourceArr {
    
    if (!_dataSourceArr) {
        _dataSourceArr = [[NSMutableArray alloc] init];
    }
    return _dataSourceArr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
