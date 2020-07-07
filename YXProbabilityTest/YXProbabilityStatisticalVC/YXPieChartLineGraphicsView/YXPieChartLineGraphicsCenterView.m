//
//  YXPieChartLineGraphicsCenterView.m
//  YXGraphicsTest
//
//  Created by ios on 2020/7/7.
//  Copyright © 2020 August. All rights reserved.
//

#import "YXPieChartLineGraphicsCenterView.h"

@interface YXPieChartLineGraphicsCenterView ()

@property (nonatomic, strong) UIView *centerView;

@end

@implementation YXPieChartLineGraphicsCenterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.4];
        
        _centerView = [[UIView alloc] init];
        _centerView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_centerView];
        
        self.nameLab = [[UILabel alloc] init];
        self.nameLab.textColor = [UIColor colorWithRed:51 /255.0 green:51 /255.0 blue:51 /255.0 alpha:1];
        self.nameLab.font = [UIFont systemFontOfSize:18];
        
        self.nameLab.textAlignment = NSTextAlignmentCenter;
        [_centerView addSubview:self.nameLab];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.layer.cornerRadius = self.frame.size.width *0.5;
    self.layer.masksToBounds = true;
    
    _centerView.frame = CGRectMake(6, 6, self.frame.size.width - 6 *2, self.frame.size.height - 6 *2);
    _centerView.layer.cornerRadius = _centerView.frame.size.width *0.5;
    _centerView.layer.masksToBounds = true;
    
    self.nameLab.frame = _centerView.bounds;
}

@end
