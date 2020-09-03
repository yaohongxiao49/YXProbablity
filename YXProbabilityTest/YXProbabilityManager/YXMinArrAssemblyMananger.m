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
    NSDictionary *dic = [[YXProbabilityManager sharedManager] allArr][3];//[[[YXProbabilityManager sharedManager] allArr] firstObject];
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
    //被杀红球（依据上一期）
    NSDictionary *killRedBallByLastDic = [self killRedBallByLastDic:lastSingleDic lastAmount:lastAmountStr];
    //被杀蓝球（依据上一期）
    NSDictionary *killBlueBallByLastDic = [self killBlueBallByLastDic:lastSingleDic];
    
    NSMutableArray *minArr = [[NSMutableArray alloc] init];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
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
        NSString *blueValue = [bothValue substringWithRange:NSMakeRange(bothValue.length - 2, 2)];
        __block BOOL boolContain = NO;
        [nowRedArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([value containsString:obj]) {
                boolContain = YES;
            }
        }];
        
        if (([[lastSingleDic objectForKey:@"first"] integerValue] < 17
             || [[lastSingleDic objectForKey:@"second"] integerValue] < 17
             || [[lastSingleDic objectForKey:@"third"] integerValue] < 17
             || [[lastSingleDic objectForKey:@"four"] integerValue] < 17
             || [[lastSingleDic objectForKey:@"five"] integerValue] < 17
             || [[lastSingleDic objectForKey:@"six"] integerValue] < 17)
            && ([blueValue integerValue] == [[lastSingleDic objectForKey:@"first"] integerValue]
                || [blueValue integerValue] == [[lastSingleDic objectForKey:@"second"] integerValue]
                || [blueValue integerValue] == [[lastSingleDic objectForKey:@"third"] integerValue]
                || [blueValue integerValue] == [[lastSingleDic objectForKey:@"four"] integerValue]
                || [blueValue integerValue] == [[lastSingleDic objectForKey:@"five"] integerValue]
                || [blueValue integerValue] == [[lastSingleDic objectForKey:@"six"] integerValue])) {}
        else if (!boolContain) {}
        else if ([value containsString:[killRedBallByLastDic objectForKey:@"1"]]
                 || [value containsString:[killRedBallByLastDic objectForKey:@"2"]]
                 || [value containsString:[killRedBallByLastDic objectForKey:@"3"]]
                 || [value containsString:[killRedBallByLastDic objectForKey:@"4"]]
                 || [[NSString stringWithFormat:@"%@", @(six)] containsString:[killRedBallByLastDic objectForKey:@"5"]]
//                 || [value containsString:[killRedBallByLastDic objectForKey:@"6"]]
//                 || [value containsString:[killRedBallByLastDic objectForKey:@"7"]]
//                 || [value containsString:[killRedBallByLastDic objectForKey:@"8"]]
////                 || [value containsString:[killRedBallByLastDic objectForKey:@"9"]]
////                 || [value containsString:[killRedBallByLastDic objectForKey:@"10"]]
////                 || [value containsString:[killRedBallByLastDic objectForKey:@"11"]]
//                 || [value containsString:[killRedBallByLastDic objectForKey:@"12"]]
////                 || [value containsString:[killRedBallByLastDic objectForKey:@"13"]]
////                 || [value containsString:[killRedBallByLastDic objectForKey:@"14"]]
//                 || [value containsString:[killRedBallByLastDic objectForKey:@"15"]]
//                 || [value containsString:[killRedBallByLastDic objectForKey:@"16"]]
                 || [value containsString:[killRedBallByLastDic objectForKey:@"17"]]
                 || [value containsString:[killRedBallByLastDic objectForKey:@"18"]]
                 ) {} //杀红
        else if ([blueValue containsString:[killBlueBallByLastDic objectForKey:@"1"]]
                 || [blueValue containsString:[killBlueBallByLastDic objectForKey:@"2"]]
                 || [blueValue containsString:[killBlueBallByLastDic objectForKey:@"3"]]
                 || [blueValue containsString:[killBlueBallByLastDic objectForKey:@"4"]]
                 || [blueValue containsString:[killBlueBallByLastDic objectForKey:@"5"]]
                 || [blueValue containsString:[killBlueBallByLastDic objectForKey:@"6"]]) {} //杀蓝
        else {
            [minArr addObject:bothValue];
        }
    }];
    
    
    
    NSMutableArray *sortMinArr = [[NSMutableArray alloc] initWithArray:[self sortingByArr:(NSArray *)minArr type:NSOrderedDescending]];
    
    return sortMinArr;
}

