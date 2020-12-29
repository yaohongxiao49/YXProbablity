//
//  YXProbabilityRuleOutVC.m
//  YXProbabilityTest
//
//  Created by ios on 2020/12/29.
//  Copyright © 2020 August. All rights reserved.
//

#import "YXProbabilityRuleOutVC.h"
#import "YXProbabilityAllListCell.h"
#import "YXProbabilityRandomHeaderView.h"
#import "YXProbabilityCompareVC.h"
#import "YXPieChartLineGraphicsModel.h"

#define kCycleCount 5000000
#define kcalculateCount 4
#define kShowCount 2
#define kGetValuesCount @"5"

@interface YXProbabilityRuleOutVC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) YXProbabilityRandomHeaderView *headerView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, strong) NSMutableArray *redArr; //红球
@property (nonatomic, strong) NSMutableArray *blueArr; //蓝球
@property (nonatomic, strong) NSMutableArray *redCollecArr;
@property (nonatomic, strong) NSMutableArray *blueCollecArr;
@property (nonatomic, copy) NSArray *probabilityRedArr; //随机概率红球
@property (nonatomic, copy) NSArray *probabilityBlueArr; //随机概率蓝球
@property (nonatomic, strong) NSMutableArray *resultRandomArr; //结果随机
@property (nonatomic, strong) NSMutableArray *endArr; //结果
@property (nonatomic, assign) BOOL boolCancel; //是否结束
@property (nonatomic, assign) NSInteger amount;

@property (nonatomic, strong) NSMutableArray *oldArr; //上期数据

@end

@implementation YXProbabilityRuleOutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"比较排除";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initView];
    [self initDataSource];
}

#pragma mark - method
#pragma mark - 循环取数
- (void)getRandomCollectionByCount:(NSInteger)count {
    
    __weak typeof(self) weakSelf = self;
    [_activityIndicatorView startAnimating];
    NSInteger calculateCount = count /kcalculateCount;
    dispatch_group_t group = dispatch_group_create();
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(kcalculateCount);
    for (int i = 0; i < kcalculateCount; i ++) {
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_group_async(group, queue, ^{

            dispatch_semaphore_signal(semaphore);
            for (int i = 0; i < calculateCount; i++) {
                if (self.boolCancel) {
                    break;
                }
                else {
                    [weakSelf getRandomByRedArr:weakSelf.redArr blueArr:weakSelf.blueArr randomCount:kCycleCount];
                }
            }
        });
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{

        [self endCount];
    });
}

#pragma mark - 取随机数
- (void)getRandomByRedArr:(NSMutableArray *)redArr blueArr:(NSMutableArray *)blueArr randomCount:(NSInteger)randomCount {
    
    __weak typeof(self) weakSelf = self;
    
    NSMutableArray *randomArr = [[NSMutableArray alloc] init];
    NSMutableSet *randomSet = [[NSMutableSet alloc] init];

    while ([randomSet count] < 6) {
        [randomSet addObject:[YXProbabilityManager assemblyProbabilityArrByRandomCount:randomCount valueSet:randomSet probabilityArr:_probabilityRedArr boolRed:YES]];
    }
    [randomArr addObjectsFromArray:[randomSet allObjects]];
    NSMutableArray *sortingArr = [[NSMutableArray alloc] initWithArray:[weakSelf sortingByArr:(NSArray *)randomArr type:NSOrderedDescending]];
    
    NSString *blue = [YXProbabilityManager assemblyProbabilityArrByRandomCount:randomCount valueSet:sortingArr probabilityArr:_probabilityBlueArr boolRed:NO];
    
    NSString *randomStr = [sortingArr componentsJoinedByString:@" "];
    
    weakSelf.amount ++;
    dispatch_async(dispatch_get_main_queue(), ^{

        [weakSelf.redCollecArr addObjectsFromArray:randomArr];
        [weakSelf.blueCollecArr addObject:blue];
        
        [weakSelf.resultRandomArr addObject:randomStr];
        weakSelf.headerView.prgressValue = (float)weakSelf.amount /kCycleCount;
    });
}

