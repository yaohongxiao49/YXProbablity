//
//  YXProbabilityStatisticalVC.m
//  YXProbabilityTest
//
//  Created by ios on 2020/6/12.
//  Copyright © 2020 August. All rights reserved.
//

#import "YXProbabilityStatisticalVC.h"
#import "YXProbabilityStatisticalHeaderView.h"

@interface YXProbabilityStatisticalVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) YXProbabilityStatisticalHeaderView *headerView;

@property (nonatomic, strong) NSMutableArray *originalRedArr;
@property (nonatomic, strong) NSMutableArray *originalBlueArr;
@property (nonatomic, strong) NSMutableArray *redArr;
@property (nonatomic, strong) NSMutableArray *blueArr;

@property (nonatomic, copy) NSString *mustRed;
@property (nonatomic, copy) NSString *mustBlue;

@end

@implementation YXProbabilityStatisticalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"图形化";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initDataSource];
    [self initView];
}

#pragma mark - 去重并统计重复的数
- (NSMutableArray *)statisticalRepeatNum:(NSMutableArray *)arr {
    
    NSMutableArray *amountArr = [[NSMutableArray alloc] init];
    NSSet *set = [NSSet setWithArray:(NSArray *)arr];

    for (NSString *setStr in set) {
        //需要去掉的元素数组
        NSMutableArray *filteredArr = [[NSMutableArray alloc] initWithObjects:setStr, nil];

        NSMutableArray *dataArr = arr;
        NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"NOT (SELF IN %@)", filteredArr];
        //过滤数组
        NSArray *reslutFilteredArr = [dataArr filteredArrayUsingPredicate:filterPredicate];

        int number = (int)(dataArr.count - reslutFilteredArr.count);
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:setStr forKey:kGraphicsTitle];
        [dic setObject:@(number) forKey:kGraphicsCount];
        [dic setObject:[UIColor colorWithRed:arc4random() %255 /255.0 green:arc4random() %255 /255.0 blue:arc4random() %255 /255.0 alpha:1.0] forKey:kGraphicsColor];
        [amountArr addObject:dic];
    }
    
    return amountArr;
}

#pragma mark - 排序
- (NSArray *)sortingByArr:(NSArray *)arr {
    
    NSArray *resultArray = [arr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        NSNumber *number1 = [obj1 objectForKey:kGraphicsCount];
        NSNumber *number2 = [obj2 objectForKey:kGraphicsCount];
        
        NSComparisonResult result = [number1 compare:number2];
        
        return result == NSOrderedAscending; //降序
    }];
    return resultArray;
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 0;
    }
    return section == 1 ? _redArr.count : _blueArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    NSMutableArray *arr = indexPath.section == 1 ? _redArr : _blueArr;
    NSMutableArray *originalArr = indexPath.section == 1 ? _originalRedArr : _originalBlueArr;
    YXPicChartGraphicsModel *model = arr[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"标题：%@，个数：%.f个，百分比：%.f%%", model.title, model.count, (model.count /originalArr.count) *100];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, tableView.sectionHeaderHeight)];
    lab.backgroundColor = [UIColor whiteColor];
    if (section == 0) {
        lab.text = [NSString stringWithFormat:@"出现频率最高的号码：红球：%@ 篮球：%@", _mustRed, _mustBlue];
    }
    else {
        lab.text = section == 1 ? @"红球" : @"蓝球";
    }
    return lab;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40;
}

#pragma mark - 初始化视图
- (void)initView {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 100) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = self.headerView;
    [self.view addSubview:_tableView];
}

#pragma mark - 初始化数据
- (void)initDataSource {
    
    NSMutableArray *arr = [YXProbabilityListArrModel arrayOfModelsFromDictionaries:[[YXProbabilityManager sharedManager] allArr]];
    
    NSMutableArray *redBallArr = [[NSMutableArray alloc] init];
    NSMutableArray *blueBallArr = [[NSMutableArray alloc] init];
    
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
    
    self.headerView.redArr = [YXPicChartGraphicsArrModel arrayOfModelsFromDictionaries:[self statisticalRepeatNum:redBallArr]];
    self.headerView.blueArr = [YXPicChartGraphicsArrModel arrayOfModelsFromDictionaries:[self statisticalRepeatNum:blueBallArr]];
    
    _originalRedArr = [[NSMutableArray alloc] initWithArray:(NSArray *)redBallArr];
    _originalBlueArr = [[NSMutableArray alloc] initWithArray:(NSArray *)blueBallArr];
    
    _redArr = [YXPicChartGraphicsArrModel arrayOfModelsFromDictionaries:[self sortingByArr:(NSArray *)[self statisticalRepeatNum:redBallArr]]];
    _blueArr = [YXPicChartGraphicsArrModel arrayOfModelsFromDictionaries:[self sortingByArr:(NSArray *)[self statisticalRepeatNum:blueBallArr]]];
    
    NSMutableArray *mustRedArr = [[NSMutableArray alloc] init];
    [[self sortingByArr:(NSArray *)[self statisticalRepeatNum:redBallArr]] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        if (idx < 6) {
            [mustRedArr addObject:[obj objectForKey:kGraphicsTitle]];
        }
    }];
    _mustRed = [mustRedArr componentsJoinedByString:@" "];
    
    NSMutableArray *mustBlueArr = [[NSMutableArray alloc] init];
    [[self sortingByArr:(NSArray *)[self statisticalRepeatNum:blueBallArr]] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        if (idx < 6) {
            [mustBlueArr addObject:[obj objectForKey:kGraphicsTitle]];
        }
    }];
    _mustBlue = [mustBlueArr firstObject];
}

#pragma mark - 懒加载
- (YXProbabilityStatisticalHeaderView *)headerView {
 
    if (!_headerView) {
        _headerView = [[YXProbabilityStatisticalHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height /2)];
    }
    return _headerView;
}


@end
