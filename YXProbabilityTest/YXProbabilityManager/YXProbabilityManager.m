//
//  YXProbabilityManager.m
//  YXProbabilityTest
//
//  Created by ios on 2020/6/12.
//  Copyright © 2020 August. All rights reserved.
//

#import "YXProbabilityManager.h"

@implementation YXProbabilityManager

+ (instancetype)sharedManager {
    
    static dispatch_once_t onceToken;
    static YXProbabilityManager *instance;
    dispatch_once(&onceToken, ^{
        
        instance = [[YXProbabilityManager alloc] init];
    });
    return instance;
}

#pragma mark - method
+ (NSString *)assemblyProbabilityArrByRandomCount:(NSInteger)randomCount valueSet:(id)valueSet probabilityArr:(NSArray *)probabilityArr boolRed:(BOOL)boolRed {
    
    if (probabilityArr.count == 0) {
        return @"";
    }
    if (boolRed) {
        __block NSInteger a = 0, b = 0, c = 0, d = 0, e = 0, f = 0, g = 0, h = 0, i = 0,
        j = 0, k = 0, l = 0, m = 0, n = 0, o = 0, p = 0, q = 0, r = 0, s = 0, t = 0,
        u = 0, v = 0, w = 0, x = 0, y = 0, z = 0, aa = 0, bb = 0, cc = 0, dd = 0,
        ee = 0, ff = 0, gg = 0;
        
        NSInteger index = arc4random() %100;
        __block NSInteger baseValue = 0;
        __block NSInteger probability = 0;
        
        [probabilityArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            probability = [[obj objectForKey:kProbability] integerValue];
            switch (idx) {
                case 0: { a = probability + baseValue; break; }
                case 1: { b = probability + baseValue; break; }
                case 2: { c = probability + baseValue; break; }
                case 3: { d = probability + baseValue; break; }
                case 4: { e = probability + baseValue; break; }
                case 5: { f = probability + baseValue; break; }
                case 6: { g = probability + baseValue; break; }
                case 7: { h = probability + baseValue; break; }
                case 8: { i = probability + baseValue; break; }
                case 9: { j = probability + baseValue; break; }
                case 10: { k = probability + baseValue; break; }
                case 11: { l = probability + baseValue; break; }
                case 12: { m = probability + baseValue; break; }
                case 13: { n = probability + baseValue; break; }
                case 14: { o = probability + baseValue; break; }
                case 15: { p = probability + baseValue; break; }
                case 16: { q = probability + baseValue; break; }
                case 17: { r = probability + baseValue; break; }
                case 18: { s = probability + baseValue; break; }
                case 19: { t = probability + baseValue; break; }
                case 20: { u = probability + baseValue; break; }
                case 21: { v = probability + baseValue; break; }
                case 22: { w = probability + baseValue; break; }
                case 23: { x = probability + baseValue; break; }
                case 24: { y = probability + baseValue; break; }
                case 25: { z = probability + baseValue; break; }
                case 26: { aa = probability + baseValue; break; }
                case 27: { bb = probability + baseValue; break; }
                case 28: { cc = probability + baseValue; break; }
                case 29: { dd = probability + baseValue; break; }
                case 30: { ee = probability + baseValue; break; }
                case 31: { ff = probability + baseValue; break; }
                case 32: { gg = probability + baseValue; break; }
                default:
                    break;
            }
            
            baseValue += probability;
        }];
        
        NSInteger tag = 0;
        if (index < a) {
            tag = 0;
        }
        else if (index >= a && index < b) {
            tag = 1;
        }
        else if (index >= b && index < c) {
            tag = 2;
        }
        else if (index >= c && index < d) {
            tag = 3;
        }
        else if (index >= d && index < e) {
            tag = 4;
        }
        else if (index >= e && index < f) {
            tag = 5;
        }
        else if (index >= f && index < g) {
            tag = 6;
        }
        else if (index >= g && index < h) {
            tag = 7;
        }
        else if (index >= h && index < i) {
            tag = 8;
        }
        else if (index >= i && index < j) {
            tag = 9;
        }
        else if (index >= j && index < k) {
            tag = 10;
        }
        else if (index >= k && index < l) {
            tag = 11;
        }
        else if (index >= l && index < m) {
            tag = 12;
        }
        else if (index >= m && index < n) {
            tag = 13;
        }
        else if (index >= n && index < o) {
            tag = 14;
        }
        else if (index >= o && index < p) {
            tag = 15;
        }
        else if (index >= p && index < q) {
            tag = 16;
        }
        else if (index >= q && index < r) {
            tag = 17;
        }
        else if (index >= r && index < s) {
            tag = 18;
        }
        else if (index >= s && index < t) {
            tag = 19;
        }
        else if (index >= t && index < u) {
            tag = 20;
        }
        else if (index >= u && index < v) {
            tag = 21;
        }
        else if (index >= v && index < w) {
            tag = 22;
        }
        else if (index >= w && index < x) {
            tag = 23;
        }
        else if (index >= x && index < y) {
            tag = 24;
        }
        else if (index >= y && index < z) {
            tag = 25;
        }
        else if (index >= z && index < aa) {
            tag = 26;
        }
        else if (index >= aa && index < bb) {
            tag = 27;
        }
        else if (index >= bb && index < cc) {
            tag = 28;
        }
        else if (index >= cc && index < dd) {
            tag = 29;
        }
        else if (index >= dd && index < ee) {
            tag = 30;
        }
        else if (index >= ee && index < ff) {
            tag = 31;
        }
        else if (index >= ff && index < gg) {
            tag = 32;
        }
        else {
            tag = arc4random() %(probabilityArr.count - 1);
        }
        
        NSString *red = [NSString stringWithFormat:@"%@", [probabilityArr[tag] objectForKey:kValue]];
        return red;
    }
    else {
        __block NSInteger a = 0, b = 0, c = 0, d = 0, e = 0, f = 0, g = 0, h = 0,
        i = 0, j = 0, k = 0, l = 0, m = 0, n = 0, o = 0, p = 0;
        
        NSInteger index = arc4random() %100;
        __block NSInteger baseValue = 0;
        __block NSInteger probability = 0;
        
        [probabilityArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
            probability = [[obj objectForKey:kProbability] integerValue];
            switch (idx) {
                case 0: { a = probability + baseValue; break; }
                case 1: { b = probability + baseValue; break; }
                case 2: { c = probability + baseValue; break; }
                case 3: { d = probability + baseValue; break; }
                case 4: { e = probability + baseValue; break; }
                case 5: { f = probability + baseValue; break; }
                case 6: { g = probability + baseValue; break; }
                case 7: { h = probability + baseValue; break; }
                case 8: { i = probability + baseValue; break; }
                case 9: { j = probability + baseValue; break; }
                case 10: { k = probability + baseValue; break; }
                case 11: { l = probability + baseValue; break; }
                case 12: { m = probability + baseValue; break; }
                case 13: { n = probability + baseValue; break; }
                case 14: { o = probability + baseValue; break; }
                case 15: { p = probability + baseValue; break; }
                default:
                    break;
            }
            
            baseValue += probability;
        }];
        
        NSInteger tag = 0;
        if (index < a) {
            tag = 0;
        }
        else if (index >= a && index < b) {
            tag = 1;
        }
        else if (index >= b && index < c) {
            tag = 2;
        }
        else if (index >= c && index < d) {
            tag = 3;
        }
        else if (index >= d && index < e) {
            tag = 4;
        }
        else if (index >= e && index < f) {
            tag = 5;
        }
        else if (index >= f && index < g) {
            tag = 6;
        }
        else if (index >= g && index < h) {
            tag = 7;
        }
        else if (index >= h && index < i) {
            tag = 8;
        }
        else if (index >= i && index < j) {
            tag = 9;
        }
        else if (index >= j && index < k) {
            tag = 10;
        }
        else if (index >= k && index < l) {
            tag = 11;
        }
        else if (index >= l && index < m) {
            tag = 12;
        }
        else if (index >= m && index < n) {
            tag = 13;
        }
        else if (index >= n && index < o) {
            tag = 14;
        }
        else if (index >= o && index < p) {
            tag = 15;
        }
        else {
            tag = arc4random() %(probabilityArr.count - 1);
        }
        
        NSString *blue = [NSString stringWithFormat:@"%@", [probabilityArr[tag] objectForKey:kValue]];
        [valueSet addObject:blue];
        return blue;
    }
}

