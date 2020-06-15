//
//  YXProbabilityRandomVC.m
//  YXProbabilityTest
//
//  Created by ios on 2020/6/12.
//  Copyright © 2020 August. All rights reserved.
//
// 规则 红色球号码区由1-33共三十三个号码组成，蓝色球号码区由1-16共十六个号码组成

#import "YXProbabilityRandomVC.h"
#import "YXPicChartGraphicsModel.h"
#import "YXProbabilityRandomHeaderView.h"

#define kCycleCount 100000//189704646
#define kcalculateCount 2

@interface YXProbabilityRandomVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSMutableArray *redArr;
@property (nonatomic, copy) NSMutableArray *blueArr;
@property (nonatomic, copy) NSMutableArray *resultRandomArr;
@property (nonatomic, copy) NSArray *endArr;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) YXProbabilityRandomHeaderView *headerView;

@property (nonatomic, assign) NSInteger begainTime;

@end

@implementation YXProbabilityRandomVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"随机数";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initDataSource];
    [self initView];
}

#pragma mark - 获取当前时间
- (NSString *)currentTimeStr {
    
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval time = [date timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}

#pragma mark - 循环取数
- (void)getRandomCollectionByCount:(NSInteger)count {
    
    __weak typeof(self) weakSelf = self;
    NSInteger calculateCount = count /kcalculateCount;
    dispatch_group_t group = dispatch_group_create();
    
    for (int i = 0; i < kcalculateCount; i ++) {
        dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            weakSelf.begainTime = [[weakSelf currentTimeStr] integerValue];
            for (int i = 0; i < calculateCount; i++) {
                [weakSelf getRandomByRedArr:weakSelf.redArr blueArr:weakSelf.blueArr];
            }
        });
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        
        
    });
}

#pragma mark - 取随机数
- (void)getRandomByRedArr:(NSMutableArray *)redArr blueArr:(NSMutableArray *)blueArr {
    
    NSMutableArray *randomArr = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 6; i++) {
        NSInteger index = arc4random() %([redArr count] - 1);
        NSString *red = [redArr[index] integerValue] < 10 ? [NSString stringWithFormat:@"0%@", redArr[index]] : redArr[index];
        [randomArr addObject:red];
    }
    
    NSInteger index = arc4random() %([blueArr count] - 1);
    NSString *blue = [blueArr[index] integerValue] < 10 ? [NSString stringWithFormat:@"0%@", blueArr[index]] : blueArr[index];
    [randomArr addObject:blue];
    
    NSString *randomStr = [randomArr componentsJoinedByString:@" "];
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
    
        weakSelf.count ++;
        NSLog(@"randomStr == %@, count == %@", randomStr, @(weakSelf.count));
        [weakSelf.resultRandomArr addObject:randomStr];
        weakSelf.headerView.prgressValue = (float)weakSelf.count /kCycleCount;
    });
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
        
        return result == NSOrderedDescending; //降序
    }];
    return resultArray;
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _endArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    
    YXPicChartGraphicsModel *model = _endArr[indexPath.row];
    cell.textLabel.text = model.title;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}

#pragma mark - 初始化视图
- (void)initView {
    
    __weak typeof(self) weakSelf = self;
    
    _headerView = [[[NSBundle mainBundle] loadNibNamed:[YXProbabilityRandomHeaderView.class description] owner:self options:nil] lastObject];
    _headerView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 80);
    _headerView.yxProbabilityRandomHVBlock = ^{
      
        [weakSelf getRandomCollectionByCount:kCycleCount];
    };
    _headerView.yxProbabilityRandomHVEndBlock = ^{
      
        NSInteger endTime = [[weakSelf currentTimeStr] integerValue];
        NSLog(@"开始时间：%@\n结束时间：%@\n耗时 == %@", @(weakSelf.begainTime), @(endTime), @(endTime - weakSelf.begainTime));
        weakSelf.endArr = [[weakSelf sortingByArr:(NSArray *)[weakSelf statisticalRepeatNum:weakSelf.resultRandomArr]] subarrayWithRange:NSMakeRange(0, 3)];
        [weakSelf.tableView reloadData];
    };
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 100) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = _headerView;
    [self.view addSubview:_tableView];
}

#pragma mark - 初始化数据
- (void)initDataSource {
    
    _resultRandomArr = [[NSMutableArray alloc] init];
    _redArr = [[NSMutableArray alloc] init];
    _blueArr = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 1; i <= 33; i ++) {
        [_redArr addObject:@(i)];
    }
    for (NSInteger i = 1; i <= 16; i ++) {
        [_blueArr addObject:@(i)];
    }
}

@end
