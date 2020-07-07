//
//  YXPieChartLineGraphicsView.m
//  YXGraphicsTest
//
//  Created by ios on 2020/7/7.
//  Copyright © 2020 August. All rights reserved.
//

#import "YXPieChartLineGraphicsView.h"
#import "YXPieChartLineGraphicsCenterView.h"

#define kChartColor [UIColor colorWithRed:arc4random() %255 /255.0 green:arc4random() %255 /255.0 blue:arc4random() %255 /255.0 alpha:1.0]
#define kChartMargin 50

@interface YXPieChartLineGraphicsView ()

@property (nonatomic, strong) NSMutableArray *modelArr;
@property (nonatomic, strong) NSMutableArray *colorArr;

@end

@implementation YXPieChartLineGraphicsView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


#pragma mark - 绘制
- (void)draw {
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self setNeedsDisplay];
}

#pragma mark - 画布
- (void)drawRect:(CGRect)rect {
    
    CGFloat min = self.bounds.size.width > self.bounds.size.height ? self.bounds.size.height : self.bounds.size.width;
    
    CGPoint center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    CGFloat radius = min *0.5 - kChartMargin;
    CGFloat start = 0;
    CGFloat angle = 0;
    CGFloat end = start;
    
    if (self.dataSourceArr.count == 0) {
        end = start + M_PI *2;
        UIColor *color = kChartColor;
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:start endAngle:end clockwise:true];
        [color set];
        
        //添加一根线到圆心
        [path addLineToPoint:center];
        [path fill];
    }
    else {
        NSMutableArray *pointArr = [[NSMutableArray alloc] init];
        NSMutableArray *centerArr = [[NSMutableArray alloc] init];
        
        self.modelArr = [[NSMutableArray alloc] init];
        self.colorArr = [[NSMutableArray alloc] init];
        
        CGFloat sum = 0;
        for (YXPieChartLineGraphicsModel *model in self.dataSourceArr) {
            sum += model.value;
        }
        
        for (int i = 0; i < self.dataSourceArr.count; i++) {
            YXPieChartLineGraphicsModel *model = self.dataSourceArr[i];
            CGFloat percent = model.value /sum;
            UIColor *color = kChartColor;
            
            start = end;
            angle = percent *M_PI *2;
            end = start + angle;
            
            UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:start endAngle:end clockwise:true];
            [color set];
            
            //添加一根线到圆心
            [path addLineToPoint:center];
            [path fill];
            
            //获取弧度的中心角度
            CGFloat radianCenter = (start + end) *0.5;
        
            //获取指引线的起点
            CGFloat lineStartX = self.frame.size.width *0.5 + radius *cos(radianCenter);
            CGFloat lineStartY = self.frame.size.height *0.5 + radius *sin(radianCenter);
            
            CGPoint point = CGPointMake(lineStartX, lineStartY);
            
            if (i <= self.dataSourceArr.count /2 - 1) {
                [pointArr insertObject:[NSValue valueWithCGPoint:point] atIndex:0];
                [centerArr insertObject:[NSNumber numberWithFloat:radianCenter] atIndex:0];
                [self.modelArr insertObject:model atIndex:0];
                [self.colorArr insertObject:color atIndex:0];
            }
            else {
                [pointArr addObject:[NSValue valueWithCGPoint:point]];
                [centerArr addObject:[NSNumber numberWithFloat:radianCenter]];
                [self.modelArr addObject:model];
                [self.colorArr addObject:color];
            }
        }
        
        //通过pointArr绘制指引线
        [self drawLineWithPointArr:pointArr centerArr:centerArr];
    }
    
    //在中心添加label
    YXPieChartLineGraphicsCenterView *centerView = [[YXPieChartLineGraphicsCenterView alloc] init];
    centerView.frame = CGRectMake(0, 0, 80, 80);
    
    CGRect frame = centerView.frame;
    frame.origin = CGPointMake(self.frame.size.width *0.5 - frame.size.width *0.5, self.frame.size.height *0.5 - frame.size.width *0.5);
    centerView.frame = frame;
    centerView.nameLab.text = self.title;
    [self addSubview:centerView];
}