#pragma mark - setting
- (void)setRandomListArr:(NSArray *)randomListArr {
    
    NSString *path = [NSString stringWithFormat:@"%@/%@", kYXToolLocalSaveDocDirectoryPath, kRandomListArr];
    [NSKeyedArchiver archiveRootObject:randomListArr toFile:path];
}
- (NSArray *)randomListArr {
    
    NSString *path = [NSString stringWithFormat:@"%@/%@", kYXToolLocalSaveDocDirectoryPath, kRandomListArr];
    NSArray *arr = [NSKeyedUnarchiver unarchiveObjectWithData:[NSData dataWithContentsOfFile:path]];
    return arr;
}
- (void)setProbablityRandomListArr:(NSArray *)probablityRandomListArr {
    
    NSString *path = [NSString stringWithFormat:@"%@/%@", kYXToolLocalSaveDocDirectoryPath, kProbablityRandomListArr];
    [NSKeyedArchiver archiveRootObject:probablityRandomListArr toFile:path];
}
- (NSArray *)probablityRandomListArr {
    
    NSString *path = [NSString stringWithFormat:@"%@/%@", kYXToolLocalSaveDocDirectoryPath, kProbablityRandomListArr];
    NSArray *arr = [NSKeyedUnarchiver unarchiveObjectWithData:[NSData dataWithContentsOfFile:path]];
    return arr;
}
- (void)setRealListArr:(NSArray *)realListArr {
    
    NSString *path = [NSString stringWithFormat:@"%@/%@", kYXToolLocalSaveDocDirectoryPath, kRealListArr];
    [NSKeyedArchiver archiveRootObject:realListArr toFile:path];
}
- (NSArray *)realListArr {
    
    NSString *path = [NSString stringWithFormat:@"%@/%@", kYXToolLocalSaveDocDirectoryPath, kRealListArr];
    NSArray *arr = [NSKeyedUnarchiver unarchiveObjectWithData:[NSData dataWithContentsOfFile:path]];
    return arr;
}
- (void)setProbabilityRedArr:(NSArray *)probabilityRedArr {
    
    NSString *path = [NSString stringWithFormat:@"%@/%@", kYXToolLocalSaveDocDirectoryPath, kProbabilityRedArr];
    [NSKeyedArchiver archiveRootObject:probabilityRedArr toFile:path];
}
- (NSArray *)probabilityRedArr {
    
    NSString *path = [NSString stringWithFormat:@"%@/%@", kYXToolLocalSaveDocDirectoryPath, kProbabilityRedArr];
    NSArray *arr = [NSKeyedUnarchiver unarchiveObjectWithData:[NSData dataWithContentsOfFile:path]];
    return arr;
}
- (void)setProbabilityBlueArr:(NSArray *)probabilityBlueArr {
    
    NSString *path = [NSString stringWithFormat:@"%@/%@", kYXToolLocalSaveDocDirectoryPath, kProbabilityBlueArr];
    [NSKeyedArchiver archiveRootObject:probabilityBlueArr toFile:path];
}
- (NSArray *)probabilityBlueArr {
    
    NSString *path = [NSString stringWithFormat:@"%@/%@", kYXToolLocalSaveDocDirectoryPath, kProbabilityBlueArr];
    NSArray *arr = [NSKeyedUnarchiver unarchiveObjectWithData:[NSData dataWithContentsOfFile:path]];
    return arr;
}

