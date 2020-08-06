//
//  YXProbabilityRandomVC.m
//  YXProbabilityTest
//
//  Created by ios on 2020/6/12.
//  Copyright © 2020 August. All rights reserved.
//
// 规则 红色球号码区由1-33共三十三个号码组成，蓝色球号码区由1-16共十六个号码组成

#import "YXProbabilityRandomVC.h"
#import "YXProbabilityManager.h"
#import "YXProbabilityRandomHeaderView.h"
#import "YXPieChartLineGraphicsModel.h"
#import "YXProbabilityCompareVC.h"

#define kCycleCount 10000000//189704646
#define kcalculateCount 10

#define kShowCount 2

@interface YXProbabilityRandomVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, copy) NSMutableArray *redArr;
@property (nonatomic, copy) NSMutableArray *blueArr;
@property (nonatomic, copy) NSMutableArray *redCollecArr;
@property (nonatomic, copy) NSMutableArray *blueCollecArr;
@property (nonatomic, copy) NSMutableArray *resultRandomArr;
@property (nonatomic, strong) NSMutableArray *endArr;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) YXProbabilityRandomHeaderView *headerView;
@property (nonatomic, assign) BOOL boolCancel;
@property (nonatomic, assign) NSInteger cycleCount;

@property (nonatomic, assign) NSInteger begainTime;

@end

@implementation YXProbabilityRandomVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    __weak typeof(self) weakSelf = self;
    
    self.title = @"随机数";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self removeAlertView:^(BOOL isFinished) {
       
        [weakSelf initView];
        if (!isFinished) {
            [weakSelf showChance];
        }
        else {
            [self removeBmobValueHTTP];
        }
    }];
}

#pragma mark - 修改数据库数据
- (void)changeBmobValueHTTP:(NSArray *)arr {
    
    __weak typeof(self) weakSelf = self;
    [_activityIndicatorView startAnimating];
    
    BmobQuery *bquery = [BmobQuery queryWithClassName:kTableName];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        if (array.count != 0) {
            for (BmobObject *obj in array) { //修改Bmob数据信息
                [bquery getObjectInBackgroundWithId:obj.objectId block:^(BmobObject *object, NSError *error) {
                    
                    if (!error) {
                        if (object) { //对象存在
                            BmobObject *obj = [BmobObject objectWithoutDatatWithClassName:object.className objectId:object.objectId];
                            [obj setObject:arr forKey:kTableValueKey];
                            [obj updateInBackground];
                            NSLog(@"修改成功！");
                        }
                        
                        [weakSelf.activityIndicatorView stopAnimating];
                    }
                    else { //进行错误处理
                        NSLog(@"error == %@", error.localizedDescription);
                    }
                }];
            }
        }
        else { //创建Bmob数据信息
            BmobObject *bmobObj = [BmobObject objectWithClassName:kTableName];
            [bmobObj setObject:arr forKey:kTableValueKey];
            [bmobObj saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                
                if (!error) { //对象存在
                    NSLog(@"上传成功！");
                }
                else { //进行错误处理
                    NSLog(@"error == %@", error.localizedDescription);
                }
                [weakSelf.activityIndicatorView stopAnimating];
            }];
        }
    }];
}

#pragma mark - 删除数据库数据
- (void)removeBmobValueHTTP {
    
    __weak typeof(self) weakSelf = self;
    [_activityIndicatorView startAnimating];
    
    //获取服务器里的用户信息
    BmobQuery *bquery = [BmobQuery queryWithClassName:kTableName];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        for (BmobObject *obj in array) {
            [bquery getObjectInBackgroundWithId:obj.objectId block:^(BmobObject *object, NSError *error){
                if (error) { //进行错误处理
                    
                }
                else {
                    if (object) { //异步删除object
                        [object deleteInBackground];
                        NSLog(@"删除成功！");
                    }
                }
            }];
        }
        [weakSelf.activityIndicatorView stopAnimating];
    }];
}


