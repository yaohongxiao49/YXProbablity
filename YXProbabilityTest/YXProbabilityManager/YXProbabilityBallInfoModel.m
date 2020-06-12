//
//  YXProbabilityBallInfoModel.m
//  YXProbabilityTest
//
//  Created by ios on 2020/6/12.
//  Copyright © 2020 August. All rights reserved.
//

#import "YXProbabilityBallInfoModel.h"

@implementation YXProbabilityBallInfoModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    
    if (self) {
        _boolBlue = [[dic objectForKey:kBoolBlue] boolValue];
        _value = [dic objectForKey:kValue];
    }
    return self;
}

@end
