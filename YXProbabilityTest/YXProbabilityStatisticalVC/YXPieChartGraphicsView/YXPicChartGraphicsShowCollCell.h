//
//  YXPicChartGraphicsShowCollCell.h
//  YXGraphicsTest
//
//  Created by ios on 2020/6/12.
//  Copyright © 2020 August. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXPicChartGraphicsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YXPicChartGraphicsShowCollCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIButton *showBtn;

- (void)reloadValueByIndexPath:(NSIndexPath *)indexPath arr:(NSMutableArray *)arr;

@end

NS_ASSUME_NONNULL_END
