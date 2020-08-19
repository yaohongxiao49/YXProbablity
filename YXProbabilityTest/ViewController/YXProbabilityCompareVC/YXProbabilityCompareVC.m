//
//  YXProbabilityCompareVC.m
//  YXProbabilityTest
//
//  Created by ios on 2020/8/3.
//  Copyright © 2020 August. All rights reserved.
//

#import "YXProbabilityCompareVC.h"

@interface YXProbabilityCompareVC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *secArr;

@end

@implementation YXProbabilityCompareVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"比较";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initView];
    [self initDataSource];
}

#pragma mark - 比较方法
- (void)compareMethod {
    
    NSMutableArray *allArr = [[NSMutableArray alloc] initWithArray:(NSArray *)[YXProbabilityListArrModel arrayOfModelsFromDictionaries:[YXProbabilityManager sharedManager].allArr]];
    
    BOOL boolRuleOutLastObj = YES;
    if (boolRuleOutLastObj) { //排除最近的一期
        if (allArr.count != 0) [allArr removeObjectAtIndex:0];
        [self compareExperimentMethodByArr:allArr];
    }
    else {
        
    }
}

#pragma mark - 实验比较数据（对比除最近一期数据，计算出可能数据）
- (void)compareExperimentMethodByArr:(NSMutableArray *)arr {
    
    NSMutableArray *rFirstArr = [[NSMutableArray alloc] init];
    NSMutableArray *rSecondArr = [[NSMutableArray alloc] init];
    NSMutableArray *rThirdArr = [[NSMutableArray alloc] init];
    NSMutableArray *rFourArr = [[NSMutableArray alloc] init];
    NSMutableArray *rFiveArr = [[NSMutableArray alloc] init];
    NSMutableArray *rSixArr = [[NSMutableArray alloc] init];
    NSMutableArray *bFirstArr = [[NSMutableArray alloc] init];
    
    [arr enumerateObjectsUsingBlock:^(YXProbabilityListModel *  _Nonnull listModel, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [listModel.valueArr enumerateObjectsUsingBlock:^(YXProbabilityBallInfoModel *  _Nonnull infoModel, NSUInteger idx, BOOL * _Nonnull stop) {
           
            if (infoModel.boolBlue) {
                [bFirstArr addObject:infoModel.value];
            }
            else {
                switch (idx) {
                    case 0:
                        [rFirstArr addObject:infoModel.value];
                        break;
                    case 1:
                        [rSecondArr addObject:infoModel.value];
                        break;
                    case 2:
                        [rThirdArr addObject:infoModel.value];
                        break;
                    case 3:
                        [rFourArr addObject:infoModel.value];
                        break;
                    case 4:
                        [rFiveArr addObject:infoModel.value];
                        break;
                    case 5:
                        [rSixArr addObject:infoModel.value];
                        break;
                    default:
                        break;
                }
            }
        }];
    }];
}

#pragma mark - 修改数组数据
- (void)changeCellValue:(YXProbabilityCompareVCType)key keyTitle:(NSString *)keyTitle value:(id)value {
    
    [self changeToolArrayForSetDic:key keyTitle:keyTitle keyValue:value];
}
- (void)changeToolArrayForSetDic:(YXProbabilityCompareVCType)key keyTitle:(NSString *)keyTitle keyValue:(id)keyValue {
    
    [self.secArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([[obj objectForKey:@"tag"] integerValue] == key) {
            [obj setObject:keyValue forKey:keyTitle];
            *stop = YES;
        }
    }];
    [_tableView reloadData];
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.secArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSMutableArray *arr = [self.secArr[section] objectForKey:@"valueArr"];
    return arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YXProbabilityAllListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YXProbabilityAllListCell class])];
    NSMutableArray *arr = [self.secArr[indexPath.section] objectForKey:@"valueArr"];
    NSInteger type = [[self.secArr[indexPath.section] objectForKey:@"tag"] integerValue];
    
    NSMutableArray *oldArr = type != YXProbabilityCompareVCTypeOld ? [self.secArr[0] objectForKey:@"valueArr"] : (NSMutableArray *)@[];
    [cell reloadValueByIndexPath:indexPath arr:arr oldArr:oldArr];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel *lab = [UILabel new];
    lab.text = [self.secArr[section] objectForKey:@"title"];
    return lab;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40;
}

#pragma mark - 初始化视图
- (void)initView {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.yxNaviHeight, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - self.yxNaviHeight) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.estimatedRowHeight = 100;
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:[YXProbabilityAllListCell.class description] bundle:nil] forCellReuseIdentifier:NSStringFromClass([YXProbabilityAllListCell class])];
}
- (void)initDataSource {
    
    NSMutableArray *oldArr = [[NSMutableArray alloc] initWithObjects:[[YXProbabilityListArrModel arrayOfModelsFromDictionaries:[[YXProbabilityManager sharedManager] allArr]] firstObject], nil];
    NSMutableArray *randomMutArr = [[NSMutableArray alloc] initWithArray:self.randomArr];
    NSMutableArray *realMutArr = [YXProbabilityListArrModel arrayOfModelsFromDictionaries:[YXProbabilityManager sharedManager].realListArr];
    
    [self changeCellValue:YXProbabilityCompareVCTypeOld keyTitle:@"valueArr" value:oldArr];
    [self changeCellValue:YXProbabilityCompareVCTypeStatistical keyTitle:@"valueArr" value:realMutArr];
    [self changeCellValue:YXProbabilityCompareVCTypeRandomMin keyTitle:@"valueArr" value:[randomMutArr firstObject]];
    [self changeCellValue:YXProbabilityCompareVCTypeRandomMax keyTitle:@"valueArr" value:[randomMutArr lastObject]];
    
    [self compareMethod];
}

#pragma mark - 懒加载
- (NSMutableArray *)secArr {
    
    if (!_secArr) {
        _secArr = [[NSMutableArray alloc] init];
        NSMutableDictionary *dic;
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"title":@"往期数据", @"tag":@(YXProbabilityCompareVCTypeOld), @"valueArr":(NSMutableArray *)@[]}];
        [_secArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"title":@"比较数据", @"tag":@(YXProbabilityCompareVCTypeCompare), @"valueArr":(NSMutableArray *)@[]}];
        [_secArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"title":@"统计数据", @"tag":@(YXProbabilityCompareVCTypeStatistical), @"valueArr":(NSMutableArray *)@[]}];
        [_secArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"title":@"随机频率最大数据", @"tag":@(YXProbabilityCompareVCTypeRandomMax), @"valueArr":(NSMutableArray *)@[]}];
        [_secArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"title":@"随机频率最小数据", @"tag":@(YXProbabilityCompareVCTypeRandomMin), @"valueArr":(NSMutableArray *)@[]}];
        [_secArr addObject:dic];
    }
    return _secArr;
}

@end
