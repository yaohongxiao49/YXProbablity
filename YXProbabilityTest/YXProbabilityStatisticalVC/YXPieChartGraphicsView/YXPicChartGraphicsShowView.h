//
//  YXPicChartGraphicsShowView.h
//  YXGraphicsTest
//
//  Created by ios on 2020/6/12.
//  Copyright © 2020 August. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXPieChartGraphicsView.h"

NS_ASSUME_NONNULL_BEGIN

@interface YXPicChartGraphicsShowView : UIView

@property (nonatomic, copy) NSArray *pieChartGraphicsArr;
- (instancetype)initWithFrame:(CGRect)frame arr:(nullable NSArray <YXPicChartGraphicsModel *>*)arr title:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
