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
    
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[YXProbabilityManager sharedManager] allArr][4];//[[[YXProbabilityManager sharedManager] allArr] firstObject];
    NSMutableDictionary *lastSingleDic = [[NSMutableDictionary alloc] init];
    [[dic objectForKey:kValueArr] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        switch (idx) {
            case 0:
                [lastSingleDic setObject:[NSString stringWithFormat:@"%@", [obj objectForKey:kValue]] forKey:@"first"];
                break;
            case 1:
                [lastSingleDic setObject:[NSString stringWithFormat:@"%@", [obj objectForKey:kValue]] forKey:@"second"];
                break;
            case 2:
                [lastSingleDic setObject:[NSString stringWithFormat:@"%@", [obj objectForKey:kValue]] forKey:@"third"];
                break;
            case 3:
                [lastSingleDic setObject:[NSString stringWithFormat:@"%@", [obj objectForKey:kValue]] forKey:@"four"];
                break;
            case 4:
                [lastSingleDic setObject:[NSString stringWithFormat:@"%@", [obj objectForKey:kValue]] forKey:@"five"];
                break;
            case 5:
                [lastSingleDic setObject:[NSString stringWithFormat:@"%@", [obj objectForKey:kValue]] forKey:@"six"];
                break;
            case 6:
                [lastSingleDic setObject:[NSString stringWithFormat:@"%@", [obj objectForKey:kValue]] forKey:@"seven"];
                break;
            default:
                break;
        }
    }];
    //上一次数
    NSString *lastValue = [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@ %@", [lastSingleDic objectForKey:@"first"], [lastSingleDic objectForKey:@"second"], [lastSingleDic objectForKey:@"third"], [lastSingleDic objectForKey:@"four"], [lastSingleDic objectForKey:@"five"], [lastSingleDic objectForKey:@"six"], [lastSingleDic objectForKey:@"seven"]];
    
    NSArray *lastArr = [lastValue componentsSeparatedByString:@" "];
    __block NSInteger lastAmount = 0;
    __block NSInteger lastRedAmount = 0;
    [lastArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        NSInteger num = [obj integerValue];
        lastAmount += num;
        if (idx != lastArr.count - 1) {
            lastRedAmount += num;
        }
    }];
    //上一期数值之和字符串
    NSString *lastAmountStr = [NSString stringWithFormat:@"%@", @(lastAmount)];
    NSArray *nowRedArr = [self calculateSingleNum:lastRedAmount dic:lastSingleDic];
    
    NSMutableArray *minArr = [[NSMutableArray alloc] init];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        if ([[obj objectForKey:kPieChartLineGraphicsValue] integerValue] == 1) {
            //出现次数统计
            __block NSInteger count = 0;
            //包含红篮球的字符串
            NSString *bothValue = [obj objectForKey:kPieChartLineGraphicsName];
            //红蓝球单个数据拆分
            NSMutableDictionary *singleDic = [weakSelf getSingleValueByStr:bothValue];
            NSInteger first = [[singleDic objectForKey:@"first"] integerValue];
            NSInteger second = [[singleDic objectForKey:@"second"] integerValue];
            NSInteger third = [[singleDic objectForKey:@"third"] integerValue];
            NSInteger four = [[singleDic objectForKey:@"four"] integerValue];
            NSInteger five = [[singleDic objectForKey:@"five"] integerValue];
            NSInteger six = [[singleDic objectForKey:@"six"] integerValue];
            NSInteger seven = [[singleDic objectForKey:@"seven"] integerValue];

            //去除蓝球后的集合字符串
            NSString *value = [bothValue substringWithRange:NSMakeRange(0, bothValue.length - 2)];
            
            if ([value containsString:[NSString stringWithFormat:@"%@", @(first + second)]]) {
                count ++;
            }
            if ([value containsString:[NSString stringWithFormat:@"%@", @(six - five)]]) {
                count ++;//ok
            }
            if ([value containsString:[NSString stringWithFormat:@"%@", @(first + six)]]) {
                count ++;
            }
            if ([value containsString:[NSString stringWithFormat:@"%@", @(second + third)]]) {
                count ++;//ok
            }
            if ([value containsString:[NSString stringWithFormat:@"%@", @(first + 6)]]) {
                count ++;//ok
            }
            if ([value containsString:[NSString stringWithFormat:@"%@", @(six - first)]]) {
                count ++;//ok
            }
            if ([value containsString:[NSString stringWithFormat:@"%@", @(five - first)]]) {
                count ++;//ok
            }
            if ([value containsString:[NSString stringWithFormat:@"%@", @(six - second)]]) {
                count ++;
            }
            
            if ([value containsString:[NSString stringWithFormat:@"%@", @(20 - first)]]
                || [value containsString:[NSString stringWithFormat:@"%@", @(29 - seven)]] || [value containsString:[NSString stringWithFormat:@"%@", @(29 - first)]]) {
                count ++;//ok
            }
            
            //各位之和
            NSInteger lastSumOfAll = 0;
            for (NSInteger i = 0; i < lastAmountStr.length; i ++) {
                NSRange range = NSMakeRange(i, 1);//匹配得到的下标
                NSInteger sum = [[lastAmountStr substringWithRange:range] integerValue];
                lastSumOfAll += sum;
            }
            if ([value containsString:[NSString stringWithFormat:@"%@", @(lastSumOfAll)]]) {
                count ++;
            }
            if ([value containsString:[NSString stringWithFormat:@"%@", @(lastSumOfAll + [[lastSingleDic objectForKey:@"seven"] integerValue])]]) {
                count ++;//ok
            }
            if ([value containsString:[NSString stringWithFormat:@"%@", @(lastSumOfAll + [[lastSingleDic objectForKey:@"first"] integerValue])]]) {
                count ++;//ok
            }
            if ([value containsString:[NSString stringWithFormat:@"%@", @(first *3 /2)]]) {
                count ++;//ok
            }
            if ([value containsString:[NSString stringWithFormat:@"%@", @(33 - [[lastSingleDic objectForKey:@"seven"] integerValue])]]) {
                count ++;
            }
            if ([value containsString:[NSString stringWithFormat:@"%@", @(first + 5)]]) {
                count ++;//ok
            }
            if ([value containsString:[lastSingleDic objectForKey:@"seven"]]) {
                count ++;//ok
            }
            
            [nowRedArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               
                if ([value containsString:obj]) {
                    count ++;
                }
            }];
            
            if (count != 0) {
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{kPieChartLineGraphicsName:bothValue, kPieChartLineGraphicsValue:@(count)}];
                [minArr addObject:dic];
            }
        }
    }];
    
    NSMutableArray *sortMinArr = [[NSMutableArray alloc] initWithArray:[self sortingByArr:(NSArray *)minArr type:NSOrderedDescending]];
    
    return sortMinArr;
}

