//
//  YXPieChartGraphicsView.m
//  YXGraphicsTest
//
//  Created by ios on 2020/6/12.
//  Copyright © 2020 August. All rights reserved.
//

#import "YXPieChartGraphicsView.h"

@interface YXPieChartGraphicsView ()

@property (nonatomic, strong) NSMutableArray <YXPicChartGraphicsModel *>* modelArr;
@property (nonatomic, strong) NSMutableArray *pathArr;
@property (nonatomic, strong) CABasicAnimation *animation;
@property (nonatomic, strong) CAShapeLayer *maskLayer; //动画效果mask
@property (nonatomic, strong) CAShapeLayer *selLayer; //选中layer
@property (nonatomic, assign) CGFloat currentPercent; //当前绘制百分百总和
@property (nonatomic, strong) CALayer *contentLayer; //中心layer容器
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) CGPoint centerPoint;

@end

@implementation YXPieChartGraphicsView

- (instancetype)initWithFrame:(CGRect)frame arr:(NSArray <YXPicChartGraphicsModel *>*)arr {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initDataSource];
        [self initCalculateDataSourece:arr];
        [self initView];
        [self initAnimation];
    }
    return self;
}

#pragma mark - 刷新数据
- (void)reloadValueByArr:(NSArray <YXPicChartGraphicsModel *>*)arr {
    
    [_contentLayer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    [_contentLayer removeFromSuperlayer];
    _contentLayer = nil;
    _pathArr = [[NSMutableArray alloc]init];

    [self initCalculateDataSourece:arr];
    [self initView];
    [self initAnimation];
}

#pragma mark - 移除选中状态
- (void)removeSelStatus {
    
    [_selLayer removeFromSuperlayer];
    _selLayer = nil;
}

#pragma mark - 选中当前Index
- (void)selCurrentIndex:(NSInteger)index {
    
    [self didSelByIndex:index];
}

#pragma mark - 选择当前model
- (void)selCurrentModel:(YXPicChartGraphicsModel *)model {
    
    if (self.modelArr && self.pathArr) {
        NSInteger index = [self.modelArr indexOfObject:model];
        [self selCurrentIndex:index];
    }
}

#pragma mark - 选中区域
- (void)didSelByIndex:(NSInteger)index {
    
    if (self.delegete && [self.delegete respondsToSelector:@selector(yxPieChartGraphicsViewSelIndex:index:)]) {
        [self.delegete yxPieChartGraphicsViewSelIndex:self index:index];
    }

    if (!self.boolSelAnimation) return;
    
    CGFloat sum = 0;
    if (index != 0) {
        for (int i = 0; i < index; i++) {
            YXPicChartGraphicsModel *modle = [_modelArr objectAtIndex:i];
            sum += modle.percent;
        }
    }
    
    YXPicChartGraphicsModel *modle = [_modelArr objectAtIndex:index];
    self.selLayer.strokeStart = sum;
    self.selLayer.strokeEnd = modle.percent + sum;
    self.selLayer.strokeColor = modle.color.CGColor;
}

#pragma mark - 绘制动画
- (void)createLayerWithStartAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle color:(UIColor *)color model:(YXPicChartGraphicsModel *)model {
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:_centerPoint radius:_radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    [path addLineToPoint:_centerPoint];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.fillColor = color.CGColor;
    [_contentLayer addSublayer:layer];
    [_pathArr addObject:path];
    
    //标签坐标
    float r = _width /4;
    CGFloat labWidth = _width /6 + 5 >= 45 ? 40 : _width /6;
    CGFloat labX = _centerPoint.x + (r + labWidth /2) * cos((startAngle + (endAngle - startAngle) /2)) - labWidth /2;
    CGFloat labY = _centerPoint.y + (r + labWidth *3 /8) * sin((startAngle + (endAngle - startAngle) /2)) - labWidth *3 /8 + 3;
    
    //加字
    CATextLayer *textLayer = [[CATextLayer alloc]init];
    textLayer.frame = CGRectMake(labX, labY, labWidth, labWidth *3 /4);
    textLayer.alignmentMode = kCAAlignmentCenter;
    textLayer.string = [NSString stringWithFormat:@"%.f%%", model.percent *100];
    textLayer.fontSize = _width /15;
    textLayer.foregroundColor = [UIColor whiteColor].CGColor;
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    [_contentLayer addSublayer:textLayer];
}

#pragma mark - <UIResponderStandardEditActions>
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (!self.boolSel) return;
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    //中间镂空圆范围不可点
    UIBezierPath *rectPath = [UIBezierPath bezierPathWithArcCenter:_centerPoint radius:_width /10 startAngle:M_PI_2 endAngle:M_PI_2 *4 clockwise:YES];
    
    //遍历点击的区域
    for (UIBezierPath *path in _pathArr) {
        if ([path containsPoint:point] && ![rectPath containsPoint:point]) {
            NSInteger index = [_pathArr indexOfObject:path];
            [self didSelByIndex:index];
            return;
        }
    }
}

