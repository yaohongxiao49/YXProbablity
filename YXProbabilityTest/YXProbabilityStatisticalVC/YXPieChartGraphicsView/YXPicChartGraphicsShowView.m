//
//  YXPicChartGraphicsShowView.m
//  YXGraphicsTest
//
//  Created by ios on 2020/6/12.
//  Copyright © 2020 August. All rights reserved.
//

#import "YXPicChartGraphicsShowView.h"
#import "YXPicChartGraphicsShowCollView.h"

@interface YXPicChartGraphicsShowView () <YXPieChartGraphicsViewDelegate>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIView *desView;
@property (nonatomic, strong) UILabel *desLab;
@property (nonatomic, strong) YXPieChartGraphicsView *pieChartGraphicsView;
@property (nonatomic, strong) YXPicChartGraphicsShowCollView *showCollView;

@end

@implementation YXPicChartGraphicsShowView

- (instancetype)initWithFrame:(CGRect)frame arr:(nullable NSArray <YXPicChartGraphicsModel *>*)arr title:(NSString *)title {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.layer.masksToBounds = YES;
        self.userInteractionEnabled = YES;
        _title = title;
        if (arr.count != 0) self.pieChartGraphicsArr = [NSArray arrayWithArray:arr];
    }
    return self;
}

#pragma mark - 初始化蒙层
- (void)initMaskView {
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        weakSelf.desView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {}];
}

#pragma mark - 移除蒙层
- (void)removeMaskView {
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        weakSelf.desView.transform = CGAffineTransformTranslate(weakSelf.desView.transform, 0, -5);
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            weakSelf.desView.transform = CGAffineTransformTranslate(weakSelf.desView.transform, 0, weakSelf.frame.size.height);
        } completion:nil];
    }];
}

#pragma mark - <YXPieChartGraphicsViewDelegate>
- (void)yxPieChartGraphicsViewSelIndex:(YXPieChartGraphicsView *)pieChartGraphicsView index:(NSInteger)index {
    
    YXPicChartGraphicsModel *model = [self.pieChartGraphicsArr objectAtIndex:index];
    _desLab.text = [NSString stringWithFormat:@"标题：%@\n内容：%@\n个数：%.f个\n百分比：%.f%%", model.title, model.descript, model.count, model.percent *100];
    
    [self initMaskView];
}

#pragma mark - <UIResponderStandardEditActions>
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];

    if (CGRectContainsPoint(_desView.frame, point)) {
        [self removeMaskView];
    }
}

#pragma mark - setting
- (void)setPieChartGraphicsArr:(NSArray *)pieChartGraphicsArr {
    
    _pieChartGraphicsArr = pieChartGraphicsArr;
    
    [self initView];
}

#pragma mark - 初始化视图
- (void)initView {
    
    self.showCollView.dataSourceArr = [[NSMutableArray alloc] initWithArray:self.pieChartGraphicsArr];
    
    //创建说明view
    _desView = [[UIView alloc] initWithFrame:CGRectMake(self.showCollView.frame.origin.x, CGRectGetMaxY(self.showCollView.frame) + 20, self.showCollView.bounds.size.width, self.pieChartGraphicsView.bounds.size.height)];
    _desView.backgroundColor = [UIColor grayColor];
    _desView.layer.cornerRadius = 10;
    _desView.transform = CGAffineTransformMakeTranslation(0, self.frame.size.height);
    [[[[UIApplication sharedApplication] delegate] window] addSubview:_desView];
    
    _desLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, _desView.bounds.size.width - 40, _desView.bounds.size.height - 40)];
    _desLab.textColor = [UIColor whiteColor];
    _desLab.numberOfLines = 0;
    [_desView addSubview:_desLab];
    
    UIButton *resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    resetBtn.frame = CGRectMake(0, 0, 100, 60);
    [resetBtn setTitle:_title forState:UIControlStateNormal];
    [resetBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:resetBtn];
}

#pragma mark - 懒加载
- (YXPieChartGraphicsView *)pieChartGraphicsView {
    
    if (!_pieChartGraphicsView) {
        _pieChartGraphicsView = [[YXPieChartGraphicsView alloc] initWithFrame:CGRectMake(self.frame.size.width /4, 10, self.frame.size.width /2, self.frame.size.width /2) arr:self.pieChartGraphicsArr];
        _pieChartGraphicsView.delegete = self;
        [self addSubview:_pieChartGraphicsView];
    }
    return _pieChartGraphicsView;
}
- (YXPicChartGraphicsShowCollView *)showCollView {
    
    if (!_showCollView) {
        _showCollView = [[YXPicChartGraphicsShowCollView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.pieChartGraphicsView.frame), CGRectGetMaxY(self.pieChartGraphicsView.frame) + 20, self.pieChartGraphicsView.bounds.size.width, 30)];
        _showCollView.userInteractionEnabled = YES;
        [self addSubview:_showCollView];
        
        __weak typeof(self) weakSelf = self;
        _showCollView.yxPicChartGraphicsShowCollViewBlock = ^(NSInteger index) {
            
            [weakSelf.pieChartGraphicsView selCurrentIndex:index];
        };
    }
    return _showCollView;
}

@end