#pragma mark - 计算单个概率数
- (NSArray *)calculateSingleNum:(NSInteger)amount dic:(NSMutableDictionary *)dic {
    
    NSString *lastRedFirst = [NSString stringWithFormat:@"%@", @((amount - [[dic objectForKey:@"first"] integerValue]) /[[dic objectForKey:@"first"] integerValue])];
    NSString *lastRedSecond = [NSString stringWithFormat:@"%@", @((amount - [[dic objectForKey:@"second"] integerValue]) /[[dic objectForKey:@"second"] integerValue])];
    NSString *lastRedThird = [NSString stringWithFormat:@"%@", @((amount - [[dic objectForKey:@"third"] integerValue]) /[[dic objectForKey:@"third"] integerValue])];
    NSString *lastRedFour = [NSString stringWithFormat:@"%@", @((amount - [[dic objectForKey:@"four"] integerValue]) /[[dic objectForKey:@"four"] integerValue])];
    NSString *lastRedFive = [NSString stringWithFormat:@"%@", @((amount - [[dic objectForKey:@"five"] integerValue]) /[[dic objectForKey:@"five"] integerValue])];
    NSString *lastRedSix = [NSString stringWithFormat:@"%@", @((amount - [[dic objectForKey:@"six"] integerValue]) /[[dic objectForKey:@"six"] integerValue])];
    
    NSArray *arr = @[[lastRedFirst substringWithRange:NSMakeRange(lastRedFirst.length - 1, 1)], [lastRedSecond substringWithRange:NSMakeRange(lastRedSecond.length - 1, 1)], [lastRedThird substringWithRange:NSMakeRange(lastRedThird.length - 1, 1)], [lastRedFour substringWithRange:NSMakeRange(lastRedFour.length - 1, 1)], [lastRedFive substringWithRange:NSMakeRange(lastRedFive.length - 1, 1)], [lastRedSix substringWithRange:NSMakeRange(lastRedSix.length - 1, 1)], @"0"];
    
    NSMutableArray *endArr = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < arr.count; i ++) {
        for (NSInteger j = 0; j < arr.count; j ++) {
            NSString *combiningData = [NSString stringWithFormat:@"%@%@", arr[i], arr[j]];
            if ([combiningData integerValue] <= 33 && [combiningData integerValue] > 0) {
                [endArr addObject:combiningData];
            }
        }
    }
    endArr = [self statisticalRepeatNum:endArr];
    NSArray *valueArr = [self sortingByArr:(NSArray *)endArr type:NSOrderedDescending];
    
    return valueArr;
}

