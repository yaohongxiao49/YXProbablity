//
//  YXProbabilityListModel.m
//  YXProbabilityTest
//
//  Created by ios on 2020/6/12.
//  Copyright © 2020 August. All rights reserved.
//

#import "YXProbabilityListModel.h"

@implementation YXProbabilityListModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    
    if (self) {
        _date = [dic objectForKey:kDate];
        
        _valueArr = [[NSMutableArray alloc] init];
        for (NSDictionary *dics in [dic objectForKey:kValueArr]) {
            YXProbabilityBallInfoModel *model = [[YXProbabilityBallInfoModel alloc] initWithDic:dics];
            [_valueArr addObject:model];
        }
    }
    return self;
}

@end

@implementation YXProbabilityListArrModel

+ (NSMutableArray *)arrayOfModelsFromDictionaries:(NSArray *)arr {
    
    NSMutableArray *dataAry = [NSMutableArray new];
    for (NSDictionary *dic in arr) {
        YXProbabilityListModel *model = [[YXProbabilityListModel alloc] initWithDic:dic];
        [dataAry addObject:model];
    }
    return dataAry;
}

@end