#pragma mark - 结束
- (void)endCount {
    
    __weak typeof(self) weakSelf = self;
    
    [_activityIndicatorView startAnimating];
    dispatch_queue_t queue = dispatch_queue_create("com.repeatNumQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        
        NSLog(@"开始统计！");
        NSArray *repeatNumArr = [[NSArray alloc] initWithArray:(NSArray *)[weakSelf statisticalRepeatNum:weakSelf.resultRandomArr getValuesCount:kGetValuesCount]];
        NSArray *sortingArr = [[NSArray alloc] initWithArray:[weakSelf sortingByArr:repeatNumArr type:NSOrderedDescending]];
        NSLog(@"结果数组个数 == %@", @(repeatNumArr.count));
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [weakSelf.activityIndicatorView stopAnimating];
            if (sortingArr.count != 0) {
                [weakSelf showAlertView:sortingArr];
            }
            else {
                NSLog(@"数组为空！");
            }
        });
    });
}

#pragma mark - 显示储存提示弹窗并选择是否储存数据
- (void)showAlertView:(NSArray *)arr {
    
    __weak typeof(self) weakSelf = self;
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否需要保存当前随机数组" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *sureAlertAction = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [weakSelf.activityIndicatorView startAnimating];
        NSMutableArray *listArr = [[NSMutableArray alloc] initWithArray:[weakSelf sortingByArr:arr type:NSOrderedDescending]];
        [YXProbabilityManager sharedManager].probablityRandomListArr = (NSArray *)listArr;
        
        [weakSelf assemblyValueByArr:(NSMutableArray *)[YXProbabilityManager sharedManager].probablityRandomListArr];
    }];
    [sureAlertAction setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    [alertVC addAction:sureAlertAction];
    
    UIAlertAction *cancelAlertAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [cancelAlertAction setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    [alertVC addAction:cancelAlertAction];
    
    [self presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark - 组装数据
- (void)assemblyValueByArr:(NSMutableArray *)arr {
    
    NSLog(@"开始进行数据组装！");
    NSMutableArray *endArr = [[NSMutableArray alloc] init];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        NSMutableDictionary *valueDic = [[NSMutableDictionary alloc] init];
        
        //组装出现频率信息
        NSString *occurrences = [obj objectForKey:kPieChartLineGraphicsValue];
        [valueDic setValue:occurrences forKey:kDate];
        
        //组装球信息
        NSString *ball = [obj objectForKey:kPieChartLineGraphicsName];
        NSArray *ballArr = [ball componentsSeparatedByString:@" "];
        NSMutableArray *valueArr = [[NSMutableArray alloc] init];
        [ballArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            NSDictionary *dic;
            if (idx == (ballArr.count - 1)) {
                dic = @{kBoolBlue:@(YES), kValue:obj};
            }
            else {
                dic = @{kBoolBlue:@(NO), kValue:obj};
            }
            [valueArr addObject:dic];
        }];
        [valueDic setObject:valueArr forKey:kValueArr];
        
        [endArr addObject:valueDic];
    }];
    
    NSMutableArray *modelArr = [YXProbabilityListArrModel arrayOfModelsFromDictionaries:endArr];
    
    _endArr = [[NSMutableArray alloc] initWithObjects:modelArr, nil];
    [_tableView reloadData];
    
    [self reloadAlertView];
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

#pragma mark - 去重并统计重复的数
- (NSMutableArray *)statisticalRepeatNum:(NSMutableArray *)arr getValuesCount:(NSString *)getValuesCount {
    
    NSMutableArray *amountArr = [[NSMutableArray alloc] init];
    NSCountedSet *countSet = [[NSCountedSet alloc] initWithArray:(NSArray *)arr];
    
    for (id item in countSet) { //去重并统计
        NSInteger count = [countSet countForObject:item];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:item forKey:kPieChartLineGraphicsName];
        [dic setObject:@(count) forKey:kPieChartLineGraphicsValue];
        [self ruleOutByLastArr:item finishedBlock:^(BOOL boolInsert) {
           
            if (boolInsert) {
                [amountArr addObject:dic];
            }
        }];
    }
    
    return amountArr;
}

