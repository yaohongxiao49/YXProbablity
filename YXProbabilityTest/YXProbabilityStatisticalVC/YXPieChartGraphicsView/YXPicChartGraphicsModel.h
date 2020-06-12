//
//  YXPicChartGraphicsModel.h
//  YXGraphicsTest
//
//  Created by ios on 2020/6/12.
//  Copyright © 2020 August. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define kGraphicsTitle @"kGraphicsTitle"
#define kGraphicsDescript @"kGraphicsDescript"
#define kGraphicsCount @"kGraphicsCount"
#define kGraphicsPercent @"kGraphicsPercent"
#define kGraphicsColor @"kGraphicsColor"

@interface YXPicChartGraphicsModel : NSObject

/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 描述 */
@property (nonatomic, copy) NSString *descript;
/** 总数 */
@property (nonatomic, assign) CGFloat count;
/** 百分比 */
@property (nonatomic, assign) CGFloat percent;
/** 颜色 */
@property (nonatomic, strong) UIColor *color;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

@interface YXPicChartGraphicsArrModel : NSObject

+ (NSMutableArray *)arrayOfModelsFromDictionaries:(NSArray *)arr;

@end

NS_ASSUME_NONNULL_END
