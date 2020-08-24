//
//  YXProbabilityRandomVC.h
//  YXProbabilityTest
//
//  Created by ios on 2020/6/12.
//  Copyright © 2020 August. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, YXProbabilityRandomVCType) {
    /** 真实随机 */
    YXProbabilityRandomVCTypeReal,
    /** 概率随机 */
    YXProbabilityRandomVCTypeProbability,
};

@interface YXProbabilityRandomVC : UIViewController

@property (nonatomic, assign) YXProbabilityRandomVCType vcType;

@end

NS_ASSUME_NONNULL_END
