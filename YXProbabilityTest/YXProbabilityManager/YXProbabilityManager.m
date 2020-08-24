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
- (NSString *)assemblyProbabilityArrByRandomCount:(NSInteger)randomCount valueSet:(id)valueSet probabilityArr:(NSArray *)probabilityArr boolRed:(BOOL)boolRed {
    
    if (boolRed) {
        __block NSInteger a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z, aa, bb, cc, dd, ee, ff, gg;
        
        NSInteger index = arc4random() %100;
        [probabilityArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            NSInteger probability = [[obj objectForKey:kProbability] integerValue] *100;
            switch (idx) {
                case 0: { a = probability; break; }
                case 1: { b = probability; break; }
                case 2: { c = probability; break; }
                case 3: { d = probability; break; }
                case 4: { e = probability; break; }
                case 5: { f = probability; break; }
                case 6: { g = probability; break; }
                case 7: { h = probability; break; }
                case 8: { i = probability; break; }
                case 9: { j = probability; break; }
                case 10: { k = probability; break; }
                case 11: { l = probability; break; }
                case 12: { m = probability; break; }
                case 13: { n = probability; break; }
                case 14: { o = probability; break; }
                case 15: { p = probability; break; }
                case 16: { q = probability; break; }
                case 17: { r = probability; break; }
                case 18: { s = probability; break; }
                case 19: { t = probability; break; }
                case 20: { u = probability; break; }
                case 21: { v = probability; break; }
                case 22: { w = probability; break; }
                case 23: { x = probability; break; }
                case 24: { y = probability; break; }
                case 25: { z = probability; break; }
                case 26: { aa = probability; break; }
                case 27: { bb = probability; break; }
                case 28: { cc = probability; break; }
                case 29: { dd = probability; break; }
                case 30: { ee = probability; break; }
                case 31: { ff = probability; break; }
                case 32: { gg = probability; break; }
                default:
                    break;
            }
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
        else {}
        
        NSString *red = [[probabilityArr[tag] objectForKey:kValue] integerValue] < 10 ? [NSString stringWithFormat:@"0%@", [probabilityArr[tag] objectForKey:kValue]] : [probabilityArr[tag] objectForKey:kValue];
        [valueSet addObject:red];
        return @"";
    }
    else {
        __block NSInteger a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p;
        
        NSInteger index = arc4random() %100;
        [probabilityArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            NSInteger probability = [[obj objectForKey:kProbability] integerValue] *100;
            switch (idx) {
                case 0: { a = probability; break; }
                case 1: { b = probability; break; }
                case 2: { c = probability; break; }
                case 3: { d = probability; break; }
                case 4: { e = probability; break; }
                case 5: { f = probability; break; }
                case 6: { g = probability; break; }
                case 7: { h = probability; break; }
                case 8: { i = probability; break; }
                case 9: { j = probability; break; }
                case 10: { k = probability; break; }
                case 11: { l = probability; break; }
                case 12: { m = probability; break; }
                case 13: { n = probability; break; }
                case 14: { o = probability; break; }
                case 15: { p = probability; break; }
                default:
                    break;
            }
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
        else {}
        
        NSString *blue = [probabilityArr[tag] integerValue] < 10 ? [NSString stringWithFormat:@"0%@", probabilityArr[tag]] : probabilityArr[tag];
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