#pragma mark - 绘画指引线
- (void)drawLineWithPointArr:(NSArray *)pointArr centerArr:(NSArray *)centerArr {
    
    //记录每一个指引线包括数据所占用位置的和（总体位置）
    CGRect rect = CGRectZero;
    
    //用于计算指引线长度
    CGFloat width = self.bounds.size.width *0.5;
    
    CGFloat sum = 0;
    for (YXPieChartLineGraphicsModel *model in self.modelArr) {
        sum += model.value;
    }
    for (int i = 0; i < pointArr.count; i++) {
        //取出数据
        NSValue *value = pointArr[i];
        //每个圆弧中心点的位置
        CGPoint point = value.CGPointValue;
        //每个圆弧中心点的角度
        CGFloat radianCenter = [centerArr[i] floatValue];
        //颜色（绘制数据时要用）
        UIColor *color = self.colorArr[i];
        
        //模型数据（绘制数据时要用）
        YXPieChartLineGraphicsModel *model = self.modelArr[i];
        NSString *name = model.name;
        NSString *number = [NSString stringWithFormat:@"%.2f%%", (model.value /sum) *100];
        
        CGFloat showSingleWidth = (width /10 /2);
        CGFloat showDoubleWidth = (width /10);
        
        //圆弧中心点的x值和y值
        CGFloat x = point.x;
        CGFloat y = point.y;
        
        //指引线终点的位置（x, y）
        CGFloat startX = x + showSingleWidth *cos(radianCenter);
        CGFloat startY = y + showSingleWidth *sin(radianCenter);
        
        //指引线转折点的位置(x, y)
        CGFloat breakPointX = x + showDoubleWidth *cos(radianCenter);
        CGFloat breakPointY = y + showDoubleWidth *sin(radianCenter);
        
        //转折点到中心竖线的垂直长度（为什么+showDoubleWidth, 在实际做出的效果中，有的转折线很丑，+showDoubleWidth为了美化）
        CGFloat margin = fabs(width - breakPointX) + showDoubleWidth;
        
        //指引线长度
        CGFloat lineWidth = width - margin;
        
        //指引线起点（x, y）
        CGFloat endX;
        CGFloat endY;
        
        //绘制文字和数字时，所占的size（width和height）
        CGFloat numberWidth = lineWidth;
        CGFloat numberHeight = 15.f;
        
        CGFloat titleWidth = numberWidth;
        CGFloat titleHeight = numberHeight;
        
        //绘制文字和数字时的起始位置（x, y）与上面的合并起来就是frame
        CGFloat numberX;
        CGFloat numberY = breakPointY - numberHeight;
        
        CGFloat titleX = breakPointX;
        CGFloat titleY = breakPointY + 2;
        
        //文本段落属性(绘制文字和数字时需要)
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.alignment = NSTextAlignmentRight;
        
        //判断x位置，确定在指引线向左还是向右绘制
        //根据需要变更指引线的起始位置
        //变更文字和数字的位置
        if (x <= width) { //在左边
            endX = showSingleWidth;
            endY = breakPointY;
            paragraph.alignment = NSTextAlignmentLeft;
            numberX = endX;
            titleX = endX;
        }
        else { //在右边
            endX = self.bounds.size.width - showSingleWidth;
            endY = breakPointY;
            numberX = endX - numberWidth;
            titleX = endX - titleWidth;
        }
        
        if (i != 0) { // 当i!=0时，就需要计算位置总和(方法开始出的rect)与rect1(将进行绘制的位置)是否有重叠
            CGRect rect1 = CGRectMake(numberX, numberY, numberWidth, titleY + titleHeight - numberY);
            CGFloat margin = 0;
            if (CGRectIntersectsRect(rect, rect1)) { //通过计算让面积重叠的情况消除
                if (CGRectContainsRect(rect, rect1)) { //包含
                    if (i %self.dataSourceArr.count <= self.dataSourceArr.count *0.5 - 1) { //将要绘制的位置在总位置偏上
                        margin = CGRectGetMaxY(rect1) - rect.origin.y;
                        endY -= margin;
                    }
                    else { //将要绘制的位置在总位置偏下
                        margin = CGRectGetMaxY(rect) - rect1.origin.y;
                        endY += margin;
                    }
                }
                else { //相交
                    if (CGRectGetMaxY(rect1) > rect.origin.y && rect1.origin.y < rect.origin.y) { // 压在总位置上面
                        margin = CGRectGetMaxY(rect1) - rect.origin.y;
                        endY -= margin;
                    }
                    else if (rect1.origin.y < CGRectGetMaxY(rect) && rect1.origin.y < CGRectGetMaxY(rect)) { //压总位置下面
                        margin = CGRectGetMaxY(rect) - rect1.origin.y;
                        endY += margin;
                    }
                }
            }
            titleY = endY + 2;
            numberY = endY - numberHeight;
            
            //通过计算得出的将要绘制的位置
            CGRect rect2 = CGRectMake(numberX, numberY, numberWidth, titleY + titleHeight - numberY);
            //把新获得的rect和之前的rect合并
            if (numberX == rect.origin.x) { //当两个位置在同一侧的时候才需要合并
                if (rect2.origin.y < rect.origin.y) {
                    rect = CGRectMake(rect.origin.x, rect2.origin.y, rect.size.width, rect.size.height + rect2.size.height);
                }
                else {
                    rect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height + rect2.size.height);
                }
            }
        }
        else {
            rect = CGRectMake(numberX, numberY, numberWidth, titleY + titleHeight - numberY);
        }
        
        //重新制定转折点
        if (endX == showSingleWidth) {
            breakPointX = endX + lineWidth;
        }
        else {
            breakPointX = endX - lineWidth;
        }
        
        breakPointY = endY;
        
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(endX, endY)];
        [path addLineToPoint:CGPointMake(breakPointX, breakPointY)];
        [path addLineToPoint:CGPointMake(startX, startY)];
        
        CGContextSetLineWidth(ctx, 0.5);
        
        [color set];
        
        CGContextAddPath(ctx, path.CGPath);
        CGContextStrokePath(ctx);
        
        //在终点处添加点(小圆点)
        //movePoint，让转折线指向小圆点中心
        CGFloat movePoint = -2.5;
        
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = color;
        [self addSubview:view];
        CGRect rect = view.frame;
        rect.size = CGSizeMake(5, 5);
        rect.origin = CGPointMake(startX + movePoint, startY - 2.5);
        view.frame = rect;
        view.layer.cornerRadius = 2.5;
        view.layer.masksToBounds = true;
        
        //指引线上面的数字
        [name drawInRect:CGRectMake(numberX, numberY, numberWidth, numberHeight) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:9.0], NSForegroundColorAttributeName:color, NSParagraphStyleAttributeName:paragraph}];
        
        //指引线下面的title
        [number drawInRect:CGRectMake(titleX, titleY, titleWidth, titleHeight) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:9.0],NSForegroundColorAttributeName:color, NSParagraphStyleAttributeName:paragraph}];
        
    }
}

@end
