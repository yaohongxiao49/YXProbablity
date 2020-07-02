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
#import "YXPicChartGraphicsModel.h"
#import "YXProbabilityRandomHeaderView.h"
#import "YXProbabilityAllListCell.h"

#define kCycleCount 189704646
#define kcalculateCount 10

@interface YXProbabilityRandomVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, copy) NSMutableArray *redArr;
@property (nonatomic, copy) NSMutableArray *blueArr;
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
                [weakSelf.activityIndicatorView stopAnimating];
            }];
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

#pragma mark - 显示出现频率最高的5位以及出现频率最低的五位
- (void)showChance {
    
    NSArray *arr = [[NSArray alloc] initWithArray:[YXProbabilityManager sharedManager].randomListArr];
    
    NSInteger min = arr.count < 5 ? arr.count : 5;
    NSInteger max = arr.count > 5 ? arr.count - 5 : arr.count;
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
        NSArray *sortingArr = [[NSArray alloc] initWithArray:[weakSelf sortingByArr:repeatNumArr]];
        NSLog(@"结果数组个数 == %@", @(repeatNumArr.count));
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (sortingArr.count != 0) {
                [weakSelf.activityIndicatorView stopAnimating];
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
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否需要保存当前随机数组" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *sureAlertAction = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [historyArr addObjectsFromArray:arr];
        
        [YXProbabilityManager sharedManager].randomListArr = [weakSelf sortingByArr:historyArr];
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
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"界面已更新" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *sureAlertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [sureAlertAction setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    [alertVC addAction:sureAlertAction];
    
    [self presentViewController:alertVC animated:YES completion:nil];
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
    
    for (int i = 0; i < 6; i++) {
        NSInteger index = arc4random() %([redArr count] - 1);
        NSString *red = [redArr[index] integerValue] < 10 ? [NSString stringWithFormat:@"0%@", redArr[index]] : redArr[index];
        [randomArr addObject:red];
    }
    
    NSInteger index = arc4random() %([blueArr count] - 1);
    NSString *blue = [blueArr[index] integerValue] < 10 ? [NSString stringWithFormat:@"0%@", blueArr[index]] : blueArr[index];
    [randomArr addObject:blue];
    
    NSString *randomStr = [randomArr componentsJoinedByString:@" "];
    
    weakSelf.count ++;
    NSLog(@"randomStr == %@, count == %@", randomStr, @(weakSelf.count));
    dispatch_async(dispatch_get_main_queue(), ^{

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
        [dic setObject:item forKey:kGraphicsTitle];
        [dic setObject:@([countSet countForObject:item]) forKey:kGraphicsCount];
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

#pragma mark - 组装数据
- (void)assemblyValueByArr:(NSMutableArray *)arr min:(NSInteger)min {
    
    NSMutableArray *endArr = [[NSMutableArray alloc] init];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        NSMutableDictionary *valueDic = [[NSMutableDictionary alloc] init];
        
        //组装出现频率信息
        NSString *occurrences = [obj objectForKey:kGraphicsCount];
        [valueDic setValue:occurrences forKey:kDate];
        
        //组装球信息
        NSString *ball = [obj objectForKey:kGraphicsTitle];
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
    NSInteger max = modelArr.count > 5 ? modelArr.count - 5 : modelArr.count;
    NSArray *minArr = [modelArr subarrayWithRange:NSMakeRange(0, min)];
    NSArray *maxArr = [modelArr subarrayWithRange:NSMakeRange(max, min)];
    
    _endArr = [[NSMutableArray alloc] initWithObjects:minArr, maxArr, nil];
    [_tableView reloadData];
    
    [self reloadAlertView];
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
    
    _headerView = [[[NSBundle mainBundle] loadNibNamed:[YXProbabilityRandomHeaderView.class description] owner:self options:nil] lastObject];
    _headerView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 80);
    _headerView.yxProbabilityRandomHVBlock = ^{
      
        [weakSelf initDataSource];
        [weakSelf getRandomCollectionByCount:weakSelf.cycleCount];
    };
    _headerView.yxProbabilityRandomHVEndBlock = ^{
      
        weakSelf.boolCancel = YES;
    };
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 100) style:UITableViewStylePlain];
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
