//
//  YXProbabilityCompareVC.m
//  YXProbabilityTest
//
//  Created by ios on 2020/8/3.
//  Copyright © 2020 August. All rights reserved.
//

#import "YXProbabilityCompareVC.h"
#import "YXProbabilityAllListCell.h"
#import "NSObject+YXCategory.h"

@interface YXProbabilityCompareVC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSMutableArray *dataSourceArr;

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
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataSourceArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YXProbabilityAllListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YXProbabilityAllListCell class])];
    [cell reloadValueByIndexPath:indexPath arr:_dataSourceArr];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}

#pragma mark - 初始化视图
- (void)initView {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.yxNaviHeight, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - self.yxNaviHeight) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.estimatedRowHeight = 100;
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:[YXProbabilityAllListCell.class description] bundle:nil] forCellReuseIdentifier:NSStringFromClass([YXProbabilityAllListCell class])];
    
    _dataSourceArr = [YXProbabilityListArrModel arrayOfModelsFromDictionaries:[[YXProbabilityManager sharedManager] allArr]];
}
- (void)initDataSource {
    
    NSMutableArray *randomMutArr = [[NSMutableArray alloc] initWithArray:self.randomArr];
    NSMutableArray *realMutArr = [YXProbabilityListArrModel arrayOfModelsFromDictionaries:(NSArray *)self.realArr];
    
    NSMutableArray *redArr = [[NSMutableArray alloc] init];
    NSMutableArray *blueArr = [[NSMutableArray alloc] init];
    
    
    //组装蓝球数组、红球数组
    [realMutArr enumerateObjectsUsingBlock:^(YXProbabilityListModel *  _Nonnull realModel, NSUInteger idx, BOOL * _Nonnull stop) {
        [realModel.valueArr enumerateObjectsUsingBlock:^(YXProbabilityBallInfoModel *  _Nonnull realInfoModel, NSUInteger idx, BOOL * _Nonnull stop) {
            
        }];
    }];
    
    [randomMutArr enumerateObjectsUsingBlock:^(YXProbabilityListModel *  _Nonnull randomModel, NSUInteger idx, BOOL * _Nonnull stop) {
        [randomModel.valueArr enumerateObjectsUsingBlock:^(YXProbabilityBallInfoModel *  _Nonnull randomInfoModel, NSUInteger idx, BOOL * _Nonnull stop) {
            
            
            
        }];
    }];
    [self.randomArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
    }];
}

@end
