//
//  YXPieChartLineGraphicsView.h
//  YXGraphicsTest
//
//  Created by ios on 2020/7/7.
//  Copyright © 2020 August. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXPieChartLineGraphicsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YXPieChartLineGraphicsView : UIView

/** 数据数组 */
@property (nonatomic, strong) NSMutableArray *dataSourceArr;

/** 标题 */
@property (nonatomic, copy) NSString *title;

/** 绘制 */
- (void)draw;

@end

NS_ASSUME_NONNULL_END
