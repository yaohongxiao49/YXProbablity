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
#import "YXMinArrAssemblyMananger.h"

#define kCycleCount 10000000
#define kcalculateCount 4

#define kShowSecCount 2

#define kGetValuesCount @"1"

@interface YXProbabilityRandomVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, strong) NSMutableArray *redArr; //红球
@property (nonatomic, strong) NSMutableArray *blueArr; //蓝球
@property (nonatomic, strong) NSMutableArray *redCollecArr;
@property (nonatomic, strong) NSMutableArray *blueCollecArr;
@property (nonatomic, strong) NSMutableArray *resultRandomArr; //结果随机
@property (nonatomic, strong) NSMutableArray *endArr; //结果
@property (nonatomic, assign) NSInteger count; //计数
@property (nonatomic, strong) YXProbabilityRandomHeaderView *headerView;
@property (nonatomic, assign) BOOL boolCancel; //是否结束
@property (nonatomic, assign) NSInteger cycleCount; //周期计数
@property (nonatomic, assign) NSInteger diyCycleCount; //自定义周期计数

@property (nonatomic, assign) NSInteger begainTime;
@property (nonatomic, copy) NSArray *probabilityRedArr; //随机概率红球
@property (nonatomic, copy) NSArray *probabilityBlueArr; //随机概率蓝球

@property (nonatomic, strong) NSMutableArray *minArr; //只出现一次的数据集合
@property (nonatomic, strong) NSMutableArray *lastArr; //上一期数据集合

@end

@implementation YXProbabilityRandomVC