#pragma mark - 懒加载
- (NSMutableArray *)allArr {
    
    if (!_allArr) {
        _allArr = [[NSMutableArray alloc] init];
        NSMutableDictionary *dic;
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020059", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"02"},
                                                                        @{kBoolBlue:@(NO), kValue:@"04"},
                                                                        @{kBoolBlue:@(NO), kValue:@"10"},
                                                                        @{kBoolBlue:@(NO), kValue:@"17"},
                                                                        @{kBoolBlue:@(NO), kValue:@"22"},
                                                                        @{kBoolBlue:@(NO), kValue:@"25"},
                                                                        @{kBoolBlue:@(YES), kValue:@"14"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020058", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"01"},
                                                                        @{kBoolBlue:@(NO), kValue:@"03"},
                                                                        @{kBoolBlue:@(NO), kValue:@"11"},
                                                                        @{kBoolBlue:@(NO), kValue:@"12"},
                                                                        @{kBoolBlue:@(NO), kValue:@"19"},
                                                                        @{kBoolBlue:@(NO), kValue:@"26"},
                                                                        @{kBoolBlue:@(YES), kValue:@"07"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020057", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"09"},
                                                                        @{kBoolBlue:@(NO), kValue:@"14"},
                                                                        @{kBoolBlue:@(NO), kValue:@"21"},
                                                                        @{kBoolBlue:@(NO), kValue:@"23"},
                                                                        @{kBoolBlue:@(NO), kValue:@"26"},
                                                                        @{kBoolBlue:@(NO), kValue:@"32"},
                                                                        @{kBoolBlue:@(YES), kValue:@"03"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020056", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"02"},
                                                                        @{kBoolBlue:@(NO), kValue:@"05"},
                                                                        @{kBoolBlue:@(NO), kValue:@"08"},
                                                                        @{kBoolBlue:@(NO), kValue:@"12"},
                                                                        @{kBoolBlue:@(NO), kValue:@"26"},
                                                                        @{kBoolBlue:@(NO), kValue:@"31"},
                                                                        @{kBoolBlue:@(YES), kValue:@"14"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020055", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"01"},
                                                                        @{kBoolBlue:@(NO), kValue:@"05"},
                                                                        @{kBoolBlue:@(NO), kValue:@"07"},
                                                                        @{kBoolBlue:@(NO), kValue:@"23"},
                                                                        @{kBoolBlue:@(NO), kValue:@"28"},
                                                                        @{kBoolBlue:@(NO), kValue:@"30"},
                                                                        @{kBoolBlue:@(YES), kValue:@"12"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020054", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"03"},
                                                                        @{kBoolBlue:@(NO), kValue:@"10"},
                                                                        @{kBoolBlue:@(NO), kValue:@"19"},
                                                                        @{kBoolBlue:@(NO), kValue:@"25"},
                                                                        @{kBoolBlue:@(NO), kValue:@"26"},
                                                                        @{kBoolBlue:@(NO), kValue:@"31"},
                                                                        @{kBoolBlue:@(YES), kValue:@"02"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020053", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"02"},
                                                                        @{kBoolBlue:@(NO), kValue:@"14"},
                                                                        @{kBoolBlue:@(NO), kValue:@"15"},
                                                                        @{kBoolBlue:@(NO), kValue:@"16"},
                                                                        @{kBoolBlue:@(NO), kValue:@"32"},
                                                                        @{kBoolBlue:@(NO), kValue:@"33"},
                                                                        @{kBoolBlue:@(YES), kValue:@"01"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020052", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"02"},
                                                                        @{kBoolBlue:@(NO), kValue:@"08"},
                                                                        @{kBoolBlue:@(NO), kValue:@"13"},
                                                                        @{kBoolBlue:@(NO), kValue:@"29"},
                                                                        @{kBoolBlue:@(NO), kValue:@"32"},
                                                                        @{kBoolBlue:@(NO), kValue:@"33"},
                                                                        @{kBoolBlue:@(YES), kValue:@"15"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020051", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"03"},
                                                                        @{kBoolBlue:@(NO), kValue:@"06"},
                                                                        @{kBoolBlue:@(NO), kValue:@"08"},
                                                                        @{kBoolBlue:@(NO), kValue:@"11"},
                                                                        @{kBoolBlue:@(NO), kValue:@"19"},
                                                                        @{kBoolBlue:@(NO), kValue:@"28"},
                                                                        @{kBoolBlue:@(YES), kValue:@"08"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020050", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"04"},
                                                                        @{kBoolBlue:@(NO), kValue:@"09"},
                                                                        @{kBoolBlue:@(NO), kValue:@"17"},
                                                                        @{kBoolBlue:@(NO), kValue:@"20"},
                                                                        @{kBoolBlue:@(NO), kValue:@"32"},
                                                                        @{kBoolBlue:@(NO), kValue:@"33"},
                                                                        @{kBoolBlue:@(YES), kValue:@"15"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020049", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"01"},
                                                                        @{kBoolBlue:@(NO), kValue:@"07"},
                                                                        @{kBoolBlue:@(NO), kValue:@"09"},
                                                                        @{kBoolBlue:@(NO), kValue:@"12"},
                                                                        @{kBoolBlue:@(NO), kValue:@"18"},
                                                                        @{kBoolBlue:@(NO), kValue:@"22"},
                                                                        @{kBoolBlue:@(YES), kValue:@"04"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020048", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"12"},
                                                                        @{kBoolBlue:@(NO), kValue:@"14"},
                                                                        @{kBoolBlue:@(NO), kValue:@"18"},
                                                                        @{kBoolBlue:@(NO), kValue:@"23"},
                                                                        @{kBoolBlue:@(NO), kValue:@"30"},
                                                                        @{kBoolBlue:@(NO), kValue:@"32"},
                                                                        @{kBoolBlue:@(YES), kValue:@"02"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020047", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"04"},
                                                                        @{kBoolBlue:@(NO), kValue:@"10"},
                                                                        @{kBoolBlue:@(NO), kValue:@"17"},
                                                                        @{kBoolBlue:@(NO), kValue:@"19"},
                                                                        @{kBoolBlue:@(NO), kValue:@"28"},
                                                                        @{kBoolBlue:@(NO), kValue:@"32"},
                                                                        @{kBoolBlue:@(YES), kValue:@"01"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020046", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"13"},
                                                                        @{kBoolBlue:@(NO), kValue:@"19"},
                                                                        @{kBoolBlue:@(NO), kValue:@"25"},
                                                                        @{kBoolBlue:@(NO), kValue:@"26"},
                                                                        @{kBoolBlue:@(NO), kValue:@"27"},
                                                                        @{kBoolBlue:@(NO), kValue:@"32"},
                                                                        @{kBoolBlue:@(YES), kValue:@"08"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020045", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"02"},
                                                                        @{kBoolBlue:@(NO), kValue:@"03"},
                                                                        @{kBoolBlue:@(NO), kValue:@"15"},
                                                                        @{kBoolBlue:@(NO), kValue:@"21"},
                                                                        @{kBoolBlue:@(NO), kValue:@"22"},
                                                                        @{kBoolBlue:@(NO), kValue:@"33"},
                                                                        @{kBoolBlue:@(YES), kValue:@"16"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020044", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"07"},
                                                                        @{kBoolBlue:@(NO), kValue:@"08"},
                                                                        @{kBoolBlue:@(NO), kValue:@"16"},
                                                                        @{kBoolBlue:@(NO), kValue:@"17"},
                                                                        @{kBoolBlue:@(NO), kValue:@"19"},
                                                                        @{kBoolBlue:@(NO), kValue:@"24"},
                                                                        @{kBoolBlue:@(YES), kValue:@"07"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020043", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"01"},
                                                                        @{kBoolBlue:@(NO), kValue:@"11"},
                                                                        @{kBoolBlue:@(NO), kValue:@"24"},
                                                                        @{kBoolBlue:@(NO), kValue:@"25"},
                                                                        @{kBoolBlue:@(NO), kValue:@"27"},
                                                                        @{kBoolBlue:@(NO), kValue:@"30"},
                                                                        @{kBoolBlue:@(YES), kValue:@"07"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020042", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"02"},
                                                                        @{kBoolBlue:@(NO), kValue:@"06"},
                                                                        @{kBoolBlue:@(NO), kValue:@"07"},
                                                                        @{kBoolBlue:@(NO), kValue:@"11"},
                                                                        @{kBoolBlue:@(NO), kValue:@"14"},
                                                                        @{kBoolBlue:@(NO), kValue:@"31"},
                                                                        @{kBoolBlue:@(YES), kValue:@"03"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020041", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"06"},
                                                                        @{kBoolBlue:@(NO), kValue:@"07"},
                                                                        @{kBoolBlue:@(NO), kValue:@"16"},
                                                                        @{kBoolBlue:@(NO), kValue:@"22"},
                                                                        @{kBoolBlue:@(NO), kValue:@"24"},
                                                                        @{kBoolBlue:@(NO), kValue:@"25"},
                                                                        @{kBoolBlue:@(YES), kValue:@"13"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020040", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"01"},
                                                                        @{kBoolBlue:@(NO), kValue:@"06"},
                                                                        @{kBoolBlue:@(NO), kValue:@"12"},
                                                                        @{kBoolBlue:@(NO), kValue:@"16"},
                                                                        @{kBoolBlue:@(NO), kValue:@"19"},
                                                                        @{kBoolBlue:@(NO), kValue:@"21"},
                                                                        @{kBoolBlue:@(YES), kValue:@"04"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020039", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"02"},
                                                                        @{kBoolBlue:@(NO), kValue:@"09"},
                                                                        @{kBoolBlue:@(NO), kValue:@"10"},
                                                                        @{kBoolBlue:@(NO), kValue:@"11"},
                                                                        @{kBoolBlue:@(NO), kValue:@"16"},
                                                                        @{kBoolBlue:@(NO), kValue:@"29"},
                                                                        @{kBoolBlue:@(YES), kValue:@"02"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020038", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"01"},
                                                                        @{kBoolBlue:@(NO), kValue:@"06"},
                                                                        @{kBoolBlue:@(NO), kValue:@"07"},
                                                                        @{kBoolBlue:@(NO), kValue:@"18"},
                                                                        @{kBoolBlue:@(NO), kValue:@"23"},
                                                                        @{kBoolBlue:@(NO), kValue:@"24"},
                                                                        @{kBoolBlue:@(YES), kValue:@"15"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020037", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"01"},
                                                                        @{kBoolBlue:@(NO), kValue:@"04"},
                                                                        @{kBoolBlue:@(NO), kValue:@"11"},
                                                                        @{kBoolBlue:@(NO), kValue:@"13"},
                                                                        @{kBoolBlue:@(NO), kValue:@"17"},
                                                                        @{kBoolBlue:@(NO), kValue:@"24"},
                                                                        @{kBoolBlue:@(YES), kValue:@"15"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020036", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"07"},
                                                                        @{kBoolBlue:@(NO), kValue:@"09"},
                                                                        @{kBoolBlue:@(NO), kValue:@"16"},
                                                                        @{kBoolBlue:@(NO), kValue:@"22"},
                                                                        @{kBoolBlue:@(NO), kValue:@"24"},
                                                                        @{kBoolBlue:@(NO), kValue:@"32"},
                                                                        @{kBoolBlue:@(YES), kValue:@"06"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020035", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"10"},
                                                                        @{kBoolBlue:@(NO), kValue:@"14"},
                                                                        @{kBoolBlue:@(NO), kValue:@"24"},
                                                                        @{kBoolBlue:@(NO), kValue:@"25"},
                                                                        @{kBoolBlue:@(NO), kValue:@"28"},
                                                                        @{kBoolBlue:@(NO), kValue:@"33"},
                                                                        @{kBoolBlue:@(YES), kValue:@"11"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020034", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"02"},
                                                                        @{kBoolBlue:@(NO), kValue:@"08"},
                                                                        @{kBoolBlue:@(NO), kValue:@"15"},
                                                                        @{kBoolBlue:@(NO), kValue:@"16"},
                                                                        @{kBoolBlue:@(NO), kValue:@"26"},
                                                                        @{kBoolBlue:@(NO), kValue:@"32"},
                                                                        @{kBoolBlue:@(YES), kValue:@"03"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020033", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"07"},
                                                                        @{kBoolBlue:@(NO), kValue:@"10"},
                                                                        @{kBoolBlue:@(NO), kValue:@"12"},
                                                                        @{kBoolBlue:@(NO), kValue:@"21"},
                                                                        @{kBoolBlue:@(NO), kValue:@"31"},
                                                                        @{kBoolBlue:@(NO), kValue:@"32"},
                                                                        @{kBoolBlue:@(YES), kValue:@"01"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020032", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"03"},
                                                                        @{kBoolBlue:@(NO), kValue:@"11"},
                                                                        @{kBoolBlue:@(NO), kValue:@"13"},
                                                                        @{kBoolBlue:@(NO), kValue:@"14"},
                                                                        @{kBoolBlue:@(NO), kValue:@"15"},
                                                                        @{kBoolBlue:@(NO), kValue:@"26"},
                                                                        @{kBoolBlue:@(YES), kValue:@"13"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020031", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"02"},
                                                                        @{kBoolBlue:@(NO), kValue:@"05"},
                                                                        @{kBoolBlue:@(NO), kValue:@"09"},
                                                                        @{kBoolBlue:@(NO), kValue:@"15"},
                                                                        @{kBoolBlue:@(NO), kValue:@"16"},
                                                                        @{kBoolBlue:@(NO), kValue:@"27"},
                                                                        @{kBoolBlue:@(YES), kValue:@"09"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020030", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"17"},
                                                                        @{kBoolBlue:@(NO), kValue:@"18"},
                                                                        @{kBoolBlue:@(NO), kValue:@"21"},
                                                                        @{kBoolBlue:@(NO), kValue:@"29"},
                                                                        @{kBoolBlue:@(NO), kValue:@"30"},
                                                                        @{kBoolBlue:@(NO), kValue:@"32"},
                                                                        @{kBoolBlue:@(YES), kValue:@"03"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020029", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"01"},
                                                                        @{kBoolBlue:@(NO), kValue:@"12"},
                                                                        @{kBoolBlue:@(NO), kValue:@"18"},
                                                                        @{kBoolBlue:@(NO), kValue:@"20"},
                                                                        @{kBoolBlue:@(NO), kValue:@"30"},
                                                                        @{kBoolBlue:@(NO), kValue:@"32"},
                                                                        @{kBoolBlue:@(YES), kValue:@"05"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020028", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"05"},
                                                                        @{kBoolBlue:@(NO), kValue:@"06"},
                                                                        @{kBoolBlue:@(NO), kValue:@"15"},
                                                                        @{kBoolBlue:@(NO), kValue:@"18"},
                                                                        @{kBoolBlue:@(NO), kValue:@"26"},
                                                                        @{kBoolBlue:@(NO), kValue:@"32"},
                                                                        @{kBoolBlue:@(YES), kValue:@"08"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020027", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"12"},
                                                                        @{kBoolBlue:@(NO), kValue:@"13"},
                                                                        @{kBoolBlue:@(NO), kValue:@"14"},
                                                                        @{kBoolBlue:@(NO), kValue:@"24"},
                                                                        @{kBoolBlue:@(NO), kValue:@"25"},
                                                                        @{kBoolBlue:@(NO), kValue:@"28"},
                                                                        @{kBoolBlue:@(YES), kValue:@"06"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020026", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"01"},
                                                                        @{kBoolBlue:@(NO), kValue:@"04"},
                                                                        @{kBoolBlue:@(NO), kValue:@"09"},
                                                                        @{kBoolBlue:@(NO), kValue:@"18"},
                                                                        @{kBoolBlue:@(NO), kValue:@"19"},
                                                                        @{kBoolBlue:@(NO), kValue:@"31"},
                                                                        @{kBoolBlue:@(YES), kValue:@"06"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020025", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"01"},
                                                                        @{kBoolBlue:@(NO), kValue:@"09"},
                                                                        @{kBoolBlue:@(NO), kValue:@"10"},
                                                                        @{kBoolBlue:@(NO), kValue:@"15"},
                                                                        @{kBoolBlue:@(NO), kValue:@"20"},
                                                                        @{kBoolBlue:@(NO), kValue:@"29"},
                                                                        @{kBoolBlue:@(YES), kValue:@"02"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020024", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"10"},
                                                                        @{kBoolBlue:@(NO), kValue:@"13"},
                                                                        @{kBoolBlue:@(NO), kValue:@"27"},
                                                                        @{kBoolBlue:@(NO), kValue:@"28"},
                                                                        @{kBoolBlue:@(NO), kValue:@"29"},
                                                                        @{kBoolBlue:@(NO), kValue:@"31"},
                                                                        @{kBoolBlue:@(YES), kValue:@"08"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020023", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"04"},
                                                                        @{kBoolBlue:@(NO), kValue:@"05"},
                                                                        @{kBoolBlue:@(NO), kValue:@"20"},
                                                                        @{kBoolBlue:@(NO), kValue:@"21"},
                                                                        @{kBoolBlue:@(NO), kValue:@"30"},
                                                                        @{kBoolBlue:@(NO), kValue:@"33"},
                                                                        @{kBoolBlue:@(YES), kValue:@"08"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020022", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"02"},
                                                                        @{kBoolBlue:@(NO), kValue:@"10"},
                                                                        @{kBoolBlue:@(NO), kValue:@"20"},
                                                                        @{kBoolBlue:@(NO), kValue:@"22"},
                                                                        @{kBoolBlue:@(NO), kValue:@"25"},
                                                                        @{kBoolBlue:@(NO), kValue:@"30"},
                                                                        @{kBoolBlue:@(YES), kValue:@"02"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020021", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"02"},
                                                                        @{kBoolBlue:@(NO), kValue:@"06"},
                                                                        @{kBoolBlue:@(NO), kValue:@"14"},
                                                                        @{kBoolBlue:@(NO), kValue:@"16"},
                                                                        @{kBoolBlue:@(NO), kValue:@"27"},
                                                                        @{kBoolBlue:@(NO), kValue:@"31"},
                                                                        @{kBoolBlue:@(YES), kValue:@"07"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020020", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"01"},
                                                                        @{kBoolBlue:@(NO), kValue:@"06"},
                                                                        @{kBoolBlue:@(NO), kValue:@"09"},
                                                                        @{kBoolBlue:@(NO), kValue:@"13"},
                                                                        @{kBoolBlue:@(NO), kValue:@"15"},
                                                                        @{kBoolBlue:@(NO), kValue:@"22"},
                                                                        @{kBoolBlue:@(YES), kValue:@"14"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020019", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"15"},
                                                                        @{kBoolBlue:@(NO), kValue:@"19"},
                                                                        @{kBoolBlue:@(NO), kValue:@"27"},
                                                                        @{kBoolBlue:@(NO), kValue:@"28"},
                                                                        @{kBoolBlue:@(NO), kValue:@"30"},
                                                                        @{kBoolBlue:@(NO), kValue:@"33"},
                                                                        @{kBoolBlue:@(YES), kValue:@"03"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020018", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"05"},
                                                                        @{kBoolBlue:@(NO), kValue:@"07"},
                                                                        @{kBoolBlue:@(NO), kValue:@"08"},
                                                                        @{kBoolBlue:@(NO), kValue:@"11"},
                                                                        @{kBoolBlue:@(NO), kValue:@"17"},
                                                                        @{kBoolBlue:@(NO), kValue:@"22"},
                                                                        @{kBoolBlue:@(YES), kValue:@"13"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020017", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"02"},
                                                                        @{kBoolBlue:@(NO), kValue:@"04"},
                                                                        @{kBoolBlue:@(NO), kValue:@"07"},
                                                                        @{kBoolBlue:@(NO), kValue:@"15"},
                                                                        @{kBoolBlue:@(NO), kValue:@"20"},
                                                                        @{kBoolBlue:@(NO), kValue:@"27"},
                                                                        @{kBoolBlue:@(YES), kValue:@"04"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020016", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"05"},
                                                                        @{kBoolBlue:@(NO), kValue:@"06"},
                                                                        @{kBoolBlue:@(NO), kValue:@"08"},
                                                                        @{kBoolBlue:@(NO), kValue:@"17"},
                                                                        @{kBoolBlue:@(NO), kValue:@"24"},
                                                                        @{kBoolBlue:@(NO), kValue:@"27"},
                                                                        @{kBoolBlue:@(YES), kValue:@"07"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020015", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"08"},
                                                                        @{kBoolBlue:@(NO), kValue:@"09"},
                                                                        @{kBoolBlue:@(NO), kValue:@"22"},
                                                                        @{kBoolBlue:@(NO), kValue:@"24"},
                                                                        @{kBoolBlue:@(NO), kValue:@"30"},
                                                                        @{kBoolBlue:@(NO), kValue:@"33"},
                                                                        @{kBoolBlue:@(YES), kValue:@"01"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020014", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"02"},
                                                                        @{kBoolBlue:@(NO), kValue:@"07"},
                                                                        @{kBoolBlue:@(NO), kValue:@"08"},
                                                                        @{kBoolBlue:@(NO), kValue:@"10"},
                                                                        @{kBoolBlue:@(NO), kValue:@"12"},
                                                                        @{kBoolBlue:@(NO), kValue:@"16"},
                                                                        @{kBoolBlue:@(YES), kValue:@"07"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020013", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"02"},
                                                                        @{kBoolBlue:@(NO), kValue:@"08"},
                                                                        @{kBoolBlue:@(NO), kValue:@"10"},
                                                                        @{kBoolBlue:@(NO), kValue:@"20"},
                                                                        @{kBoolBlue:@(NO), kValue:@"21"},
                                                                        @{kBoolBlue:@(NO), kValue:@"30"},
                                                                        @{kBoolBlue:@(YES), kValue:@"14"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020012", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"04"},
                                                                        @{kBoolBlue:@(NO), kValue:@"13"},
                                                                        @{kBoolBlue:@(NO), kValue:@"14"},
                                                                        @{kBoolBlue:@(NO), kValue:@"23"},
                                                                        @{kBoolBlue:@(NO), kValue:@"26"},
                                                                        @{kBoolBlue:@(NO), kValue:@"31"},
                                                                        @{kBoolBlue:@(YES), kValue:@"09"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020011", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"04"},
                                                                        @{kBoolBlue:@(NO), kValue:@"05"},
                                                                        @{kBoolBlue:@(NO), kValue:@"07"},
                                                                        @{kBoolBlue:@(NO), kValue:@"17"},
                                                                        @{kBoolBlue:@(NO), kValue:@"18"},
                                                                        @{kBoolBlue:@(NO), kValue:@"29"},
                                                                        @{kBoolBlue:@(YES), kValue:@"01"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020010", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"11"},
                                                                        @{kBoolBlue:@(NO), kValue:@"14"},
                                                                        @{kBoolBlue:@(NO), kValue:@"22"},
                                                                        @{kBoolBlue:@(NO), kValue:@"27"},
                                                                        @{kBoolBlue:@(NO), kValue:@"31"},
                                                                        @{kBoolBlue:@(NO), kValue:@"32"},
                                                                        @{kBoolBlue:@(YES), kValue:@"09"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020009", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"03"},
                                                                        @{kBoolBlue:@(NO), kValue:@"06"},
                                                                        @{kBoolBlue:@(NO), kValue:@"08"},
                                                                        @{kBoolBlue:@(NO), kValue:@"14"},
                                                                        @{kBoolBlue:@(NO), kValue:@"19"},
                                                                        @{kBoolBlue:@(NO), kValue:@"26"},
                                                                        @{kBoolBlue:@(YES), kValue:@"12"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020008", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"01"},
                                                                        @{kBoolBlue:@(NO), kValue:@"04"},
                                                                        @{kBoolBlue:@(NO), kValue:@"06"},
                                                                        @{kBoolBlue:@(NO), kValue:@"10"},
                                                                        @{kBoolBlue:@(NO), kValue:@"11"},
                                                                        @{kBoolBlue:@(NO), kValue:@"28"},
                                                                        @{kBoolBlue:@(YES), kValue:@"16"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020007", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"05"},
                                                                        @{kBoolBlue:@(NO), kValue:@"12"},
                                                                        @{kBoolBlue:@(NO), kValue:@"17"},
                                                                        @{kBoolBlue:@(NO), kValue:@"20"},
                                                                        @{kBoolBlue:@(NO), kValue:@"25"},
                                                                        @{kBoolBlue:@(NO), kValue:@"31"},
                                                                        @{kBoolBlue:@(YES), kValue:@"10"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020006", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"03"},
                                                                        @{kBoolBlue:@(NO), kValue:@"04"},
                                                                        @{kBoolBlue:@(NO), kValue:@"05"},
                                                                        @{kBoolBlue:@(NO), kValue:@"10"},
                                                                        @{kBoolBlue:@(NO), kValue:@"16"},
                                                                        @{kBoolBlue:@(NO), kValue:@"32"},
                                                                        @{kBoolBlue:@(YES), kValue:@"09"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020005", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"11"},
                                                                        @{kBoolBlue:@(NO), kValue:@"16"},
                                                                        @{kBoolBlue:@(NO), kValue:@"17"},
                                                                        @{kBoolBlue:@(NO), kValue:@"22"},
                                                                        @{kBoolBlue:@(NO), kValue:@"26"},
                                                                        @{kBoolBlue:@(NO), kValue:@"32"},
                                                                        @{kBoolBlue:@(YES), kValue:@"04"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020004", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"02"},
                                                                        @{kBoolBlue:@(NO), kValue:@"15"},
                                                                        @{kBoolBlue:@(NO), kValue:@"17"},
                                                                        @{kBoolBlue:@(NO), kValue:@"27"},
                                                                        @{kBoolBlue:@(NO), kValue:@"32"},
                                                                        @{kBoolBlue:@(NO), kValue:@"33"},
                                                                        @{kBoolBlue:@(YES), kValue:@"03"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020003", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"09"},
                                                                        @{kBoolBlue:@(NO), kValue:@"17"},
                                                                        @{kBoolBlue:@(NO), kValue:@"26"},
                                                                        @{kBoolBlue:@(NO), kValue:@"29"},
                                                                        @{kBoolBlue:@(NO), kValue:@"30"},
                                                                        @{kBoolBlue:@(NO), kValue:@"32"},
                                                                        @{kBoolBlue:@(YES), kValue:@"03"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020002", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"04"},
                                                                        @{kBoolBlue:@(NO), kValue:@"09"},
                                                                        @{kBoolBlue:@(NO), kValue:@"14"},
                                                                        @{kBoolBlue:@(NO), kValue:@"15"},
                                                                        @{kBoolBlue:@(NO), kValue:@"16"},
                                                                        @{kBoolBlue:@(NO), kValue:@"29"},
                                                                        @{kBoolBlue:@(YES), kValue:@"11"}
        ]}];
        [_allArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:@"2020001", kValueArr:@[
                                                                        @{kBoolBlue:@(NO), kValue:@"02"},
                                                                        @{kBoolBlue:@(NO), kValue:@"15"},
                                                                        @{kBoolBlue:@(NO), kValue:@"23"},
                                                                        @{kBoolBlue:@(NO), kValue:@"26"},
                                                                        @{kBoolBlue:@(NO), kValue:@"29"},
                                                                        @{kBoolBlue:@(NO), kValue:@"30"},
                                                                        @{kBoolBlue:@(YES), kValue:@"02"}
        ]}];
        [_allArr addObject:dic];
    }
    return _allArr;
}

@end
