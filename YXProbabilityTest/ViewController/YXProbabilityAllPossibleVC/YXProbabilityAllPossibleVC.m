//
//  YXProbabilityAllPossibleVC.m
//  YXProbabilityTest
//
//  Created by ios on 2021/6/18.
//  Copyright © 2021 August. All rights reserved.
//

#import "YXProbabilityAllPossibleVC.h"
#import "YXProbabilityRandomHeaderView.h"
#import "YXProbabilityAllPossibleCell.h"
#import "NSObject+YXCategory.h"
#import "YXProbabilityManager.h"
#import "YXProbabilityAllSecView.h"

#define kCycleCount 100000
#define kCalculateCount 5

/** 往上排查的期数 */
#define kOldArrCompareNum 3
/** 排查相同位数 */
#define kOldArrCompareCount 2

@interface YXProbabilityAllPossibleVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) YXProbabilityRandomHeaderView *headerView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

@property (nonatomic, strong) NSMutableArray *redArr; //红球集合
@property (nonatomic, strong) NSMutableArray *blueArr; //蓝球集合
@property (nonatomic, strong) NSMutableArray *resultRandomArr; //随机结果球集合
@property (nonatomic, strong) NSMutableArray *resultArr; //结果球集合

@property (nonatomic, assign) BOOL boolCancel; //是否结束
@property (nonatomic, assign) NSInteger count; //计数

@property (nonatomic, strong) NSMutableArray *oldArr; //往期数据集合

@property (nonatomic, assign) NSInteger textFieldEndCurrent; //筛选结果当前显示
@property (nonatomic, strong) NSMutableArray *textFieldEndArr; //筛选结果数组

@end

@implementation YXProbabilityAllPossibleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"随机统计";
    
    [self initView];
}