- (void)dealloc {
    
    [self removeAlertView:^(BOOL isFinished) {}];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    __weak typeof(self) weakSelf = self;
    
    if (self.vcType == YXProbabilityRandomVCTypeReal) {
        self.title = @"真实随机";
    }
    else {
        self.title = @"概率随机";
    }
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self removeAlertView:^(BOOL isFinished) {
       
        [weakSelf initView];
        if (!isFinished) {
            [weakSelf showChance];
        }
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
    
    __weak typeof(self) weakSelf = self;
    NSArray *arr;
    if (self.vcType == YXProbabilityRandomVCTypeReal) {
        arr = [[NSArray alloc] initWithArray:[YXProbabilityManager sharedManager].randomListArr];
    }
    else {
        arr = [[NSArray alloc] initWithArray:[YXProbabilityManager sharedManager].probablityRandomListArr];
    }
    if (arr.count == 0) {
        return;
    }
    
    NSInteger min = arr.count < kShowSecCount ? arr.count : kShowSecCount;
    NSInteger max = arr.count > kShowSecCount ? arr.count - kShowSecCount : arr.count;
    
    NSArray *countArr = kGetValuesCount.length != 0 ? [kGetValuesCount componentsSeparatedByString:@","] : @[];
    NSMutableArray *minRandomArr = [[NSMutableArray alloc] init];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        //判断所需出现次数数组是否为0，所需要显示次数是否为指定次数，是否排除上一期已经出现号数
        if (countArr.count != 0 && [[obj objectForKey:kPieChartLineGraphicsValue] integerValue] == [countArr[0] integerValue]) {
            if ([weakSelf getNowValueSameToOldValueByNowValue:[obj objectForKey:kPieChartLineGraphicsName]] <= 2) {
                [minRandomArr addObject:obj];
            }
        }
    }];
    
    NSArray *minArr = [arr subarrayWithRange:NSMakeRange(0, (min - 1))];
    NSArray *maxArr = [arr subarrayWithRange:NSMakeRange(max, min)];
    
    NSMutableArray *valueArr = [[NSMutableArray alloc] init];
    [valueArr addObjectsFromArray:minArr];
    //最小随机数组
    if (minRandomArr.count != 0) {
        NSInteger minRandomIndex = arc4random() %([minRandomArr count] - 1);
        NSArray *minRandomOneArr = [[NSArray alloc] initWithObjects:minRandomArr[minRandomIndex], nil];
        [valueArr addObjectsFromArray:minRandomOneArr];
    }
    [valueArr addObjectsFromArray:maxArr];
    
    [self assemblyValueByArr:valueArr min:min];
    if (arr.count != 0) [self assemblyEndMinValueByArr:[[YXMinArrAssemblyMananger sharedManager] assemblyRegularValueByArr:arr]];
    [_activityIndicatorView stopAnimating];
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
    
    NSLog(@"是否保存");
    __weak typeof(self) weakSelf = self;
    NSMutableArray *historyArr;
    if (self.vcType == YXProbabilityRandomVCTypeReal) {
        historyArr = [[NSMutableArray alloc] initWithArray:[YXProbabilityManager sharedManager].randomListArr];
    }
    else {
        historyArr = [[NSMutableArray alloc] initWithArray:[YXProbabilityManager sharedManager].probablityRandomListArr];
    }
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
        
        [weakSelf.activityIndicatorView startAnimating];
        [historyArr addObjectsFromArray:arr];
        NSMutableArray *listArr = [[NSMutableArray alloc] initWithArray:[weakSelf sortingByArr:historyArr type:NSOrderedDescending]];
        if (weakSelf.redCollecArr.count != 0 && weakSelf.blueCollecArr.count != 0) {
            [weakSelf getBallProbabilityByArr:weakSelf.redCollecArr blueArr:weakSelf.blueCollecArr finishedBlock:^(NSDictionary *minDic, NSDictionary *maxDic) {
                
                [listArr insertObject:minDic atIndex:0];
                [listArr addObject:maxDic];
            }];
        }
        if (self.vcType == YXProbabilityRandomVCTypeReal) {
            [YXProbabilityManager sharedManager].randomListArr = (NSArray *)listArr;
        }
        else {
            [YXProbabilityManager sharedManager].probablityRandomListArr = (NSArray *)listArr;
        }
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
        
        NSString *path = @"";
        if (self.vcType == YXProbabilityRandomVCTypeReal) {
            path = [NSString stringWithFormat:@"%@/%@", kYXToolLocalSaveDocDirectoryPath, kRandomListArr];
        }
        else {
            path = [NSString stringWithFormat:@"%@/%@", kYXToolLocalSaveDocDirectoryPath, kProbablityRandomListArr];
        }
        
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
    
    NSLog(@"界面已更新");
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
    NSMutableArray *redDicArr = [[NSMutableArray alloc] initWithArray:[self sortingByArr:(NSArray *)[self statisticalRepeatNum:redArr getValuesCount:kGetValuesCount] type:NSOrderedAscending]];
    NSMutableArray *blueDicArr = [[NSMutableArray alloc] initWithArray:[self sortingByArr:(NSArray *)[self statisticalRepeatNum:blueArr getValuesCount:kGetValuesCount] type:NSOrderedAscending]];
    
    NSInteger redMin = redDicArr.count < 6 ? redDicArr.count : 6;
    NSInteger redMax = redDicArr.count >= 6 ? redDicArr.count - 6 : redDicArr.count;
    NSArray *minRedArr = [redDicArr subarrayWithRange:NSMakeRange(0, redMin)];
    NSArray *maxRedArr = [redDicArr subarrayWithRange:NSMakeRange(redMax, redMin)];
    
    NSInteger blueMin = blueDicArr.count < 1 ? blueDicArr.count : 1;
    NSInteger blueMax = blueDicArr.count >= 1 ? blueDicArr.count - 1 : blueDicArr.count;
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
    _begainTime = [[self currentTimeStr] integerValue];
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
                    [weakSelf getRandomByRedArr:weakSelf.redArr blueArr:weakSelf.blueArr randomCount:weakSelf.diyCycleCount];
                }
            }
        });
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{

        [weakSelf endCount];
    });
}

