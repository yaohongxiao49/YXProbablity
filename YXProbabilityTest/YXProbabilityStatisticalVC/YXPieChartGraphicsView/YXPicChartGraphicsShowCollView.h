//
//  YXPicChartGraphicsShowCollView.h
//  YXGraphicsTest
//
//  Created by ios on 2020/6/12.
//  Copyright © 2020 August. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^YXPicChartGraphicsShowCollViewBlock)(NSInteger index);

@interface YXPicChartGraphicsShowCollView : UIView

@property (nonatomic, strong) NSMutableArray *dataSourceArr;
@property (nonatomic, copy) YXPicChartGraphicsShowCollViewBlock yxPicChartGraphicsShowCollViewBlock;

@end

NS_ASSUME_NONNULL_END