#pragma mark - 循环取数
- (void)getRandomCollectionByCount:(NSInteger)count {
    
    __weak typeof(self) weakSelf = self;
    
    [self.activityIndicatorView startAnimating];
    NSInteger calculateCount = count /kCalculateCount;
    dispatch_group_t group = dispatch_group_create();
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(kCalculateCount);
    for (int i = 0; i < kCalculateCount; i ++) {
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_group_async(group, queue, ^{

            dispatch_semaphore_signal(semaphore);
            
            for (int i = 0; i < calculateCount; i++) {
                if (weakSelf.boolCancel) {
                    break;
                }
                else {
                    @synchronized (weakSelf) {
                        [weakSelf getRandomByRedArr:weakSelf.redArr blueArr:weakSelf.blueArr randomCount:kCycleCount];
                    }
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
    dispatch_async(dispatch_get_main_queue(), ^{

        [weakSelf.resultRandomArr addObject:randomStr];
        weakSelf.headerView.prgressValue = (float)weakSelf.count /kCycleCount;
    });
}

#pragma mark - 排序
- (NSArray *)sortingByArr:(NSArray *)arr type:(NSComparisonResult)type {
    
    NSArray *resultArray = [arr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        if ([obj1 isKindOfClass:[YXProbabilityAllPossibleModel class]]) {
            YXProbabilityAllPossibleModel *model1 = obj1;
            YXProbabilityAllPossibleModel *model2 = obj2;
            NSNumber *number1 = @(model1.money);
            NSNumber *number2 = @(model2.money);
            
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

#pragma mark - 结束
- (void)endCount {
    
    __weak typeof(self) weakSelf = self;
    
    [self.activityIndicatorView startAnimating];
    NSLog(@"开始统计！");
    
    NSInteger breakUpNum = kCycleCount > 10000000 ? kCalculateCount *10 : kCalculateCount;
    NSMutableArray *breakUpArr = [self breakUpSuperArrToSonArrBySubSize:kCycleCount /breakUpNum arr:self.resultRandomArr];
    NSLog(@"拆分完成！开始数组去重");
    
    NSMutableArray *repeatNumArr = [[NSMutableArray alloc] init];
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(breakUpArr.count);
    for (NSInteger i = 0; i < breakUpArr.count; i ++) {
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_group_async(group, queue, ^{

            dispatch_semaphore_signal(semaphore);
            
            @synchronized(weakSelf) {
                [repeatNumArr addObjectsFromArray:[YXProbabilityAllPossibleModel arrayOfModelsFromDictionaries:(NSArray *)[weakSelf statisticalRepeatNum:breakUpArr[i]]]];
            }
        });
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        
        NSLog(@"拆分统计完成，开始合并统计!");
        
        NSMutableArray *endArr = [[NSMutableArray alloc] initWithArray:[weakSelf sortingByArr:(NSArray *)[weakSelf statisticalRepeatNumByModelArr:repeatNumArr] type:NSOrderedAscending]];
        
        dispatch_queue_t queue = dispatch_queue_create("com.resultArrCountQueue", DISPATCH_QUEUE_CONCURRENT);
        dispatch_async(queue, ^{
            
            weakSelf.resultArr = [[NSMutableArray alloc] initWithArray:(NSArray *)endArr];
            NSLog(@"合并统计排序完成！结果个数 == %@", @(weakSelf.resultArr.count));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [weakSelf.activityIndicatorView stopAnimating];
                if (weakSelf.resultArr.count != 0) {
                    [weakSelf.tableView reloadData];
                }
                else {
                    NSLog(@"数组为空！");
                    [weakSelf presentAlertByMsg:@"数组为空！" boolCancel:NO sureBlock:^{
                      
                        [weakSelf.navigationController popViewControllerAnimated:YES];
                    }];
                }
            });
        });
    });
}

#pragma mark - 拆分数组
- (NSMutableArray *)breakUpSuperArrToSonArrBySubSize:(NSInteger)subSize arr:(NSMutableArray *)arr {
    
    unsigned long breakUpCount = arr.count %subSize == 0 ? (arr.count /subSize) : (arr.count /subSize + 1);
    NSMutableArray *breakUpArr = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < breakUpCount; i ++) {
        NSInteger index = i *subSize;
        NSMutableArray *subArr = [[NSMutableArray alloc] init];
        [subArr removeAllObjects];
        
        NSInteger j = index;
        while (j < subSize *(i + 1) && j < arr.count) {
            [subArr addObject:[arr objectAtIndex:j]];
            j += 1;
        }
        [breakUpArr addObject:[subArr copy]];
    }
    
    return [breakUpArr copy];
}

#pragma mark - 数组去重并统计重复的数，包括 4-7
- (NSMutableArray *)statisticalRepeatNum:(NSMutableArray *)arr {
    
    NSMutableArray *fourArr = [[NSMutableArray alloc] init];
    NSMutableArray *fiveArr = [[NSMutableArray alloc] init];
    NSMutableArray *sixArr = [[NSMutableArray alloc] init];
    NSMutableArray *sevenArr = [[NSMutableArray alloc] init];
    for (NSString *value in arr) {
        [fourArr addObject:[value substringToIndex:11]];
        [fiveArr addObject:[value substringToIndex:14]];
        [sixArr addObject:[value substringToIndex:17]];
        [sevenArr addObject:[value substringToIndex:20]];
    }
    
    NSMutableArray *amountArr = [[NSMutableArray alloc] init];
    
    NSCountedSet *fourSet = [[NSCountedSet alloc] initWithArray:(NSArray *)fourArr];
    NSCountedSet *fiveSet = [[NSCountedSet alloc] initWithArray:(NSArray *)fiveArr];
    NSCountedSet *sixSet = [[NSCountedSet alloc] initWithArray:(NSArray *)sixArr];
    NSCountedSet *sevenSet = [[NSCountedSet alloc] initWithArray:(NSArray *)sevenArr];
    
    for (NSString *item in sevenSet) { //去重并统计
        NSInteger fourCount = [fourSet countForObject:[item substringToIndex:11]];
        NSInteger fiveCount = [fiveSet countForObject:[item substringToIndex:14]];
        NSInteger sixCount = [sixSet countForObject:[item substringToIndex:17]];
        NSInteger sevenCount = [sevenSet countForObject:[item substringToIndex:20]];
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:item forKey:kAllItem];
        [dic setObject:@(fourCount) forKey:kFourCount];
        [dic setObject:@(fiveCount) forKey:kFiveCount];
        [dic setObject:@(sixCount) forKey:kSixCount];
        [dic setObject:@(sevenCount) forKey:kSevenCount];
        [amountArr addObject:dic];
    }
    return amountArr;
}

#pragma mark - 字典去重并统计重复的数，包括 4-7
- (NSMutableArray *)statisticalRepeatNumByModelArr:(NSMutableArray *)modelArr {
    
    NSMutableArray *fourArr = [[NSMutableArray alloc] init];
    NSMutableArray *fiveArr = [[NSMutableArray alloc] init];
    NSMutableArray *sixArr = [[NSMutableArray alloc] init];
    NSMutableArray *sevenArr = [[NSMutableArray alloc] init];
    for (YXProbabilityAllPossibleModel *model in modelArr) {
        [fourArr addObject:[model.item substringToIndex:11]];
        [fiveArr addObject:[model.item substringToIndex:14]];
        [sixArr addObject:[model.item substringToIndex:17]];
        [sevenArr addObject:[model.item substringToIndex:20]];
    }
    
    NSCountedSet *fourSet = [[NSCountedSet alloc] initWithArray:(NSArray *)fourArr];
    NSCountedSet *fiveSet = [[NSCountedSet alloc] initWithArray:(NSArray *)fiveArr];
    NSCountedSet *sixSet = [[NSCountedSet alloc] initWithArray:(NSArray *)sixArr];
    NSCountedSet *sevenSet = [[NSCountedSet alloc] initWithArray:(NSArray *)sevenArr];
    
    NSMutableArray *amountArr = [[NSMutableArray alloc] init];
    NSMutableArray *endArr = [[NSMutableArray alloc] init];
    for (YXProbabilityAllPossibleModel *model in modelArr) { //去重并统计
        NSInteger fourCount = [fourSet countForObject:[model.item substringToIndex:11]];
        if (fourCount < 2) {
            endArr = [self assemblyEndArrByModel:model fourCount:fourCount fiveCount:model.fiveCount sixCount:model.sixCount sevenCount:model.sevenCount arr:amountArr];
            continue;
        }
        NSInteger fiveCount = [fiveSet countForObject:[model.item substringToIndex:14]];
        if (fiveCount < 2) {
            endArr = [self assemblyEndArrByModel:model fourCount:fourCount fiveCount:fiveCount sixCount:model.sixCount sevenCount:model.sevenCount arr:amountArr];
            continue;
        }
        NSInteger sixCount = [sixSet countForObject:[model.item substringToIndex:17]];
        if (sixCount < 2) {
            endArr = [self assemblyEndArrByModel:model fourCount:fourCount fiveCount:fiveCount sixCount:sixCount sevenCount:model.sevenCount arr:amountArr];
            continue;
        }
        NSInteger sevenCount = [sevenSet countForObject:[model.item substringToIndex:20]];
        if (sevenCount < 2) {
            endArr = [self assemblyEndArrByModel:model fourCount:fourCount fiveCount:fiveCount sixCount:sixCount sevenCount:sevenCount arr:amountArr];
            continue;
        }
        
        endArr = [self assemblyEndArrByModel:model fourCount:fourCount fiveCount:fiveCount sixCount:sixCount sevenCount:sevenCount arr:amountArr];
    }
    return endArr;
}

#pragma mark - 计算最终统计
- (NSMutableArray *)assemblyEndArrByModel:(YXProbabilityAllPossibleModel *)model fourCount:(NSInteger)fourCount fiveCount:(NSInteger)fiveCount sixCount:(NSInteger)sixCount sevenCount:(NSInteger)sevenCount arr:(NSMutableArray *)arr {
    
    //传入数量小于2时 则不用增加计数
    YXProbabilityAllPossibleModel *endModel = [[YXProbabilityAllPossibleModel alloc] init];
    endModel.item = model.item;
    endModel.fourCount = model.fourCount + fourCount < 2 ? 0 : fourCount;
    endModel.fiveCount = model.fiveCount + fiveCount < 2 ? 0 : fiveCount;
    endModel.sixCount = model.sixCount + sixCount < 2 ? 0 : sixCount;
    endModel.sevenCount = model.sevenCount + sevenCount < 2 ? 0 : sevenCount;
    
    if ([self endValueFilterByModel:endModel]) {
        endModel.money = endModel.fourCount *10 + endModel.fiveCount *200 + endModel.sixCount *150000 + endModel.sevenCount *5000000;
        [arr addObject:endModel];
    }
    return arr;
}

#pragma mark - 最终结果筛选条件
- (BOOL)endValueFilterByModel:(YXProbabilityAllPossibleModel *)model {
    
    //四位相同总数 > 五位相同总数 > 六位相同总数 > 七位相同总数
    if (((model.fourCount > model.fiveCount) && (model.fiveCount > model.sixCount) && (model.sixCount > model.sevenCount))) {
        //四位相同总数 != 0 且 2000 >= 五位相同总数 >= 800 且 200 >= 六位相同总数 >= 60 且 20 >= 七位相同总数
        if ((model.fourCount != 0) && (model.fiveCount >= 800 && model.fiveCount <= 2000) && (model.sixCount >= 60 && model.sixCount <= 200) && (model.sevenCount <= 20)) {
            //本期数与上期数对比，相同数 <= kOldArrCompareCount 且 本期蓝球 != 上期蓝球
            if (![self getNowValueSameToOldValueByNowValue:model.item] && ![self getBlueBallBoolSameByNowValue:model.item]) {
                return YES;
            }
        }
    }
    return NO;
}

#pragma mark - 获取当前数值与上期数值相同位数（往上 kOldArrCompareNum 期排查）
- (BOOL)getNowValueSameToOldValueByNowValue:(NSString *)nowValue {
    
    NSArray *nowArr = [nowValue componentsSeparatedByString:@" "];
    NSArray *valueArr = [self.oldArr subarrayWithRange:NSMakeRange(0, kOldArrCompareNum)];
    for (NSArray *arr in valueArr) {
        NSInteger i = 0;
        for (NSString *last in arr) {
            for (NSString *now in nowArr) {
                if ([last isEqualToString:now]) {
                    i++;
                    if (i > kOldArrCompareCount) { return YES; }
                }
            }
        }
    }
    
    return NO;
}

#pragma mark - 获取蓝色球是否相同（往上 kOldArrCompareNum 期排查）
- (BOOL)getBlueBallBoolSameByNowValue:(NSString *)nowValue {
    
    NSArray *nowArr = [nowValue componentsSeparatedByString:@" "];
    NSArray *valueArr = [self.oldArr subarrayWithRange:NSMakeRange(0, kOldArrCompareNum)];
    for (NSArray *arr in valueArr) {
        if ([[arr lastObject] isEqualToString:[nowArr lastObject]]) {
            return YES;
        }
    }
    
    return NO;
}

#pragma mark - 弹窗
- (void)presentAlertByMsg:(NSString *)msg boolCancel:(BOOL)boolCancel sureBlock:(void(^)(void))sureBlock {
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *sureAlertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if (sureBlock) {
            sureBlock();
        }
    }];
    [sureAlertAction setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    [alertVC addAction:sureAlertAction];
    
    UIAlertAction *cancelAlertAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
    [cancelAlertAction setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    if (boolCancel) [alertVC addAction:cancelAlertAction];
    
    [self presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.resultArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YXProbabilityAllPossibleCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YXProbabilityAllPossibleCell class])];
    
    if (_textFieldEndCurrent == indexPath.row && _textFieldEndArr.count != 0) {
        cell.collectionView.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.1];
        [_activityIndicatorView stopAnimating];
    }
    else {
        cell.collectionView.backgroundColor = [UIColor whiteColor];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YXProbabilityAllPossibleCell *allCell = (YXProbabilityAllPossibleCell *)cell;
    [allCell reloadValueByIndexPath:indexPath arr:self.resultArr];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    YXProbabilityAllSecView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([YXProbabilityAllSecView class])];
    
    if (self.resultArr.count != 0) [view reloadValueBySec:section arr:self.resultArr tableView:tableView];
    
    __weak typeof(self) weakSelf = self;
    view.yxProbabilityAllSecViewBlock = ^(NSInteger current, NSMutableArray * _Nonnull endArr) {
      
        weakSelf.textFieldEndCurrent = current;
        weakSelf.textFieldEndArr = endArr;
    };
    
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 100;
}