#pragma mark - 对比上期排除
- (void)ruleOutByLastArr:(id)item finishedBlock:(void(^)(BOOL boolInsert))finishedBlock {
    
    //当前蓝
    NSString *nowBlue = [[item componentsSeparatedByString:@" "] lastObject];
    
    //往期蓝
    for (YXProbabilityBallInfoModel *oldBallInfoModel in _oldArr) {
        if (oldBallInfoModel.boolBlue && [oldBallInfoModel.value isEqualToString:nowBlue]) {
            if (finishedBlock) {
                finishedBlock(NO);
            }
            return;
        }
    }
    
    //往期数据
    NSMutableArray *oldArr = [[NSMutableArray alloc] init];
    for (YXProbabilityBallInfoModel *oldBallInfoModel in _oldArr) {
        if (oldBallInfoModel.boolBlue) {
            [oldArr insertObject:oldBallInfoModel.value atIndex:6];
        }
        else {
            [oldArr addObject:oldBallInfoModel.value];
        }
    }
    
    NSPredicate *nowPre = [NSPredicate predicateWithFormat:@"SELF IN %@", item];
    NSArray *sameArr = [oldArr filteredArrayUsingPredicate:nowPre];
    if (sameArr.count >= 2) {
        if (finishedBlock) {
            finishedBlock(NO);
        }
    }
    else {
        if (finishedBlock) {
            finishedBlock(YES);
        }
    }
}

#pragma mark - 界面更新弹窗
- (void)reloadAlertView {
    
    [_activityIndicatorView stopAnimating];
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"界面已更新" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *sureAlertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
    [sureAlertAction setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    [alertVC addAction:sureAlertAction];
    
    [self presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark - progress
#pragma mark - 跳转至比较页面
- (void)pushToCompareVC {
    
    YXProbabilityCompareVC *vc = [[YXProbabilityCompareVC alloc] init];
//    vc.randomArr = _endArr;
//    vc.calculateRandomArr = _minArr;
    vc.realArr = [[YXProbabilityManager sharedManager] allArr];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _endArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *valueArr = _endArr[section];
    return [valueArr count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YXProbabilityAllListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YXProbabilityAllListCell class])];
    [cell reloadValueByIndexPath:indexPath arr:_endArr[indexPath.section] oldArr:(NSMutableArray *)@[]];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

#pragma mark - 初始化视图
- (void)initView {
    
    __weak typeof(self) weakSelf = self;
    
    _headerView = [[[NSBundle mainBundle] loadNibNamed:[YXProbabilityRandomHeaderView.class description] owner:self options:nil] lastObject];
    _headerView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 100);
    _headerView.yxProbabilityRandomHVBlock = ^{
      
        [weakSelf initDataSource];
        [weakSelf getRandomCollectionByCount:kCycleCount];
    };
    _headerView.yxProbabilityRandomHVEndBlock = ^{
      
        weakSelf.boolCancel = YES;
    };
    _headerView.yxProbabilityRandomHVCompareBlock = ^{
      
        [weakSelf pushToCompareVC];
    };
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.yxNaviHeight, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - self.yxNaviHeight) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.estimatedRowHeight = 100;
    _tableView.tableHeaderView = _headerView;
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:[YXProbabilityAllListCell.class description] bundle:nil] forCellReuseIdentifier:NSStringFromClass([YXProbabilityAllListCell class])];
    
    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _activityIndicatorView.center = self.view.center;
    _activityIndicatorView.color = [UIColor redColor];
    [self.view addSubview:_activityIndicatorView];
}

#pragma mark - 初始化数据
- (void)initDataSource {
    
    _boolCancel = NO;
    _redArr = [[NSMutableArray alloc] init];
    _blueArr = [[NSMutableArray alloc] init];
    _redCollecArr = [[NSMutableArray alloc] init];
    _blueCollecArr = [[NSMutableArray alloc] init];
    _probabilityRedArr = [YXProbabilityManager sharedManager].probabilityRedArr;
    _probabilityBlueArr = [YXProbabilityManager sharedManager].probabilityBlueArr;
    _resultRandomArr = [[NSMutableArray alloc] init];
    _endArr = [[NSMutableArray alloc] init];
    
    YXProbabilityListModel *oldModel = [[YXProbabilityListArrModel arrayOfModelsFromDictionaries:[[YXProbabilityManager sharedManager] allArr]] firstObject];
    _oldArr = oldModel.valueArr;
    
    for (NSInteger i = 1; i <= 33; i ++) {
        [_redArr addObject:@(i)];
    }
    for (NSInteger i = 1; i <= 16; i ++) {
        [_blueArr addObject:@(i)];
    }
}

@end
