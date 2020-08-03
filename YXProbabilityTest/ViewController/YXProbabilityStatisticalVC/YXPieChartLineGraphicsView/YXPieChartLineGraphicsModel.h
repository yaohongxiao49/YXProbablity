//
//  YXPieChartLineGraphicsModel.h
//  YXGraphicsTest
//
//  Created by ios on 2020/7/7.
//  Copyright © 2020 August. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define kPieChartLineGraphicsName @"PieChartLineGraphicsName"
#define kPieChartLineGraphicsValue @"PieChartLineGraphicsValue"

NS_ASSUME_NONNULL_BEGIN

@interface YXPieChartLineGraphicsModel : NSObject

/** 名称 */
@property (nonatomic, copy) NSString *name;
/** 指定数值 */
@property (nonatomic, assign) CGFloat value;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

@interface YXPieChartLineGraphicsArrModel : NSObject

+ (NSMutableArray *)arrayOfModelsFromDictionaries:(NSArray *)arr;

@end

NS_ASSUME_NONNULL_END
