//
//  YXPieChartGraphicsView.h
//  YXGraphicsTest
//
//  Created by ios on 2020/6/12.
//  Copyright © 2020 August. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXPicChartGraphicsModel.h"

NS_ASSUME_NONNULL_BEGIN

@class YXPieChartGraphicsView;
@protocol YXPieChartGraphicsViewDelegate <NSObject>

- (void)yxPieChartGraphicsViewSelIndex:(YXPieChartGraphicsView *)pieChartGraphicsView index:(NSInteger)index;

@end

@interface YXPieChartGraphicsView : UIView

@property (nonatomic, weak) id<YXPieChartGraphicsViewDelegate> delegete;
/** 是否可点击 默认YES */
@property (nonatomic, assign) BOOL boolSel;
/** 是否有点击效果 默认YES */
@property (nonatomic, assign) BOOL boolSelAnimation;

- (instancetype)initWithFrame:(CGRect)frame arr:(NSArray <YXPicChartGraphicsModel *>*)arr;

/** 刷新数据 */
- (void)reloadValueByArr:(NSArray <YXPicChartGraphicsModel *>*)arr;

/** 选中当前Index */
- (void)selCurrentIndex:(NSInteger)index;

/** 选择当前model */
- (void)selCurrentModel:(YXPicChartGraphicsModel *)model;

/** 重置动画 */
- (void)initAnimation;

/** 移除选中状态 */
- (void)removeSelStatus;

@end

NS_ASSUME_NONNULL_END