#pragma mark - 获取当前时间
- (NSString *)currentTimeStr {
    
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval time = [date timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}

#pragma mark - 显示出现频率最高的2位以及出现频率最低的2位
- (void)showChance {
    
    NSArray *arr = [[NSArray alloc] initWithArray:[YXProbabilityManager sharedManager].randomListArr];
    
    NSInteger min = arr.count < kShowCount ? arr.count : kShowCount;
    NSInteger max = arr.count > kShowCount ? arr.count - kShowCount : arr.count;
    NSArray *minArr = [arr subarrayWithRange:NSMakeRange(0, min)];
    NSArray *maxArr = [arr subarrayWithRange:NSMakeRange(max, min)];
    
    NSMutableArray *valueArr = [[NSMutableArray alloc] init];
    [valueArr addObjectsFromArray:minArr];
    [valueArr addObjectsFromArray:maxArr];
    
    [self assemblyValueByArr:valueArr min:min];
}

#pragma mark - 结束
- (void)endCount {
    
    __weak typeof(self) weakSelf = self;
    NSInteger endTime = [[self currentTimeStr] integerValue];
    NSLog(@"耗时 == %@", @(endTime - _begainTime));
    
    [_activityIndicatorView startAnimating];
    dispatch_queue_t queue = dispatch_queue_create("com.repeatNumQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        
        NSLog(@"开始统计！");
        NSArray *repeatNumArr = [[NSArray alloc] initWithArray:(NSArray *)[weakSelf statisticalRepeatNum:weakSelf.resultRandomArr]];
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
    NSMutableArray *historyArr = [[NSMutableArray alloc] initWithArray:[YXProbabilityManager sharedManager].randomListArr];
    NSString *minDiscribe = [[historyArr firstObject] objectForKey:kPieChartLineGraphicsValue];
    NSString *maxDiscribe = [[historyArr lastObject] objectForKey:kPieChartLineGraphicsValue];
    if ([minDiscribe isEqualToString:@"min"]) {
        [historyArr removeObject:[historyArr firstObject]];
    }
    if ([maxDiscribe isEqualToString:@"max"]) {
        [historyArr removeObject:[historyArr lastObject]];
    }
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否需要保存当前随机数组" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *sureAlertAction = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [historyArr addObjectsFromArray:arr];
        NSMutableArray *listArr = [[NSMutableArray alloc] initWithArray:[weakSelf sortingByArr:historyArr type:NSOrderedDescending]];
        if (weakSelf.redCollecArr.count != 0 && weakSelf.blueCollecArr.count != 0) {
            [weakSelf getBallProbabilityByArr:weakSelf.redCollecArr blueArr:weakSelf.blueCollecArr finishedBlock:^(NSDictionary *minDic, NSDictionary *maxDic) {
                
                [listArr insertObject:minDic atIndex:0];
                [listArr addObject:maxDic];
            }];
        }
        [YXProbabilityManager sharedManager].randomListArr = (NSArray *)listArr;
        [weakSelf changeBmobValueHTTP:[YXProbabilityManager sharedManager].randomListArr];
        [weakSelf showChance];
    }];
    [sureAlertAction setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    [alertVC addAction:sureAlertAction];
    
    UIAlertAction *cancelAlertAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [cancelAlertAction setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    [alertVC addAction:cancelAlertAction];
    
    [self presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark - 清除提示弹窗
- (void)removeAlertView:(void(^)(BOOL isFinished))finishedBlock {
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否需要清除数组缓存" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *sureAlertAction = [UIAlertAction actionWithTitle:@"清除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSString *path = [NSString stringWithFormat:@"%@/%@", kYXToolLocalSaveDocDirectoryPath, kRandomListArr];
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
        }
        if (finishedBlock) {
            finishedBlock(YES);
        }
    }];
    [sureAlertAction setValue:[UIColor redColor] forKey:@"titleTextColor"];
    [alertVC addAction:sureAlertAction];
    
    UIAlertAction *cancelAlertAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        if (finishedBlock) {
            finishedBlock(NO);
        }
    }];
    [cancelAlertAction setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    [alertVC addAction:cancelAlertAction];
    
    [self presentViewController:alertVC animated:YES completion:nil];
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

#pragma mark - 获取蓝球、红球数字机率
- (void)getBallProbabilityByArr:(NSMutableArray *)redArr blueArr:(NSMutableArray *)blueArr finishedBlock:(void(^)(NSDictionary *minDic, NSDictionary *maxDic))finishedBlock {
    
    NSLog(@"开始获取蓝球、红球数字机率！");
    NSMutableArray *redDicArr = [[NSMutableArray alloc] initWithArray:[self sortingByArr:(NSArray *)[self statisticalRepeatNum:redArr] type:NSOrderedAscending]];
    NSMutableArray *blueDicArr = [[NSMutableArray alloc] initWithArray:[self sortingByArr:(NSArray *)[self statisticalRepeatNum:blueArr] type:NSOrderedAscending]];
    
    NSInteger redMin = redDicArr.count < 6 ? redDicArr.count : 6;
    NSInteger redMax = redDicArr.count > 6 ? redDicArr.count - 6 : redDicArr.count;
    NSArray *minRedArr = [redDicArr subarrayWithRange:NSMakeRange(0, redMin)];
    NSArray *maxRedArr = [redDicArr subarrayWithRange:NSMakeRange(redMax, redMin)];
    
    NSInteger blueMin = blueDicArr.count < 1 ? blueDicArr.count : 1;
    NSInteger blueMax = blueDicArr.count > 1 ? blueDicArr.count - 1 : blueDicArr.count;
    NSArray *minBlueArr = [blueDicArr subarrayWithRange:NSMakeRange(0, blueMin)];
    NSArray *maxBlueArr = [blueDicArr subarrayWithRange:NSMakeRange(blueMax, blueMin)];
    
    NSMutableArray *minArr = [[NSMutableArray alloc] init];
    [minRedArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        [minArr addObject:[obj objectForKey:kPieChartLineGraphicsName]];
    }];
    NSArray *minDescArr = [self sortingByArr:(NSArray *)minArr type:NSOrderedDescending];
    minArr = [[NSMutableArray alloc] initWithArray:minDescArr];
    [minBlueArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        [minArr addObject:[obj objectForKey:kPieChartLineGraphicsName]];
    }];
    
    NSMutableArray *maxArr = [[NSMutableArray alloc] init];
    [maxRedArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        [maxArr addObject:[obj objectForKey:kPieChartLineGraphicsName]];
    }];
    NSArray *maxDescArr = [self sortingByArr:(NSArray *)maxArr type:NSOrderedDescending];
    maxArr = [[NSMutableArray alloc] initWithArray:maxDescArr];
    [maxBlueArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        [maxArr addObject:[obj objectForKey:kPieChartLineGraphicsName]];
    }];
    
    NSString *minShow = [minArr componentsJoinedByString:@" "];
    NSString *maxShow = [maxArr componentsJoinedByString:@" "];
    
    NSDictionary *minShowDic = @{kPieChartLineGraphicsName:minShow, kPieChartLineGraphicsValue:@"min"};
    NSDictionary *maxShowDic = @{kPieChartLineGraphicsName:maxShow, kPieChartLineGraphicsValue:@"max"};
    if (finishedBlock) {
        finishedBlock(minShowDic, maxShowDic);
    }
}

