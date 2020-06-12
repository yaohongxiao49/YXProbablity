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

#pragma mark - 懒加载
- (NSMutableArray *)allArr {
    
    if (!_allArr) {
        _allArr = [[NSMutableArray alloc] init];
        NSMutableDictionary *dic;
        
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
