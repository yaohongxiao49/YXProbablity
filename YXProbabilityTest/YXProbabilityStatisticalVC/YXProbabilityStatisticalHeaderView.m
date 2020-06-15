
//
//  YXProbabilityStatisticalHeaderView.m
//  YXProbabilityTest
//
//  Created by ios on 2020/6/15.
//  Copyright © 2020 August. All rights reserved.
//

#import "YXProbabilityStatisticalHeaderView.h"

@interface YXProbabilityStatisticalHeaderView ()

@property (nonatomic, strong) YXPicChartGraphicsShowView *redView;
@property (nonatomic, strong) YXPicChartGraphicsShowView *blueView;

@end

@implementation YXProbabilityStatisticalHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark - 初始化视图
- (void)initView {
    
    
}

#pragma mark - setting
- (void)setRedArr:(NSMutableArray *)redArr {
    
    _redArr = redArr;
    self.redView.pieChartGraphicsArr = _redArr;
}
- (void)setBlueArr:(NSMutableArray *)blueArr {
    
    _blueArr = blueArr;
    self.blueView.pieChartGraphicsArr = _blueArr;
}

#pragma mark - 懒加载
- (YXPicChartGraphicsShowView *)redView {
    
    if (!_redView) {
        _redView = [[YXPicChartGraphicsShowView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height /2) arr:nil title:@"红球"];
        [self addSubview:_redView];
    }
    return _redView;
}
- (YXPicChartGraphicsShowView *)blueView {
    
    if (!_blueView) {
        _blueView = [[YXPicChartGraphicsShowView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height /2, self.bounds.size.width, self.bounds.size.height /2) arr:nil title:@"蓝球"];
        [self addSubview:_blueView];
    }
    return _blueView;
}

@end
