//
//  YXProbabilityAllHeaderView.m
//  YXProbabilityTest
//
//  Created by ios on 2020/6/12.
//  Copyright © 2020 August. All rights reserved.
//

#import "YXProbabilityAllHeaderView.h"

@implementation YXProbabilityAllHeaderView

#pragma mark - 图形化统计
- (IBAction)progressStatisticalBtn:(UIButton *)sender {
    
    YXProbabilityStatisticalVC *vc = [[YXProbabilityStatisticalVC alloc] init];
    [self.baseVC.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 随机产生概率最大、最小
- (IBAction)progressRandomBtn:(UIButton *)sender {
    
    YXProbabilityRandomVC *vc = [[YXProbabilityRandomVC alloc] init];
    vc.vcType = YXProbabilityRandomVCTypeReal;
    [self.baseVC.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 随机概率
- (IBAction)progressProbabilityRandomBtn:(UIButton *)sender {
    
    YXProbabilityRandomVC *vc = [[YXProbabilityRandomVC alloc] init];
    vc.vcType = YXProbabilityRandomVCTypeProbability;
    [self.baseVC.navigationController pushViewController:vc animated:YES];
}

- (void)setBaseVC:(UIViewController *)baseVC {
    
    _baseVC = baseVC;
}

@end