#pragma mark - 取随机数
- (void)getRandomByRedArr:(NSMutableArray *)redArr blueArr:(NSMutableArray *)blueArr randomCount:(NSInteger)randomCount {
    
    __weak typeof(self) weakSelf = self;
    
    NSMutableArray *randomArr = [[NSMutableArray alloc] init];
    NSMutableSet *randomSet = [[NSMutableSet alloc] init];

    while ([randomSet count] < 6) {
        if (self.vcType == YXProbabilityRandomVCTypeReal) {
            NSInteger index = arc4random() %([redArr count] - 1);
            NSString *red = [redArr[index] integerValue] < 10 ? [NSString stringWithFormat:@"0%@", redArr[index]] : redArr[index];
            [randomSet addObject:red];
        }
        else { //组装概率数据
            [randomSet addObject:[YXProbabilityManager assemblyProbabilityArrByRandomCount:randomCount valueSet:randomSet probabilityArr:_probabilityRedArr boolRed:YES]];
        }
    }
    [randomArr addObjectsFromArray:[randomSet allObjects]];
    NSMutableArray *sortingArr = [[NSMutableArray alloc] initWithArray:[weakSelf sortingByArr:(NSArray *)randomArr type:NSOrderedDescending]];
    
    NSString *blue = @"";
    if (self.vcType == YXProbabilityRandomVCTypeReal) {
        NSInteger index = arc4random() %([blueArr count] - 1);
        blue = [blueArr[index] integerValue] < 10 ? [NSString stringWithFormat:@"0%@", blueArr[index]] : blueArr[index];
        [sortingArr addObject:blue];
    }
    else { //组装概率数据
        blue = [YXProbabilityManager assemblyProbabilityArrByRandomCount:randomCount valueSet:sortingArr probabilityArr:_probabilityBlueArr boolRed:NO];
    }
    
    NSString *randomStr = [sortingArr componentsJoinedByString:@" "];
    
    weakSelf.count ++;
    dispatch_async(dispatch_get_main_queue(), ^{

        [weakSelf.redCollecArr addObjectsFromArray:randomArr];
        [weakSelf.blueCollecArr addObject:blue];
        
        [weakSelf.resultRandomArr addObject:randomStr];
        weakSelf.headerView.prgressValue = (float)weakSelf.count /weakSelf.diyCycleCount;
    });
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

#pragma mark - 获取当前数值与上期数值相同位数
- (NSInteger)getNowValueSameToOldValueByNowValue:(NSString *)nowValue {
    
    NSInteger i = 0;
    NSArray *nowArr = [nowValue componentsSeparatedByString:@" "];
    for (NSString *last in _lastArr) {
        for (NSString *now in nowArr) {
            if ([last isEqualToString:now]) {
                i++;
            }
        }
    }
    
    return i;
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
    
    NSInteger showCount = kShowSecCount;
    NSMutableArray *modelArr = [YXProbabilityListArrModel arrayOfModelsFromDictionaries:endArr];
    NSInteger max = modelArr.count > showCount ? modelArr.count - showCount : modelArr.count;
    NSArray *minArr = [modelArr subarrayWithRange:NSMakeRange(0, min)];
    NSArray *maxArr = [modelArr subarrayWithRange:NSMakeRange(max, min)];
    
    _endArr = [[NSMutableArray alloc] initWithObjects:minArr, maxArr, nil];
    [_tableView reloadData];
    
    [self reloadAlertView];
}

- (void)assemblyEndMinValueByArr:(NSMutableArray *)arr {
    
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

    _minArr = [YXProbabilityListArrModel arrayOfModelsFromDictionaries:(NSArray *)endArr];
}

#pragma mark - 跳转至比较页面
- (void)pushToCompareVC {
    
    YXProbabilityCompareVC *vc = [[YXProbabilityCompareVC alloc] init];
    vc.randomArr = _endArr;
    vc.calculateRandomArr = _minArr;
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

#pragma mark - setting
- (void)setVcType:(YXProbabilityRandomVCType)vcType {
    
    _vcType = vcType;
}

#pragma mark - 初始化视图
- (void)initView {
    
    __weak typeof(self) weakSelf = self;
    
    if (self.vcType == YXProbabilityRandomVCTypeReal) {
        NSLog(@"当前已统计 %@ 个", @([YXProbabilityManager sharedManager].randomListArr.count));
    }
    else {
        NSLog(@"当前已统计 %@ 个", @([YXProbabilityManager sharedManager].probablityRandomListArr.count));
    }
    
    _headerView = [[[NSBundle mainBundle] loadNibNamed:[YXProbabilityRandomHeaderView.class description] owner:self options:nil] lastObject];
    _headerView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 100);
    _headerView.yxProbabilityRandomHVBlock = ^(NSInteger diyCount) {

        weakSelf.diyCycleCount = diyCount == 0 ? kCycleCount : diyCount;
        [weakSelf initDataSource];
        [weakSelf getRandomCollectionByCount:weakSelf.diyCycleCount];
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
    
    if (self.vcType == YXProbabilityRandomVCTypeReal) {
        _count = [YXProbabilityManager sharedManager].randomListArr.count;
    }
    else {
        _count = [YXProbabilityManager sharedManager].probablityRandomListArr.count;
        _probabilityRedArr = [YXProbabilityManager sharedManager].probabilityRedArr;
        _probabilityBlueArr = [YXProbabilityManager sharedManager].probabilityBlueArr;
    }
    
    _lastArr = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in [[[[YXProbabilityManager sharedManager] allArr] firstObject] objectForKey:kValueArr]) {
        [_lastArr addObject:[dic objectForKey:kValue]];
    }
    
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