#pragma mark - 概率计算
#pragma mark - 单数概率计算
- (void)probabilityCalculation1ByArr:(NSMutableArray *)arr {
    
    NSString *amountStr = [arr componentsJoinedByString:@" "];
    NSArray *amountArr = [amountStr componentsSeparatedByString:@" "];
    NSMutableArray *amountMutableArr = [[NSMutableArray alloc] initWithArray:amountArr];
    NSMutableArray *singleAmountArr = [[NSMutableArray alloc] initWithArray:[self sortingByArr:(NSArray *)[self getStatisticalRepeatNum:amountMutableArr] type:NSOrderedDescending]];
}
#pragma mark - 多联数概率计算
- (void)probabilityCalculationByArr:(NSMutableArray *)arr count:(NSInteger)count {
    
    NSMutableArray *amountArr = [[NSMutableArray alloc] initWithArray:[self sortingByArr:(NSArray *)[self getStatisticalRepeatNum:arr] type:NSOrderedDescending]];
    NSLog(@"count == %@, amountArr == %@", count, arr)
}

#pragma mark - 依据上一期杀红蓝
#pragma mark - 杀红
- (NSDictionary *)killRedBallByLastDic:(NSMutableDictionary *)dic lastAmount:(NSString *)lastAmount {
    
    NSInteger lastRedFirst = [[dic objectForKey:@"first"] integerValue];
    NSInteger lastRedSecond = [[dic objectForKey:@"second"] integerValue];
    NSInteger lastRedThird = [[dic objectForKey:@"third"] integerValue];
    NSInteger lastRedFour = [[dic objectForKey:@"four"] integerValue];
    NSInteger lastRedFive = [[dic objectForKey:@"five"] integerValue];
    NSInteger lastRedSix = [[dic objectForKey:@"six"] integerValue];
    NSInteger lastBlueSeven = [[dic objectForKey:@"seven"] integerValue];
    
    NSArray *arr = @[@(lastRedFirst), @(lastRedSecond), @(lastRedThird), @(lastRedFour), @(lastRedFive), @(lastRedSix)];
    //奇数数组
    NSMutableArray *oddArr = [[NSMutableArray alloc] init];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj integerValue] %2 != 0) { //奇数
            [oddArr addObject:obj];
        }
    }];
    
    NSArray *oddSortArr = [self sortingByArr:(NSArray *)oddArr type:NSOrderedDescending];
    NSInteger smallOdd = [[oddSortArr firstObject] integerValue];
    NSInteger bigOdd = [[oddSortArr lastObject] integerValue];
    
#pragma mark - 1、红球杀号
    NSString *red1 = [NSString stringWithFormat:@"%@", @(floor((bigOdd + smallOdd) /2))];
#pragma mark - 2、红球杀号
    NSInteger endRed2Num = lastRedSecond + lastRedFive;
    NSString *red2 = [NSString stringWithFormat:@"%@", @(endRed2Num >= 33 ? endRed2Num - 33 : endRed2Num)];
#pragma mark - 3、红球杀号
    NSString *red3 = [NSString stringWithFormat:@"%@", @(lastRedFirst + 2)];
#pragma mark - 4、红球杀号
    NSInteger endRed4Num = lastRedFirst + lastRedSecond;
    NSString *red4 = [NSString stringWithFormat:@"%@", @(endRed4Num >= 33 ? endRed4Num - 33 : endRed4Num)];
#pragma mark - 5、红球杀号
    NSString *endRed5Num = [NSString stringWithFormat:@"%@", @(lastRedSix - lastRedFive)];;
    NSString *red5 = [endRed5Num substringWithRange:NSMakeRange(endRed5Num.length - 1, 1)];
    
#pragma mark - (可能是依据当前期)
#pragma mark - 6、红球杀号
    NSString *red6 = [NSString stringWithFormat:@"%@", @(29 - lastBlueSeven)];
#pragma mark - 7、红球杀号
    NSString *red7 = [NSString stringWithFormat:@"%@", @(29 - lastRedFirst)];
#pragma mark - 8、红球杀号
    NSString *red8 = [NSString stringWithFormat:@"%@", @(lastRedFirst + lastRedSecond)];