#pragma mark - 循环取数
- (void)getRandomCollectionByCount:(NSInteger)count {
    
    __weak typeof(self) weakSelf = self;
    
    if (count == 0) {
        [self showChance];
        return;
    }
    
    [_activityIndicatorView startAnimating];
    _begainTime = [[weakSelf currentTimeStr] integerValue];
    NSInteger calculateCount = count /kcalculateCount;
    dispatch_group_t group = dispatch_group_create();
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(kcalculateCount);
    for (int i = 0; i < kcalculateCount; i ++) {
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_group_async(group, queue, ^{

            dispatch_semaphore_signal(semaphore);
            for (int i = 0; i < calculateCount; i++) {
                if (weakSelf.boolCancel) {
                    break;
                }
                else {
                    [weakSelf getRandomByRedArr:weakSelf.redArr blueArr:weakSelf.blueArr];
                }
            }
        });
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{

        [weakSelf endCount];
    });
}

#pragma mark - 取随机数
- (void)getRandomByRedArr:(NSMutableArray *)redArr blueArr:(NSMutableArray *)blueArr {
    
    __weak typeof(self) weakSelf = self;
    
    NSMutableArray *randomArr = [[NSMutableArray alloc] init];
    NSMutableSet *randomSet = [[NSMutableSet alloc] init];

    while ([randomSet count] < 6) {
        NSInteger index = arc4random() %([redArr count] - 1);
        NSString *red = [redArr[index] integerValue] < 10 ? [NSString stringWithFormat:@"0%@", redArr[index]] : redArr[index];
        [randomSet addObject:red];
    }
    [randomArr addObjectsFromArray:[randomSet allObjects]];
    
    NSMutableArray *sortingArr = [[NSMutableArray alloc] initWithArray:[weakSelf sortingByArr:(NSArray *)randomArr type:NSOrderedDescending]];
    
    NSInteger index = arc4random() %([blueArr count] - 1);
    NSString *blue = [blueArr[index] integerValue] < 10 ? [NSString stringWithFormat:@"0%@", blueArr[index]] : blueArr[index];
    [sortingArr addObject:blue];
    
    NSString *randomStr = [sortingArr componentsJoinedByString:@" "];
    
    weakSelf.count ++;
    NSLog(@"randomStr == %@, count == %@", randomStr, @(weakSelf.count));
    dispatch_async(dispatch_get_main_queue(), ^{

        [weakSelf.redCollecArr addObjectsFromArray:randomArr];
        [weakSelf.blueCollecArr addObject:blue];
        
        [weakSelf.resultRandomArr addObject:randomStr];
        weakSelf.headerView.prgressValue = (float)weakSelf.count /weakSelf.cycleCount;
    });
}

