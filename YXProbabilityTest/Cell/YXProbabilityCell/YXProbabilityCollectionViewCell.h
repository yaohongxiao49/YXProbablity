//
//  YXProbabilityCollectionViewCell.h
//  YXProbabilityTest
//
//  Created by ios on 2020/6/12.
//  Copyright © 2020 August. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXProbabilityManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface YXProbabilityCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIButton *numBtn;

- (void)reloadValueByIndexPath:(NSIndexPath *)indexPath arr:(NSArray *)arr oldArr:(NSArray *)oldArr;

@end

NS_ASSUME_NONNULL_END