#pragma mark - 重置动画
- (void)initAnimation {
    
    [self removeSelStatus];
    [self.maskLayer removeAnimationForKey:@"starAnimation"];
    _contentLayer.mask = self.maskLayer;
    [self.maskLayer addAnimation:self.animation forKey:@"starAnimation"];
}

#pragma mark - 初始化数据
- (void)initDataSource {
    
    _boolSel = YES;
    _boolSelAnimation = YES;
    _currentPercent = 0;
    _width  = self.frame.size.width;
    _radius = self.frame.size.width /2;
    _centerPoint = CGPointMake(self.frame.size.width /2, self.frame.size.width /2);
    _pathArr = [[NSMutableArray alloc] init];
}

#pragma mark - 初始化计算数据
- (void)initCalculateDataSourece:(NSArray *)arr {
    
    _modelArr = [NSMutableArray arrayWithArray:arr];
    CGFloat sumCount = 0;
    
    //计算总和
    for (YXPicChartGraphicsModel *model in _modelArr) {
        sumCount += model.count;
    }
    //计算所占百分百
    for (int i = 0; i < _modelArr.count; i++) {
        YXPicChartGraphicsModel *model = _modelArr[i];
        CGFloat percent = model.count /sumCount;
        model.percent = percent;
    }
}

#pragma mark - 初始化视图
- (void)initView {
    
    //扇形图layer
    _contentLayer = [CALayer layer];
    _contentLayer.frame = self.bounds;
    [self.layer addSublayer:_contentLayer];
    
    for (int i = 0; i < _modelArr.count; i++) {
        YXPicChartGraphicsModel *model = _modelArr[i];
        CGFloat star = _currentPercent;
        CGFloat end  = model.percent + star;
        CGFloat startAngle = -M_PI_2 + M_PI_2 *4 *star;
        CGFloat endAngle = M_PI_2 *4 *end - M_PI_2;
        
        //记录已绘制百分百
        _currentPercent += model.percent;
        
        //绘制
        [self createLayerWithStartAngle:startAngle endAngle:endAngle color:model.color model:model];
    }
}

#pragma mark - 懒加载
- (CABasicAnimation *)animation {
    
    if (!_animation) {
        _animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        _animation.duration = 1;
        _animation.fromValue = @(0);
        _animation.toValue = @(1);
        _animation.removedOnCompletion = NO;
        _animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    }
    return _animation;
}
- (CAShapeLayer *)maskLayer {
    
    if (!_maskLayer) {
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:_centerPoint radius:_radius startAngle:-M_PI_2 endAngle:M_PI_2 *3 clockwise:YES];
        
        _maskLayer = [CAShapeLayer layer];
        _maskLayer.path = path.CGPath;
        _maskLayer.fillColor = [UIColor clearColor].CGColor;
        _maskLayer.strokeColor = [UIColor blackColor].CGColor;
        _maskLayer.lineWidth = _width - _width /5;
    }
    return _maskLayer;
}
- (CAShapeLayer *)selLayer {
    
    if (!_selLayer) {
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:_centerPoint radius:_radius startAngle:-M_PI_2 endAngle:M_PI_2 *3 clockwise:YES];
        
        _selLayer = [CAShapeLayer layer];
        _selLayer.path = path.CGPath;
        _selLayer.fillColor = [UIColor clearColor].CGColor;
        _selLayer.strokeColor = [UIColor blackColor].CGColor;
        _selLayer.lineWidth = _radius /6;
        _selLayer.opacity = 0.4;
        [_contentLayer insertSublayer:_selLayer atIndex:0];
    }
    return _selLayer;
}

@end
