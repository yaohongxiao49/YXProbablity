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

#define kCycleCount 50000000
#define kcalculateCount 4

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
    NSInteger calculateCount = count /kcalculateCount;
    dispatch_group_t group = dispatch_group_create();
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(kcalculateCount);
    for (int i = 0; i < kcalculateCount; i ++) {
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_group_async(group, queue, ^{

            dispatch_semaphore_signal(semaphore);
            __strong typeof(weakSelf) strongSelf = weakSelf;
            
            for (int i = 0; i < calculateCount; i++) {
                if (strongSelf.boolCancel) {
                    break;
                }
                else {
                    [strongSelf getRandomByRedArr:strongSelf.redArr blueArr:strongSelf.blueArr randomCount:kCycleCount];
                }
            }
        });
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{

        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        [strongSelf endCount];
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

        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        [strongSelf.resultRandomArr addObject:randomStr];
        strongSelf.headerView.prgressValue = (float)strongSelf.count /kCycleCount;
    });
}

#pragma mark - 排序
- (NSArray *)sortingByArr:(NSArray *)arr type:(NSComparisonResult)type {
    
    NSArray *resultArray = [arr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        if ([obj1 isKindOfClass:[YXProbabilityAllPossibleModel class]]) {
            YXProbabilityAllPossibleModel *model1 = obj1;
            YXProbabilityAllPossibleModel *model2 = obj2;
            NSNumber *number1 = @(model1.fourCount);
            NSNumber *number2 = @(model2.fourCount);
            
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
    
    NSMutableArray *breakUpArr = [self breakUpSuperArrToSonArrBySubSize:(kCycleCount /kcalculateCount) arr:self.resultRandomArr];
    NSLog(@"拆分完成!");
    
    NSMutableArray *repeatNumArr = [[NSMutableArray alloc] init];
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(kcalculateCount);
    for (int i = 0; i < kcalculateCount; i ++) {
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_group_async(group, queue, ^{

            dispatch_semaphore_signal(semaphore);
            __strong typeof(weakSelf) strongSelf = weakSelf;
            
            [repeatNumArr addObjectsFromArray:[YXProbabilityAllPossibleModel arrayOfModelsFromDictionaries:(NSArray *)[strongSelf statisticalRepeatNum:breakUpArr[i]]]];
        });
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{

        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        NSLog(@"拆分统计完成，开始合并统计!");
        
        NSMutableArray *endArr = [[NSMutableArray alloc] initWithArray:[strongSelf sortingByArr:(NSArray *)[strongSelf statisticalRepeatNumByModelArr:repeatNumArr] type:NSOrderedDescending]];
        
        dispatch_queue_t queue = dispatch_queue_create("com.resultArrCountQueue", DISPATCH_QUEUE_CONCURRENT);
        dispatch_async(queue, ^{
            
            __strong typeof(weakSelf) strongSelf = weakSelf;
            
            strongSelf.resultArr = [[NSMutableArray alloc] initWithArray:(NSArray *)endArr];
            NSLog(@"合并统计排序完成！结果个数 == %@", @(strongSelf.resultArr.count));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [strongSelf.activityIndicatorView stopAnimating];
                if (strongSelf.resultArr.count != 0) {
                    [strongSelf.tableView reloadData];
                }
                else {
                    NSLog(@"数组为空！");
                    [weakSelf presentAlertByMsg:@"数组为空！" boolCancel:NO sureBlock:^{
                      
                        [strongSelf.navigationController popViewControllerAnimated:YES];
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
    
    YXProbabilityAllPossibleModel *endModel = [[YXProbabilityAllPossibleModel alloc] init];
    endModel.item = model.item;
    endModel.fourCount = model.fourCount + fourCount < 2 ? 0 : fourCount;
    endModel.fiveCount = model.fiveCount + fiveCount < 2 ? 0 : fiveCount;
    endModel.sixCount = model.sixCount + sixCount < 2 ? 0 : sixCount;
    endModel.sevenCount = model.sevenCount + sevenCount < 2 ? 0 : sevenCount;
    
    if (((endModel.fourCount > endModel.fiveCount) && (endModel.fiveCount > endModel.sixCount) && (endModel.sixCount > endModel.sevenCount))) {
        if ((endModel.fourCount != 0) && (endModel.fiveCount >= 800 && endModel.fourCount <= 2000) && (endModel.sixCount >= 60 && endModel.sixCount <= 200) && (endModel.sevenCount <= 20)) {
            [arr addObject:endModel];
        }
    }
    return arr;
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
    [cell reloadValueByIndexPath:indexPath arr:self.resultArr];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
}

#pragma mark - 初始化视图
- (void)initView {
    
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
          
            __strong typeof(weakSelf) strongSelf = weakSelf;
            
            [strongSelf getRandomCollectionByCount:kCycleCount];
        };
        _headerView.yxProbabilityRandomHVEndBlock = ^{
          
            __strong typeof(weakSelf) strongSelf = weakSelf;
            
            strongSelf.boolCancel = YES;
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

@end
