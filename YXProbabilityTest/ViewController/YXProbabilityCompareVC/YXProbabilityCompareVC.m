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
@property (nonatomic, strong) NSMutableArray *dataSourceArr;
@property (nonatomic, strong) NSMutableArray *randomMutArr;
@property (nonatomic, strong) NSMutableArray *realMutArr;

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

#pragma mark - <UITableViewDataSource, UITableViewDelegate>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0: //比较数据
            return _dataSourceArr.count;
            break;
        case 1: //综合往期数据
            return _realMutArr.count;
            break;
        case 2: //随机数据频率小
            return [[_randomMutArr firstObject] count];
            break;
        case 3: //随机数据概率大
            return [[_randomMutArr lastObject] count];
            break;
        default:
            break;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YXProbabilityAllListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YXProbabilityAllListCell class])];
    switch (indexPath.section) {
        case 0:
            [cell reloadValueByIndexPath:indexPath arr:_dataSourceArr];
            break;
        case 1:
            [cell reloadValueByIndexPath:indexPath arr:_realMutArr];
            break;
        case 2:
            [cell reloadValueByIndexPath:indexPath arr:[_randomMutArr firstObject]];
            break;
        case 3:
            [cell reloadValueByIndexPath:indexPath arr:[_randomMutArr lastObject]];
            break;
        default:
            break;
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel *lab = [UILabel new];
    switch (section) {
        case 0:
            lab.text = @"比较数据";
            break;
        case 1:
            lab.text = @"综合往期数据";
            break;
        case 2:
            lab.text = @"随机频率最小";
            break;
        case 3:
            lab.text = @"随机频率最大";
            break;
        default:
            break;
    }
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
    
    _dataSourceArr = [[NSMutableArray alloc] init];
    _randomMutArr = [[NSMutableArray alloc] initWithArray:self.randomArr];
    _realMutArr = [YXProbabilityListArrModel arrayOfModelsFromDictionaries:[YXProbabilityManager sharedManager].realListArr];
    
    NSMutableArray *redArr = [[NSMutableArray alloc] init];
    NSMutableArray *blueArr = [[NSMutableArray alloc] init];
    
    
    //组装蓝球数组、红球数组
    [_realMutArr enumerateObjectsUsingBlock:^(YXProbabilityListModel *  _Nonnull realModel, NSUInteger idx, BOOL * _Nonnull stop) {
        [realModel.valueArr enumerateObjectsUsingBlock:^(YXProbabilityBallInfoModel *  _Nonnull realInfoModel, NSUInteger idx, BOOL * _Nonnull stop) {
            
        }];
    }];
    
    [_randomMutArr enumerateObjectsUsingBlock:^(NSArray *  _Nonnull arr, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [arr enumerateObjectsUsingBlock:^(YXProbabilityListModel *  _Nonnull randomModel, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [randomModel.valueArr enumerateObjectsUsingBlock:^(YXProbabilityBallInfoModel *  _Nonnull randomInfoModel, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if (randomInfoModel.boolBlue) {
                    [blueArr addObject:randomInfoModel.value];
                }
                else {
                    [redArr addObject:randomInfoModel.value];
                }
            }];
        }];
    }];
    [self.randomArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
    }];
}

@end