#pragma mark - 去重并统计重复的数
- (NSMutableArray *)statisticalRepeatNum:(NSMutableArray *)arr {
    
    NSMutableArray *amountArr = [[NSMutableArray alloc] init];

    NSCountedSet *countSet = [[NSCountedSet alloc] initWithArray:(NSArray *)arr];
    for (id item in countSet) { //去重并统计
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:item forKey:kPieChartLineGraphicsName];
        [dic setObject:@([countSet countForObject:item]) forKey:kPieChartLineGraphicsValue];
        [amountArr addObject:dic];
    }
    
    return amountArr;
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

#pragma mark - 组装数据
- (void)assemblyValueByArr:(NSMutableArray *)arr min:(NSInteger)min {
    
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
    
    NSInteger showCount = kShowCount;
    NSMutableArray *modelArr = [YXProbabilityListArrModel arrayOfModelsFromDictionaries:endArr];
    NSInteger max = modelArr.count > showCount ? modelArr.count - showCount : modelArr.count;
    NSArray *minArr = [modelArr subarrayWithRange:NSMakeRange(0, min)];
    NSArray *maxArr = [modelArr subarrayWithRange:NSMakeRange(max, min)];
    
    _endArr = [[NSMutableArray alloc] initWithObjects:minArr, maxArr, nil];
    [_tableView reloadData];
    
    [self reloadAlertView];
}

#pragma mark - 跳转至比较页面
- (void)pushToCompareVC {
    
    YXProbabilityCompareVC *vc = [[YXProbabilityCompareVC alloc] init];
    vc.randomArr = _endArr;
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
    [cell reloadValueByIndexPath:indexPath arr:_endArr[indexPath.section]];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, tableView.sectionHeaderHeight)];
    titleLab.textAlignment = NSTextAlignmentLeft;
    titleLab.textColor = [UIColor blackColor];
    titleLab.font = [UIFont boldSystemFontOfSize:14];
    switch (section) {
        case 0:
            titleLab.text = @"  出现频率最小";
            break;
        case 1:
            titleLab.text = @"  出现频率最大";
            break;
        default:
            break;
    }
    
    return titleLab;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 44;
}

#pragma mark - 初始化视图
- (void)initView {
    
    __weak typeof(self) weakSelf = self;
    
    NSLog(@"当前已统计 %@ 个", @([YXProbabilityManager sharedManager].randomListArr.count));
    
    _headerView = [[[NSBundle mainBundle] loadNibNamed:[YXProbabilityRandomHeaderView.class description] owner:self options:nil] lastObject];
    _headerView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 100);
    _headerView.yxProbabilityRandomHVBlock = ^{
      
        [weakSelf initDataSource];
        [weakSelf getRandomCollectionByCount:weakSelf.cycleCount];
    };
    _headerView.yxProbabilityRandomHVEndBlock = ^{
      
        weakSelf.boolCancel = YES;
    };
    _headerView.yxProbabilityRandomHVCompareBlock = ^{
      
        [weakSelf pushToCompareVC];
    };
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.yxNaviHeight, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - self.yxNaviHeight) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
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
    
    _count = [YXProbabilityManager sharedManager].randomListArr.count;
    NSInteger count = kCycleCount - _count;
    _cycleCount = count > 0 ? count : 0;
    _resultRandomArr = [[NSMutableArray alloc] init];
    _redArr = [[NSMutableArray alloc] init];
    _blueArr = [[NSMutableArray alloc] init];
    _redCollecArr = [[NSMutableArray alloc] init];
    _blueCollecArr = [[NSMutableArray alloc] init];
    _endArr = [[NSMutableArray alloc] init];
    _boolCancel = NO;
    
    for (NSInteger i = 1; i <= 33; i ++) {
        [_redArr addObject:@(i)];
    }
    for (NSInteger i = 1; i <= 16; i ++) {
        [_blueArr addObject:@(i)];
    }
    
    NSLog(@"当前已统计 %@ 个", @(_count));
}

@end
