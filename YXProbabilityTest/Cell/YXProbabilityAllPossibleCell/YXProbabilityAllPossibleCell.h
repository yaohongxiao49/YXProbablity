//
//  YXProbabilityAllPossibleCell.h
//  YXProbabilityTest
//
//  Created by ios on 2021/6/18.
//  Copyright © 2021 August. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXProbabilityAllPossibleModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YXProbabilityAllPossibleCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *moneyLab;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

- (void)reloadValueByIndexPath:(NSIndexPath *)indexPath arr:(NSArray *)arr;

@end

NS_ASSUME_NONNULL_END
