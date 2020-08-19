//
//  YXProbabilityCollectionViewCell.m
//  YXProbabilityTest
//
//  Created by ios on 2020/6/12.
//  Copyright © 2020 August. All rights reserved.
//

#import "YXProbabilityCollectionViewCell.h"

@implementation YXProbabilityCollectionViewCell

- (void)reloadValueByIndexPath:(NSIndexPath *)indexPath arr:(NSArray *)arr oldArr:(NSArray *)oldArr {
    
    YXProbabilityBallInfoModel *model = arr[indexPath.row];
    [self.numBtn setTitle:model.value forState:UIControlStateNormal];
    
    if (model.boolBlue) {
        [self.numBtn setTitleColor:[UIColor colorWithRed:125 /255.0 green:174 /255.0 blue:253 /255.0 alpha:1] forState:UIControlStateNormal];
        self.numBtn.layer.borderColor = [[UIColor colorWithRed:125 /255.0 green:174 /255.0 blue:253 /255.0 alpha:1] CGColor];
    }
    else {
        [self.numBtn setTitleColor:[UIColor colorWithRed:220 /255.0 green:85 /255.0 blue:85 /255.0 alpha:1] forState:UIControlStateNormal];
        self.numBtn.layer.borderColor = [[UIColor colorWithRed:220 /255.0 green:85 /255.0 blue:85 /255.0 alpha:1] CGColor];
    }
    
    if (oldArr.count != 0) {
        __block BOOL boolBingo = NO;
        YXProbabilityListModel *oldListModel = oldArr[0];
        [oldListModel.valueArr enumerateObjectsUsingBlock:^(YXProbabilityBallInfoModel *  _Nonnull oldModel, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSInteger value = [model.value integerValue];
            NSInteger oldValue = [oldModel.value integerValue];
            boolBingo = value == oldValue ? YES : NO;
            if (boolBingo == YES) {
                *stop = YES;
            }
        }];
        self.numBtn.backgroundColor = boolBingo ? [UIColor greenColor] : [UIColor whiteColor];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