#pragma mark - 初始化视图
- (void)initView {
    
    _textFieldEndArr = [[NSMutableArray alloc] init];
    
    [self.tableView reloadData];
}

#pragma mark - 懒加载
- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.yxNaviHeight, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - self.yxNaviHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 100;
        _tableView.tableHeaderView = self.headerView;
        [self.view addSubview:_tableView];
        
        [_tableView registerNib:[UINib nibWithNibName:[YXProbabilityAllPossibleCell.class description] bundle:nil] forCellReuseIdentifier:NSStringFromClass([YXProbabilityAllPossibleCell class])];
        [_tableView registerNib:[UINib nibWithNibName:[YXProbabilityAllSecView.class description] bundle:nil] forHeaderFooterViewReuseIdentifier:NSStringFromClass([YXProbabilityAllSecView class])];
    }
    return _tableView;
}
- (YXProbabilityRandomHeaderView *)headerView {
    
    if (!_headerView) {
        __weak typeof(self) weakSelf = self;
        
        _headerView = [[[NSBundle mainBundle] loadNibNamed:[YXProbabilityRandomHeaderView.class description] owner:self options:nil] lastObject];
        _headerView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 100);
        _headerView.compareBtn.hidden = YES;
        _headerView.yxProbabilityRandomHVBlock = ^{
          
            [weakSelf getRandomCollectionByCount:kCycleCount];
        };
        _headerView.yxProbabilityRandomHVEndBlock = ^{
          
            weakSelf.boolCancel = YES;
        };
    }
    return _headerView;
}
- (UIActivityIndicatorView *)activityIndicatorView {
    
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _activityIndicatorView.center = self.view.center;
        _activityIndicatorView.color = [UIColor redColor];
        [self.view addSubview:_activityIndicatorView];
    }
    return _activityIndicatorView;
}
- (NSMutableArray *)redArr {
    
    if (!_redArr) {
        _redArr = [[NSMutableArray alloc] init];
        for (NSInteger i = 1; i <= 33; i ++) {
            [_redArr addObject:@(i)];
        }
    }
    return _redArr;
}
- (NSMutableArray *)blueArr {
    
    if (!_blueArr) {
        _blueArr = [[NSMutableArray alloc] init];
        for (NSInteger i = 1; i <= 16; i ++) {
            [_blueArr addObject:@(i)];
        }
    }
    return _blueArr;
}
- (NSMutableArray *)resultRandomArr {
    
    if (!_resultRandomArr) {
        _resultRandomArr = [[NSMutableArray alloc] init];
    }
    return _resultRandomArr;
}
- (NSMutableArray *)resultArr {
    
    if (!_resultArr) {
        _resultArr = [[NSMutableArray alloc] init];
    }
    return _resultArr;
}
- (NSMutableArray *)oldArr {
    
    if (!_oldArr) {
        _oldArr = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in [[YXProbabilityManager sharedManager] allArr]) {
            NSMutableArray *valueArr = [[NSMutableArray alloc] init];
            for (NSDictionary *valueDic in [dic objectForKey:kValueArr]) {
                [valueArr addObject:[valueDic objectForKey:kValue]];
            }
            [_oldArr addObject:valueArr];
        }
    }
    return _oldArr;
}

@end
