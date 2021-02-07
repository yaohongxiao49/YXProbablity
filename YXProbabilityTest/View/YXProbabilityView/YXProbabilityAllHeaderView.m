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

#pragma mark - 对比排除
- (IBAction)progressRuleOut:(UIButton *)sender {
 
    YXProbabilityRuleOutVC *vc = [[YXProbabilityRuleOutVC alloc] init];
    [self.baseVC.navigationController pushViewController:vc animated:YES];
}

#pragma mark - other
- (IBAction)progressOtherFirstBtn:(UIButton *)sender {
    
    [[YXProbabilityManager sharedManager] getMaxNumByIndex:0 begainArr:[YXProbabilityListArrModel arrayOfModelsFromDictionaries:[[YXProbabilityManager sharedManager] allArr]] baseVC:self.baseVC];
}
- (IBAction)progressOtherSecondBtn:(UIButton *)sender {
 
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    [[YXProbabilityManager sharedManager] getSingleMaxNumByIndex:0 begainArr:[YXProbabilityListArrModel arrayOfModelsFromDictionaries:[[YXProbabilityManager sharedManager] allArr]] endArr:arr baseVC:self.baseVC];
}

#pragma mark - setting
- (void)setBaseVC:(UIViewController *)baseVC {
    
    _baseVC = baseVC;
}

@end
