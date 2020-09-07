//
//  YXProbabilityCompareVC.h
//  YXProbabilityTest
//
//  Created by ios on 2020/8/3.
//  Copyright © 2020 August. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXProbabilityAllListCell.h"
#import "NSObject+YXCategory.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, YXProbabilityCompareVCType) {
    /** 往期 */
    YXProbabilityCompareVCTypeOld,
    /** 比较 */
    YXProbabilityCompareVCTypeCompare,
    /** 统计 */
    YXProbabilityCompareVCTypeStatistical,
    /** 随机频率最大 */
    YXProbabilityCompareVCTypeRandomMax,
    /** 随机频率最小 */
    YXProbabilityCompareVCTypeRandomMin,
    /** 随机计算后概率数据 */
    YXProbabilityCompareVCTypeCalculateRandom,
};

@interface YXProbabilityCompareVC : UIViewController

@property (nonatomic, strong) NSMutableArray *realArr;
@property (nonatomic, copy) NSArray *randomArr;
@property (nonatomic, copy) NSArray *calculateRandomArr;

@end

NS_ASSUME_NONNULL_END
