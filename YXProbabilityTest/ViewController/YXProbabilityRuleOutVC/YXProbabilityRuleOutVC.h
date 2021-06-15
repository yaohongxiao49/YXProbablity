//
//  YXProbabilityRuleOutVC.h
//  YXProbabilityTest
//
//  Created by ios on 2020/12/29.
//  Copyright © 2020 August. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSObject+YXCategory.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, YXProbabilityRuleOutVCType) {
    /** 按规则随机数据 */
    YXProbabilityRuleOutVCTypeRule,
    /** 往期数据 */
    YXProbabilityRuleOutVCTypeReal,
};

@interface YXProbabilityRuleOutVC : UIViewController

@property (nonatomic, assign) YXProbabilityRuleOutVCType type;

@end

NS_ASSUME_NONNULL_END
