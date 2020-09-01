//
//  YXMinArrAssemblyMananger.m
//  YXProbabilityTest
//
//  Created by ios on 2020/9/1.
//  Copyright © 2020 August. All rights reserved.
//

#import "YXMinArrAssemblyMananger.h"
#import "YXProbabilityManager.h"
#import "YXProbabilityListModel.h"
#import "YXPieChartLineGraphicsModel.h"

@implementation YXMinArrAssemblyMananger

+ (instancetype)sharedManager {
    
    static dispatch_once_t assemblyManangerOnceToken;
    static YXMinArrAssemblyMananger *instance;
    dispatch_once(&assemblyManangerOnceToken, ^{
        
        instance = [[YXMinArrAssemblyMananger alloc] init];
    });
    return instance;
}

#pragma mark - 组装规律数据
- (NSMutableArray *)assemblyRegularValueByArr:(NSArray *)arr {
    
    NSDictionary *dic = [[YXProbabilityManager sharedManager] allArr][1];//[[[YXProbabilityManager sharedManager] allArr] firstObject];
    __block NSString *first; __block NSString *second; __block NSString *third; __block NSString *four; __block NSString *five; __block NSString *sex; __block NSString *seven;
    [[dic objectForKey:kValueArr] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        switch (idx) {
            case 0:
                first = [NSString stringWithFormat:@"%@", [obj objectForKey:kValue]];
                break;
            case 1:
                second = [NSString stringWithFormat:@"%@", [obj objectForKey:kValue]];
                break;
            case 2:
                third = [NSString stringWithFormat:@"%@", [obj objectForKey:kValue]];
                break;
            case 3:
                four = [NSString stringWithFormat:@"%@", [obj objectForKey:kValue]];
                break;
            case 4:
                five = [NSString stringWithFormat:@"%@", [obj objectForKey:kValue]];
                break;
            case 5:
                sex = [NSString stringWithFormat:@"%@", [obj objectForKey:kValue]];
                break;
            case 6:
                seven = [NSString stringWithFormat:@"%@", [obj objectForKey:kValue]];
                break;
            default:
                break;
        }
    }];
    NSString *lastValue = [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@ %@", first, second, third, four, five, sex, seven];
    
    NSMutableArray *minArr = [[NSMutableArray alloc] init];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        NSInteger count = 0;
        NSString *bothValue = [obj objectForKey:kPieChartLineGraphicsName];
        NSString *value = [bothValue substringWithRange:NSMakeRange(0, bothValue.length - 2)];
#pragma mark - 20
        if (([lastValue containsString:@"20"] && [value containsString:@"10"])
            || ([lastValue containsString:@"20"] && [value containsString:@"30"])) {
            count ++;
        }
        if (([value containsString:@"20"] && [value containsString:@"18"])
            || ([value containsString:@"20"] && [value containsString:@"22"])) {
            count ++;
        }
#pragma mark - 11
        if (([value containsString:@"11"] && [value containsString:@"04"])
            || ([value containsString:@"11"] && [value containsString:@"07"])
            || ([value containsString:@"11"] && [value containsString:@"17"])
            || ([value containsString:@"11"] && [value containsString:@"19"])) {
            count ++;
        }
#pragma mark - 17
        if ([value containsString:@"17"] && [value containsString:@"7"]) {
            count ++;
        }
        if (([lastValue containsString:@"17"] && [value containsString:@"16"])
            || ([lastValue containsString:@"17"] && [value containsString:@"18"])) {
            count ++;
        }
#pragma mark - 09
        if (([value containsString:@"09"] && [value containsString:@"14"])
            || ([value containsString:@"09"] && [value containsString:@"12"])
            || ([value containsString:@"09"] && [value containsString:@"19"])
            || ([value containsString:@"09"] && [value containsString:@"29"])) {
            count ++;
        }
        if (([lastValue containsString:@"09"] && [value containsString:@"14"])
            || ([lastValue containsString:@"09"] && [value containsString:@"07"])
            || ([lastValue containsString:@"09"] && [value containsString:@"21"])) {
            count ++;
        }
#pragma mark - 23
        if ([lastValue containsString:@"23"]
            && ([value containsString:@"16"] || [value containsString:@"24"])) {
            count ++;
        }
        if (([value containsString:@"23"] && [value containsString:@"08"])
            || ([value containsString:@"23"] && [value containsString:@"07"])) {
            count ++;
        }
        if ([lastValue containsString:@"23"]
            && ([value containsString:@"16"] || [value containsString:@"24"])) {
            count ++;
        }
#pragma mark - 28
        if ([lastValue containsString:@"28"]
            && ([value containsString:@"19"]
                || [value containsString:@"25"]
                || [value containsString:@"31"])) {
            count ++;
        }
        if ([value containsString:@"28"] && [value containsString:@"31"]) {
            count ++;
        }
#pragma mark - 07
        if (([value containsString:@"07"] && [value containsString:@"04"])
            || ([value containsString:@"07"] && [value containsString:@"10"])
            || ([value containsString:@"07"] && [value containsString:@"11"])
            || ([value containsString:@"07"] && [value containsString:@"14"])
            || ([value containsString:@"07"] && [value containsString:@"06"])
            || ([value containsString:@"07"] && [value containsString:@"08"])) {
            count ++;
        }
        if (([lastValue containsString:@"07"]
             && ([value containsString:@"14"]
                 || [value containsString:@"20"]))) {
            count ++;
        }
#pragma mark - 05
        if ([lastValue containsString:@"05"]
            && ([value containsString:@"5"]
                || [value containsString:@"08"])) {
            count ++;
        }
#pragma mark - 08
        if ([value containsString:@"08"]
            && ([value containsString:@"28"]
                || [value containsString:@"18"])) {
            count ++;
        }
        
        if (count != 0) {
            dic = [[NSMutableDictionary alloc] initWithDictionary:@{kPieChartLineGraphicsName:bothValue, kPieChartLineGraphicsValue:@(count)}];
            [minArr addObject:dic];
        }
    }];
    
    NSMutableArray *sortMinArr = [[NSMutableArray alloc] initWithArray:[self sortingByArr:(NSArray *)minArr type:NSOrderedDescending]];
    
    return minArr;
}

#pragma mark - 排序
- (NSArray *)sortingByArr:(NSArray *)arr type:(NSComparisonResult)type {
    
    NSArray *resultArray = [arr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        if ([obj1 isKindOfClass:[NSDictionary class]]) {
            NSNumber *number1 = [obj1 objectForKey:kPieChartLineGraphicsValue];
            NSNumber *number2 = [obj2 objectForKey:kPieChartLineGraphicsValue];
            
            NSComparisonResult result = [number1 compare:number2];
            
            return result == type;
        }
        else {
            NSNumber *number1 = @([obj1 integerValue]);
            NSNumber *number2 = @([obj2 integerValue]);
            
            NSComparisonResult result = [number1 compare:number2];
            
            return result == type;
        }
    }];
    return resultArray;
}

@end
