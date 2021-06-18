//
//  YXProbabilityAllPossibleModel.m
//  YXProbabilityTest
//
//  Created by ios on 2021/6/18.
//  Copyright © 2021 August. All rights reserved.
//

#import "YXProbabilityAllPossibleModel.h"

@implementation YXProbabilityAllPossibleModel

+ (NSMutableArray *)arrayOfModelsFromDictionaries:(NSArray *)arr {
    
    NSMutableArray *dataAry = [NSMutableArray new];
    for (NSDictionary *dic in arr) {
        YXProbabilityAllPossibleModel *model = [[YXProbabilityAllPossibleModel alloc] initWithDic:dic];
        [dataAry addObject:model];
    }
    return dataAry;
}

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    
    if (self) {
        _item = [dic objectForKey:kAllItem];
        _fourCount = [[dic objectForKey:kFourCount] integerValue];
        _fiveCount = [[dic objectForKey:kFiveCount] integerValue];
        _sixCount = [[dic objectForKey:kSixCount] integerValue];
        _sevenCount = [[dic objectForKey:kSevenCount] integerValue];
    }
    return self;
}

@end