#pragma mark - 9、红球杀号
    NSString *red9 = [NSString stringWithFormat:@"%@", @(lastBlueSeven)];
#pragma mark - 10、红球杀号
    NSString *red10 = [NSString stringWithFormat:@"%@", @(lastRedFirst + lastRedSix)];
#pragma mark - 11、红球杀号
    NSString *red11 = [NSString stringWithFormat:@"%@", @(lastRedSecond + lastRedThird)];
#pragma mark - 12、红球杀号
    NSInteger red12Amount = 0;
    for (NSInteger i = lastAmount.length; i > 0; i --) {
        red12Amount += [[lastAmount substringWithRange:NSMakeRange(lastAmount.length - i, 1)] integerValue];
    }
    NSString *red12 = [NSString stringWithFormat:@"%@", @(red12Amount)];
#pragma mark - 13、红球杀号
    NSInteger red13Amount = 0;
    for (NSInteger i = lastAmount.length; i > 0; i --) {
        red13Amount += [[lastAmount substringWithRange:NSMakeRange(lastAmount.length - i, 1)] integerValue];
    }
    NSString *red13 = [NSString stringWithFormat:@"%@", @(red13Amount + lastBlueSeven)];
#pragma mark - 14、红球杀号
    NSInteger red14Amount = 0;
    for (NSInteger i = lastAmount.length; i > 0; i --) {
        red14Amount += [[lastAmount substringWithRange:NSMakeRange(lastAmount.length - i, 1)] integerValue];
    }
    NSString *red14 = [NSString stringWithFormat:@"%@", @(red14Amount + lastRedFirst)];
#pragma mark - 15、红球杀号
    NSString *red15 = [NSString stringWithFormat:@"%@", @(lastRedFirst + 6)];
#pragma mark - 16、红球杀号
    NSString *red16 = [NSString stringWithFormat:@"%@", @(lastRedSix - lastRedSecond)];
#pragma mark - 17、红球杀号
    NSString *red17 = [NSString stringWithFormat:@"%@", @(lastRedFirst + 5)];
#pragma mark - 18、红球杀号
    NSString *red18 = [NSString stringWithFormat:@"%@", @((lastRedFirst + lastRedThird + lastRedFive) /2)];
    
    NSDictionary *killRedDic = @{@"1":red1, @"2":red2, @"3":red3, @"4":red4, @"5":red5, @"6":red6, @"7":red7, @"8":red8, @"9":red9, @"10":red10, @"11":red11, @"12":red12, @"13":red13, @"14":red14, @"15":red15, @"16":red16, @"17":red17, @"18":red18};
    return killRedDic;
}
#pragma mark - 杀蓝
- (NSDictionary *)killBlueBallByLastDic:(NSMutableDictionary *)dic {

#pragma mark - 1、蓝球杀号
    NSString *blue1 = [NSString stringWithFormat:@"%@", @(15 - [[dic objectForKey:@"seven"] integerValue])];
#pragma mark - 2、蓝球杀号
    NSString *blue2 = [NSString stringWithFormat:@"%@", @(19 - [[dic objectForKey:@"seven"] integerValue])];
#pragma mark - 3、蓝球杀号
    NSString *blue3 = [NSString stringWithFormat:@"%@", @(21 - [[dic objectForKey:@"seven"] integerValue])];
#pragma mark - 4、蓝球杀号
    NSString *blue4 = [NSString stringWithFormat:@"%@", @([[dic objectForKey:@"second"] integerValue] - [[dic objectForKey:@"first"] integerValue])];
#pragma mark - 5、蓝球杀号
    NSString *blue5 = [NSString stringWithFormat:@"%@", @([[dic objectForKey:@"six"] integerValue] - [[dic objectForKey:@"five"] integerValue])];
#pragma mark - 6、蓝球杀号
    NSString *blue6 = [NSString stringWithFormat:@"%@", @(17 - [[dic objectForKey:@"seven"] integerValue])];
    
    NSDictionary *killBlueDic = @{@"1":blue1, @"2":blue2, @"3":blue3, @"4":blue4, @"5":blue5, @"6":blue6};
    return killBlueDic;
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
        if ([countSet countForObject:item] > 1) {
            [amountArr addObject:item];
        }
    }
    
    return amountArr;
}

#pragma mark - 去重并统计重复的数
- (NSMutableArray *)getStatisticalRepeatNum:(NSMutableArray *)arr {
    
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
