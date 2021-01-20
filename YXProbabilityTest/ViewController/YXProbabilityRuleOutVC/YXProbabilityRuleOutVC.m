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

@interface YXProbabilityRuleOutVC () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

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
@property (nonatomic, assign) NSInteger textfieldLenth; //输入框输入长度
@property (nonatomic, strong) UITextField *textField; //搜索框
@property (nonatomic, strong) NSMutableArray *textFieldEndArr; //筛选结果数组
@property (nonatomic, assign) NSInteger textFieldEndPage; //筛选结果页码
@property (nonatomic, assign) NSInteger textFieldEndCurrent; //筛选结果当前显示
@property (nonatomic, strong) UIButton *pointBtn; //搜索按钮

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
        //满足排除条件并且重复个数不为1时
        if ([self ruleOutByLastArr:item] && count != 1) {
            [amountArr addObject:dic];
        }
    }
    
    return amountArr;
}

#pragma mark - 对比上期排除
- (BOOL)ruleOutByLastArr:(id)item {
    
    //当前蓝
    NSString *nowBlue = [[item componentsSeparatedByString:@" "] lastObject];
    
    //往期蓝
    for (YXProbabilityBallInfoModel *oldBallInfoModel in _oldArr) {
        if (oldBallInfoModel.boolBlue && [oldBallInfoModel.value isEqualToString:nowBlue]) {
            return NO;
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
    
    NSMutableArray *newArr = [NSMutableArray arrayWithArray:[item componentsSeparatedByString:@" "]];
    if ([self judgeProbabilityNumByNewArr:newArr oldArr:oldArr]) {
        return NO;
    }
    
    [newArr removeObjectsInArray:(NSArray *)oldArr];
    
    //相同号数两个及以上
    if ((7 - newArr.count) >= 2) {
        return NO;
    }
    else {
        //两个及以上连号
        if ([self judgeContinuousNumCountByArr:(NSArray *)newArr] >= 2) {
            return NO;
        }
        return YES;
    }
}

#pragma mark - 个、十、二十、三十数
- (BOOL)judgeProbabilityNumByNewArr:(NSMutableArray *)newArr oldArr:(NSMutableArray *)oldArr {
    
    NSInteger oldSingleAmount = 0; //个位计数
    NSInteger oldTenAmount = 0; //十位计数
    NSInteger oldTwentyAmount = 0; //二十位计数
    NSInteger oldThirtyAmount = 0; //三十位计数
    for (NSInteger i = 0; i < oldArr.count - 1; i++) {
        if ([oldArr[i] integerValue] < 10) {
            oldSingleAmount++;
        }
        else if ([oldArr[i] integerValue] >= 10 && [oldArr[i] integerValue] < 20) {
            oldTenAmount++;
        }
        else if ([oldArr[i] integerValue] >= 20 && [oldArr[i] integerValue] < 30) {
            oldTwentyAmount++;
        }
        else {
            oldThirtyAmount++;
        }
    }
    
    NSInteger newSingleAmount = 0; //个位计数
    NSInteger newTenAmount = 0; //十位计数
    NSInteger newTwentyAmount = 0; //二十位计数
    NSInteger newThirtyAmount = 0; //三十位计数
    for (NSInteger i = 0; i < newArr.count - 1; i++) {
        if ([newArr[i] integerValue] < 10) {
            newSingleAmount++;
        }
        else if ([newArr[i] integerValue] >= 10 && [newArr[i] integerValue] < 20) {
            newTenAmount++;
        }
        else if ([newArr[i] integerValue] >= 20 && [newArr[i] integerValue] < 30) {
            newTwentyAmount++;
        }
        else {
            newThirtyAmount++;
        }
    }
    
    if (oldSingleAmount == newSingleAmount || oldTenAmount == newTenAmount) { //旧个位数 等于 新个位数 || 旧十位数 等于 新十位数
        return YES;
    }
    else if (oldTwentyAmount == 0 && newTwentyAmount == 0) { //旧二十位数 等于 新二十位数
        return YES;
    }
    else if (oldThirtyAmount == 0 && newThirtyAmount == 0) { //旧三十位数 等于 新三十位数
        return YES;
    }
    else if (newTwentyAmount >= 1 && newThirtyAmount > 1) { //新二十位上 大于等于 1个，新三十位数 大于 1个
        return YES;
    }
    else if (newSingleAmount > 3 || newTenAmount > 3 || newTwentyAmount > 3) { //新个位数 大于 3个 || 新十位数 大于 3个 || 新二十位数 大于 3个
        return YES;
    }
    else if ([[newArr lastObject] integerValue] >= 10) { //蓝球 大于等于 10
        NSString *redAmount = [NSString stringWithFormat:@"%@%@%@%@", @(newSingleAmount), @(newTenAmount), @(newTwentyAmount), @(newThirtyAmount)];
        if (!([redAmount isEqualToString:@"1221"] || [redAmount isEqualToString:@"2310"] || [redAmount isEqualToString:@"1320"] || [redAmount isEqualToString:@"1212"] || [redAmount isEqualToString:@"0321"] || [redAmount isEqualToString:@"2220"] || [redAmount isEqualToString:@"2130"] || [redAmount isEqualToString:@"2031"] || [redAmount isEqualToString:@"0231"])) {
            return YES;
        }
    }
    else if ([[newArr lastObject] integerValue] < 10) { //蓝球 小于 10
        NSString *redAmount = [NSString stringWithFormat:@"%@%@%@%@", @(newSingleAmount), @(newTenAmount), @(newTwentyAmount), @(newThirtyAmount)];
        if (!([redAmount isEqualToString:@"1131"] || [redAmount isEqualToString:@"2211"] || [redAmount isEqualToString:@"2220"] || [redAmount isEqualToString:@"3030"] || [redAmount isEqualToString:@"0312"] || [redAmount isEqualToString:@"3210"] || [redAmount isEqualToString:@"2121"] || [redAmount isEqualToString:@"2112"] || [redAmount isEqualToString:@"3120"] || [redAmount isEqualToString:@"1230"] || [redAmount isEqualToString:@"1032"])) {
            return YES;
        }
    }
    
    return NO;
}

#pragma mark - 连号个数
- (NSInteger)judgeContinuousNumCountByArr:(NSArray *)arr {
    
    NSInteger amount = 0;
    for (NSInteger i = 0; i < arr.count; i++) {
        NSInteger now = [arr[i] integerValue];
        NSInteger next = i == arr.count - 1 ? 0 : [arr[i + 1] integerValue];
        if ((now + 1) == next) {
            amount++;
        }
    }
    return amount;
}

#pragma mark - 界面更新弹窗
- (void)reloadAlertView {
    
    __weak typeof(self) weakSelf = self;
    
    [_activityIndicatorView stopAnimating];
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"界面已更新" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *sureAlertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        weakSelf.textField.userInteractionEnabled = YES;
    }];
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

#pragma mark - 滚动到底部
- (void)progressBearingBtn:(UIButton *)btn {
    
    if (_endArr.count == 0) {
        return;
    }
    btn.selected =! btn.selected;
    
    if (btn.selected) {
        [btn setTitle:@"置顶" forState:UIControlStateNormal];
        NSInteger section = [_tableView numberOfSections];
        if (section < 1) return;
        NSInteger index = [_tableView numberOfRowsInSection:section -1];
        if (index < 1) return;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index -1 inSection:section -1];
        [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    else {
        [btn setTitle:@"置底" forState:UIControlStateNormal];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

#pragma mark - 搜索事件
- (void)progressPointBtn {
    
    [self.view endEditing:YES];
    if (_textFieldEndArr.count == 0) {
        [_pointBtn setTitle:[NSString stringWithFormat:@"%@", @"搜索"] forState:UIControlStateNormal];
        return;
    }
    
    if (_textFieldEndPage <= (_textFieldEndArr.count - 1)) {
        _textFieldEndCurrent = [_textFieldEndArr[_textFieldEndPage] integerValue];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_textFieldEndCurrent inSection:0];
        [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        _textFieldEndPage++;
    }
    else {
        _textFieldEndPage = 0;
        _textFieldEndCurrent = [_textFieldEndArr[_textFieldEndPage] integerValue];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_textFieldEndCurrent inSection:0];
        [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
    
    [_pointBtn setTitle:[NSString stringWithFormat:@"%@/%@", @(_textFieldEndPage), @(_textFieldEndArr.count - 1)] forState:UIControlStateNormal];
    
    [_activityIndicatorView startAnimating];
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
    if (_textFieldEndCurrent == indexPath.row && _textFieldEndArr.count != 0) {
        cell.collectionView.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.1];
        [_activityIndicatorView stopAnimating];
    }
    else {
        cell.collectionView.backgroundColor = [UIColor whiteColor];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

#pragma mark - <UITextFieldDelegate>
- (void)textFieldDidChange:(UITextField *)textField {
    
    if (textField.text.length > _textfieldLenth) {
        if (textField.text.length == 3 || textField.text.length == 6 || textField.text.length == 9 || textField.text.length == 12 || textField.text.length == 15 || textField.text.length == 18) {
            NSMutableString *str = [[NSMutableString alloc ] initWithString:textField.text];
            [str insertString:@" " atIndex:(textField.text.length - 1)];
            textField.text = str;
        }
        if (textField.text.length >= 20) {
            textField.text = [textField.text substringToIndex:20];
            [textField resignFirstResponder];
        }
        _textfieldLenth = textField.text.length;
    }
    else if (textField.text.length < _textfieldLenth) {
        if (textField.text.length == 3 || textField.text.length == 6 || textField.text.length == 9 || textField.text.length == 12 || textField.text.length == 15 || textField.text.length == 18) {
            textField.text = [NSString stringWithFormat:@"%@", textField.text];
            textField.text = [textField.text substringToIndex:(textField.text.length - 1)];
        }
        _textfieldLenth = textField.text.length;
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    NSMutableArray *ballArr = [[NSMutableArray alloc] init];
    for (NSMutableArray *arr in self.endArr) {
        for (YXProbabilityListModel *listModel in arr) {
            NSMutableArray *infoArr = [[NSMutableArray alloc] init];
            for (YXProbabilityBallInfoModel *infoModel in listModel.valueArr) {
                [infoArr addObject:infoModel.value];
                if (infoArr.count == 7) {
                    NSString *infoStr = [infoArr componentsJoinedByString:@" "];
                    [ballArr addObject:infoStr];
                }
            }
        }
    }
    
    _textFieldEndArr = [[NSMutableArray alloc] init];
    NSInteger i = 0;
    for (NSString *obj in ballArr) {
        if ([obj containsString:textField.text]) {
            [_textFieldEndArr addObject:@(i)];
        }
        i++;
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    [self.view endEditing:YES];
    return YES;
}

#pragma mark - 初始化视图
- (void)initView {
    
    __weak typeof(self) weakSelf = self;
    
    UIButton *bearingBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    bearingBtn.frame = CGRectMake(CGRectGetWidth(self.view.bounds) - 60, self.yxNaviHeight + 10, 40, 20);
    [bearingBtn setTitle:@"置底" forState:UIControlStateNormal];
    [bearingBtn addTarget:self action:@selector(progressBearingBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bearingBtn];
    
    _textField = [[UITextField alloc] init];
    _textField.frame = CGRectMake(20, self.yxNaviHeight + 10, CGRectGetWidth(self.view.bounds) - 170, 20);
    _textField.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _textField.returnKeyType = UIReturnKeyDone;
    _textField.delegate = self;
    _textField.placeholder = @"输入要搜索的号码";
    _textField.userInteractionEnabled = YES;
    [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:_textField];
    
    _pointBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_pointBtn setTitle:@"搜索" forState:UIControlStateNormal];
    _pointBtn.frame = CGRectMake(CGRectGetMaxX(_textField.frame), CGRectGetMinY(_textField.frame), 80, 20);
    [_pointBtn addTarget:self action:@selector(progressPointBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_pointBtn];
    
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
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.yxNaviHeight + 40, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - (self.yxNaviHeight + 40)) style:UITableViewStylePlain];
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
