//
//  YXProbabilityAllListCell.h
//  YXProbabilityTest
//
//  Created by ios on 2020/6/11.
//  Copyright © 2020 August. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXProbabilityCollectionViewCell.h"
#import "YXProbabilitySecHeaderView.h"

NS_ASSUME_NONNULL_BEGIN

@interface YXProbabilityAllListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

- (void)reloadValueByIndexPath:(NSIndexPath *)indexPath arr:(NSMutableArray *)arr oldArr:(NSMutableArray *)oldArr;

@end

NS_ASSUME_NONNULL_END