#pragma mark - 取出单个数值
- (NSMutableDictionary *)getSingleValueByStr:(NSString *)str {
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    NSArray *singleArr = [str componentsSeparatedByString:@" "];
    [singleArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        switch (idx) {
            case 0:
                [dic setObject:[NSString stringWithFormat:@"%@", obj] forKey:@"first"];
                break;
            case 1:
                [dic setObject:[NSString stringWithFormat:@"%@", obj] forKey:@"second"];
                break;
            case 2:
                [dic setObject:[NSString stringWithFormat:@"%@", obj] forKey:@"third"];
                break;
            case 3:
                [dic setObject:[NSString stringWithFormat:@"%@", obj] forKey:@"four"];
                break;
            case 4:
                [dic setObject:[NSString stringWithFormat:@"%@", obj] forKey:@"five"];
                break;
            case 5:
                [dic setObject:[NSString stringWithFormat:@"%@", obj] forKey:@"six"];
                break;
            case 6:
                [dic setObject:[NSString stringWithFormat:@"%@", obj] forKey:@"seven"];
                break;
            default:
                break;
        }
    }];
    
    return dic;
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

#pragma mark - 去重
- (NSMutableArray *)statisticalRepeatNum:(NSMutableArray *)arr {
    
    NSMutableArray *amountArr = [[NSMutableArray alloc] init];
    NSCountedSet *countSet = [[NSCountedSet alloc] initWithArray:(NSArray *)arr];
    for (id item in countSet) { //去重并统计
//        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//        [dic setObject:item forKey:kPieChartLineGraphicsName];
//        [dic setObject:@([countSet countForObject:item]) forKey:kPieChartLineGraphicsValue];
        [amountArr addObject:item];
    }
    
    return amountArr;
}

#pragma mark - 去重并统计重复的数
- (NSMutableArray *)fiveStatisticalRepeatNum:(NSMutableArray *)arr {
    
    NSMutableArray *amountArr = [[NSMutableArray alloc] init];

    NSCountedSet *countSet = [[NSCountedSet alloc] initWithArray:(NSArray *)arr];
    for (id item in countSet) { //去重并统计
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:item forKey:kPieChartLineGraphicsName];
        [dic setObject:@([countSet countForObject:item]) forKey:kPieChartLineGraphicsValue];
        [amountArr addObject:dic];
    }
    
    return amountArr;
}


@end
