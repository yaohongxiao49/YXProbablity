
//
//  YXProbabilityStatisticalHeaderView.m
//  YXProbabilityTest
//
//  Created by ios on 2020/6/15.
//  Copyright © 2020 August. All rights reserved.
//

#import "YXProbabilityStatisticalHeaderView.h"

@interface YXProbabilityStatisticalHeaderView ()

@property (nonatomic, strong) YXPieChartLineGraphicsView *redView;
@property (nonatomic, strong) YXPieChartLineGraphicsView *blueView;

@end

@implementation YXProbabilityStatisticalHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.redView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height /2);
    [self.redView draw];
    self.blueView.frame = CGRectMake(0, self.bounds.size.height /2, self.bounds.size.width, self.bounds.size.height /2);
    [self.blueView draw];
}

#pragma mark - setting
- (void)setRedArr:(NSMutableArray *)redArr {
    
    _redArr = redArr;
    self.redView.dataSourceArr = _redArr;
}
- (void)setBlueArr:(NSMutableArray *)blueArr {
    
    _blueArr = blueArr;
    self.blueView.dataSourceArr = _blueArr;
}

#pragma mark - 懒加载
- (YXPieChartLineGraphicsView *)redView {
    
    if (!_redView) {
        _redView = [[YXPieChartLineGraphicsView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height /2)];
        _redView.title = @"红球";
        [_redView draw];
        [self addSubview:_redView];
    }
    return _redView;
}
- (YXPieChartLineGraphicsView *)blueView {
    
    if (!_blueView) {
        _blueView = [[YXPieChartLineGraphicsView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height /2, self.bounds.size.width, self.bounds.size.height /2)];
        _blueView.title = @"蓝球";
        [_blueView draw];
        [self addSubview:_blueView];
    }
    return _blueView;
}

@end
