//
//  YXPieChartLineGraphicsModel.m
//  YXGraphicsTest
//
//  Created by ios on 2020/7/7.
//  Copyright © 2020 August. All rights reserved.
//

#import "YXPieChartLineGraphicsModel.h"

@implementation YXPieChartLineGraphicsModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    
    if (self) {
        _name = [NSString stringWithFormat:@"%@", [dic objectForKey:kPieChartLineGraphicsName]];
        _value = [[dic objectForKey:kPieChartLineGraphicsValue] floatValue];
    }
    return self;
}

@end

@implementation YXPieChartLineGraphicsArrModel

+ (NSMutableArray *)arrayOfModelsFromDictionaries:(NSArray *)arr {
    
    NSMutableArray *dataArr = [NSMutableArray new];
    for (NSDictionary *dic in arr) {
        YXPieChartLineGraphicsModel *model = [[YXPieChartLineGraphicsModel alloc] initWithDic:dic];
        [dataArr addObject:model];
    }
    return dataArr;
}

@end
