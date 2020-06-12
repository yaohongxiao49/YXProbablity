//
//  YXProbabilityStatisticalVC.m
//  YXProbabilityTest
//
//  Created by ios on 2020/6/12.
//  Copyright © 2020 August. All rights reserved.
//

#import "YXProbabilityStatisticalVC.h"
#import "YXProbabilityManager.h"
#import "YXPicChartGraphicsShowView.h"

@interface YXProbabilityStatisticalVC ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) YXPicChartGraphicsShowView *headerView;
@property (nonatomic, strong) YXPicChartGraphicsShowView *footerView;

@end

@implementation YXProbabilityStatisticalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"图形化";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initView];
}

#pragma mark - 统计重复的数
- (NSMutableArray *)statisticalRepeatNum:(NSMutableArray *)arr {
    
    NSMutableArray *amountArr = [[NSMutableArray alloc] init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    NSSet *set = [NSSet setWithArray:(NSArray *)arr];

    for (NSString *setStr in set) {
        //需要去掉的元素数组
        NSMutableArray *filteredArr = [[NSMutableArray alloc] initWithObjects:setStr, nil];

        NSMutableArray *dataArr = arr;
        NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"NOT (SELF IN %@)", filteredArr];
        //过滤数组
        NSArray *reslutFilteredArr = [dataArr filteredArrayUsingPredicate:filterPredicate];

        int number = (int)(dataArr.count - reslutFilteredArr.count);
        [dic setObject:setStr forKey:kGraphicsTitle];
        [dic setObject:@(number) forKey:kGraphicsCount];
        [dic setObject:[UIColor colorWithRed:arc4random() %255 /255.0 green:arc4random() %255 /255.0 blue:arc4random() %255 /255.0 alpha:1.0] forKey:kGraphicsColor];
        [amountArr addObject:dic];
    }
    
    return amountArr;
}

#pragma mark - 初始化视图
- (void)initView {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 64) style:UITableViewStylePlain];
    _tableView.estimatedRowHeight = 100;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];

    NSMutableArray *arr = [YXProbabilityListArrModel arrayOfModelsFromDictionaries:[[YXProbabilityManager sharedManager] allArr]];
    
    NSMutableArray *redBallArr = [[NSMutableArray alloc] init];
    NSMutableArray *blueBallArr = [[NSMutableArray alloc] init];
    
//    NSMutableArray *arr = [YXPicChartGraphicsArrModel arrayOfModelsFromDictionaries:@[@{kGraphicsTitle:@"测试一", kGraphicsDescript:@"这是第一个测试", kGraphicsCount:@(20), kGraphicsColor:[UIColor colorWithRed:arc4random() %255 /255.0 green:arc4random() %255 /255.0 blue:arc4random() %255 /255.0 alpha:1.0]}, @{kGraphicsTitle:@"测试二", kGraphicsDescript:@"这是第二个测试", kGraphicsCount:@(30), kGraphicsColor:[UIColor colorWithRed:arc4random() %255 /255.0 green:arc4random() %255 /255.0 blue:arc4random() %255 /255.0 alpha:1.0]}]];
    
    [arr enumerateObjectsUsingBlock:^(YXProbabilityListModel *  _Nonnull listModel, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [listModel.valueArr enumerateObjectsUsingBlock:^(YXProbabilityBallInfoModel *  _Nonnull infoModel, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (infoModel.boolBlue) {
                [blueBallArr addObject:infoModel.value];
            }
            else {
                [redBallArr addObject:infoModel.value];
            }
        }];
    }];
    
    self.headerView.pieChartGraphicsArr = [self statisticalRepeatNum:blueBallArr];
    self.footerView.pieChartGraphicsArr = [self statisticalRepeatNum:redBallArr];
}

#pragma mark - 懒加载
- (YXPicChartGraphicsShowView *)headerView {
    
    if (!_headerView) {
        _headerView = [[YXPicChartGraphicsShowView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height /2 - 20) arr:nil title:@"红球"];
        [self.view addSubview:_headerView];
    }
    return _headerView;
}
- (YXPicChartGraphicsShowView *)footerView {
    
    if (!_footerView) {
        _headerView = [[YXPicChartGraphicsShowView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height /2 - 20) arr:nil title:@"红球"];
        [self.view addSubview:_headerView];
    }
    return _footerView;
}

@end
