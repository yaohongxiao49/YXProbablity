//
//  YXProbabilityRandomHeaderView.h
//  YXProbabilityTest
//
//  Created by ios on 2020/6/15.
//  Copyright © 2020 August. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^YXProbabilityRandomHVBlock)(NSInteger diyCount);
typedef void(^YXProbabilityRandomHVEndBlock)(void);
typedef void(^YXProbabilityRandomHVCompareBlock)(void);

@interface YXProbabilityRandomHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *progressLab;
@property (weak, nonatomic) IBOutlet UIButton *compareBtn;

@property (nonatomic, assign) CGFloat prgressValue;
@property (nonatomic, copy) YXProbabilityRandomHVBlock yxProbabilityRandomHVBlock;
@property (nonatomic, copy) YXProbabilityRandomHVEndBlock yxProbabilityRandomHVEndBlock;
@property (nonatomic, copy) YXProbabilityRandomHVCompareBlock yxProbabilityRandomHVCompareBlock;

@end

NS_ASSUME_NONNULL_END
