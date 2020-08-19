//
//  ViewController.m
//  YXProbabilityTest
//
//  Created by ios on 2020/6/11.
//  Copyright © 2020 August. All rights reserved.
//

#import "ViewController.h"
#import "YXProbabilityAllListCell.h"
#import "YXProbabilityAllHeaderView.h"
#import <MJRefresh.h>
#import "YXProbabilityRequest.h"
#import "NSObject+YXCategory.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger issueCount;
@property (nonatomic, strong) NSMutableArray *dataSourceArr;
@property (nonatomic, copy) YXProbabilityAllHeaderView *headerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"主页";
    
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self getSaveBallHTTP];
}

#pragma mark - 即时获取双色球数据
- (void)getBallHTTPByIssueCount:(NSInteger)issueCount {
    
    __weak typeof(self) weakSelf = self;
    [YXProbabilityRequest getBallHistoryListByIssueCount:issueCount successBlock:^(NSArray *arr) {
        
        [weakSelf endRefresh];
        
        if (arr.count != 0) {
            NSMutableArray *valueArr = [[NSMutableArray alloc] init];
            [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               
                NSString *date = obj[@"code"];
                NSString *blue = obj[@"blue"];
                NSString *red = obj[@"red"];
                NSArray *redArr = [red componentsSeparatedByString:@","];
                
                NSMutableDictionary *endDic = [[NSMutableDictionary alloc] initWithDictionary:@{kDate:date, kValueArr:@[
                                                                                @{kBoolBlue:@(NO), kValue:redArr[0]},
                                                                                @{kBoolBlue:@(NO), kValue:redArr[1]},
                                                                                @{kBoolBlue:@(NO), kValue:redArr[2]},
                                                                                @{kBoolBlue:@(NO), kValue:redArr[3]},
                                                                                @{kBoolBlue:@(NO), kValue:redArr[4]},
                                                                                @{kBoolBlue:@(NO), kValue:redArr[5]},
                                                                                @{kBoolBlue:@(YES), kValue:blue}
                ]}];
                [valueArr addObject:endDic];
            }];
            
            [[[YXProbabilityManager sharedManager] allArr] setArray:valueArr];
            weakSelf.dataSourceArr = [YXProbabilityListArrModel arrayOfModelsFromDictionaries:valueArr];
        }
        
        [weakSelf.tableView reloadData];
    } failBlock:^(NSError *error) {
        
        [weakSelf endRefresh];
    }];
}

#pragma mark - 结束刷新
- (void)endRefresh {
    
    [_tableView.mj_header endRefreshing];
    [_tableView.mj_footer endRefreshing];
}

#pragma mark - 获取双色球储存数据
- (void)getSaveBallHTTP {
    
    BmobQuery *bquery = [BmobQuery queryWithClassName:kTableName];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        for (BmobObject *obj in array) {
            [YXProbabilityManager sharedManager].randomListArr = [obj objectForKey:kTableValueKey];
        }
    }];
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
    [cell reloadValueByIndexPath:indexPath arr:_dataSourceArr oldArr:(NSMutableArray *)@[]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}

#pragma mark - 初始化视图
- (void)initView {
    
    __weak typeof(self) weakSelf = self;
    
    _headerView = [[[NSBundle mainBundle] loadNibNamed:[YXProbabilityAllHeaderView.class description] owner:self options:nil] lastObject];
    _headerView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 100);
    _headerView.baseVC = self;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.yxNaviHeight, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - self.yxNaviHeight) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.estimatedRowHeight = 100;
    _tableView.tableHeaderView = _headerView;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        weakSelf.issueCount = 30;
        [weakSelf getBallHTTPByIssueCount:weakSelf.issueCount];
    }];
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        weakSelf.issueCount += 20;
        [weakSelf getBallHTTPByIssueCount:weakSelf.issueCount];
    }];
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:[YXProbabilityAllListCell.class description] bundle:nil] forCellReuseIdentifier:NSStringFromClass([YXProbabilityAllListCell class])];
    
    [_tableView.mj_header beginRefreshing];
    
    _dataSourceArr = [YXProbabilityListArrModel arrayOfModelsFromDictionaries:[[YXProbabilityManager sharedManager] allArr]];
}

@end
