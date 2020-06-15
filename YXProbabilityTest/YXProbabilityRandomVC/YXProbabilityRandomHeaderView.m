//
//  YXProbabilityRandomHeaderView.m
//  YXProbabilityTest
//
//  Created by ios on 2020/6/15.
//  Copyright © 2020 August. All rights reserved.
//

#import "YXProbabilityRandomHeaderView.h"

@implementation YXProbabilityRandomHeaderView

#pragma mark - 开启
- (IBAction)progressStartBtn:(UIButton *)sender {
    
    [sender setTitle:@"已开启" forState:UIControlStateNormal];
    sender.userInteractionEnabled = NO;
    
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (weakSelf.yxProbabilityRandomHVBlock) {
            weakSelf.yxProbabilityRandomHVBlock();
        }
    });
}

- (void)setPrgressValue:(CGFloat)prgressValue {
    
    _prgressValue = prgressValue;
    
    self.progressView.progress = _prgressValue;
    self.progressLab.text = [NSString stringWithFormat:@"%.f%%", _prgressValue *100];
    
    if (_prgressValue >= 1 && self.yxProbabilityRandomHVEndBlock) {
        [self.startBtn setTitle:@"开启" forState:UIControlStateNormal];
        self.startBtn.userInteractionEnabled = YES;
        self.yxProbabilityRandomHVEndBlock();
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.progressView.progressViewStyle = UIProgressViewStyleDefault;
    self.progressView.progressTintColor = [UIColor orangeColor];
    self.progressView.progress = 0;
}

@end
