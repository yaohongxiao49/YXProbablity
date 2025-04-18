//
//  YXProbabilityRandomHeaderView.m
//  YXProbabilityTest
//
//  Created by ios on 2020/6/15.
//  Copyright © 2020 August. All rights reserved.
//

#import "YXProbabilityRandomHeaderView.h"

@interface YXProbabilityRandomHeaderView () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textfiled;
@property (nonatomic, assign) NSInteger count;

@end

@implementation YXProbabilityRandomHeaderView

#pragma mark - 更新开启按钮
- (void)upDateOpenBtn:(BOOL)boolOpen {
    
    if (!boolOpen) {
        [self.startBtn setTitle:@"开启" forState:UIControlStateNormal];
        self.startBtn.userInteractionEnabled = YES;
        self.yxProbabilityRandomHVEndBlock();
    }
    else {
        [self.startBtn setTitle:@"已开启" forState:UIControlStateNormal];
        self.startBtn.userInteractionEnabled = NO;
    }
}

#pragma mark - progress
#pragma mark - 开启
- (IBAction)progressStartBtn:(UIButton *)sender {
    
    [self endEditing:YES];
    [self upDateOpenBtn:YES];
    
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (weakSelf.yxProbabilityRandomHVBlock) {
            weakSelf.yxProbabilityRandomHVBlock(weakSelf.count);
        }
    });
}
#pragma mark - 关闭
- (IBAction)progressCloseBtn:(UIButton *)sender {
    
    if (self.yxProbabilityRandomHVEndBlock) {
        [self upDateOpenBtn:NO];
        self.yxProbabilityRandomHVEndBlock();
    }
}
#pragma mark - 与往期数据对比
- (IBAction)progressCompareBtn:(UIButton *)sender {
    
    if (self.yxProbabilityRandomHVCompareBlock) {
        self.yxProbabilityRandomHVCompareBlock();
    }
}

#pragma mark - <UITextFieldDelegate>
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self endEdit:textField];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    [self endEdit:textField];
}
- (void)endEdit:(UITextField *)textField {
    
    self.count = [textField.text integerValue];
}

#pragma mark - setting
- (void)setPrgressValue:(CGFloat)prgressValue {
    
    _prgressValue = prgressValue;
    
    self.progressView.progress = _prgressValue;
    self.progressLab.text = [NSString stringWithFormat:@"%.f%%", _prgressValue *100];
    
    if (_prgressValue >= 1 && self.yxProbabilityRandomHVEndBlock) {
        [self upDateOpenBtn:NO];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.progressView.progressViewStyle = UIProgressViewStyleDefault;
    self.progressView.progressTintColor = [UIColor orangeColor];
    self.progressView.progress = 0;
    
    self.textfiled.delegate = self;
}

@end
