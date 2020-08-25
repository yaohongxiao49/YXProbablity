//
//  YXProbabilityStatisticalVC.m
//  YXProbabilityTest
//
//  Created by ios on 2020/6/12.
//  Copyright © 2020 August. All rights reserved.
//

#import "YXProbabilityStatisticalVC.h"
#import "NSObject+YXCategory.h"
#import "YXProbabilityStatisticalHeaderView.h"

@interface YXProbabilityStatisticalVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) YXProbabilityStatisticalHeaderView *headerView;

@property (nonatomic, strong) NSMutableArray *originalRedArr;
@property (nonatomic, strong) NSMutableArray *originalBlueArr;
@property (nonatomic, strong) NSMutableArray *redArr;
@property (nonatomic, strong) NSMutableArray *blueArr;

@property (nonatomic, copy) NSString *mustRed;
@property (nonatomic, copy) NSString *mustBlue;

@end

@implementation YXProbabilityStatisticalVC

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleDeviceOrientationChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    self.title = @"图形化";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initDataSource];
    [self initView];
}

#pragma mark - 设备方向改变的处理
- (void)handleDeviceOrientationChange:(NSNotification *)notification {
    
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    switch (deviceOrientation) {
        case UIDeviceOrientationFaceUp:
            NSLog(@"屏幕朝上平躺");
            break;
        case UIDeviceOrientationFaceDown:
            NSLog(@"屏幕朝下平躺");
            break;
        case UIDeviceOrientationUnknown:
            NSLog(@"未知方向");
            break;
        case UIDeviceOrientationLandscapeLeft:
            NSLog(@"屏幕向左横置");
            break;
        case UIDeviceOrientationLandscapeRight:
            NSLog(@"屏幕向右橫置");
            break;
        case UIDeviceOrientationPortrait:
            NSLog(@"屏幕直立");
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            NSLog(@"屏幕直立，上下顛倒");
            break;
        default:
            NSLog(@"无法辨识");
            break;
    }
    
    _tableView.frame = CGRectMake(0, self.yxNaviHeight, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - self.yxNaviHeight);
    CGFloat amount = (_redArr.count /2) + (_blueArr.count /2);
    self.headerView.frame = CGRectMake(0, 0, self.view.bounds.size.width, amount *50);
    [_tableView reloadData];
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
- (NSArray *)sortingByArr:(NSArray *)arr {
    
    NSArray *resultArray = [arr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        NSNumber *number1 = [obj1 objectForKey:kPieChartLineGraphicsValue];
        NSNumber *number2 = [obj2 objectForKey:kPieChartLineGraphicsValue];
        
        NSComparisonResult result = [number1 compare:number2];
        
        return result == NSOrderedAscending; //降序
    }];
    return resultArray;
}

#pragma mark - 设置属性文字
- (NSMutableAttributedString *)attString:(NSString *)string font:(UIFont *)font color:(UIColor *)color subString:(NSString *)subString subFont:(UIFont *)subFont subColor:(UIColor *)subColor {
    
    if (string.length == 0) {
        return nil;
    }
    
    //设置字符串
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:string];
    //整个字符串的范围
    NSRange range = [string rangeOfString:string];
    //整个字符串字体类型和大小
    [attString addAttribute:NSFontAttributeName value:font range:range];
    //整个字符串字体颜色
    [attString addAttribute:NSForegroundColorAttributeName value:color range:range];
    
    //改变某段字符串
    if (subString.length > 0) {
        //计算要改变的范围
        NSRange subRange = [string rangeOfString:subString];
        //改某段字体类型和大小
        [attString addAttribute:NSFontAttributeName value:subFont range:subRange];
        //改某段字体颜色
        [attString addAttribute:NSForegroundColorAttributeName value:subColor range:subRange];
    }
    
    return attString;
}
+ (NSMutableAttributedString *)attString:(NSString *)string font:(UIFont *)font color:(UIColor *)color subStringArr:(NSArray *)subStringArr subFontArr:(NSArray *)subFontArr subColorArr:(NSArray *)subColorArr {
    
    if (string.length == 0) {
        return nil;
    }
    
    //设置字符串
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:string];
    //整个字符串的范围
    NSRange range = [string rangeOfString:string];
    //整个字符串字体类型和大小
    [attString addAttribute:NSFontAttributeName value:font range:range];
    //整个字符串字体颜色
    [attString addAttribute:NSForegroundColorAttributeName value:color range:range];
    
    //改变某段字符串
    for (int i = 0; i < subStringArr.count; i++) {
        NSString *subString = subStringArr[i];
        //计算要改变的范围
        NSRange subRange = [string rangeOfString:subString];
        //改某段字体类型和大小
        [attString addAttribute:NSFontAttributeName value:subFontArr[i] range:subRange];
        //改某段字体颜色
        [attString addAttribute:NSForegroundColorAttributeName value:subColorArr[i] range:subRange];
    }
    
    return attString;
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 0;
    }
    return section == 1 ? _redArr.count : _blueArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    NSMutableArray *arr = indexPath.section == 1 ? _redArr : _blueArr;
    NSMutableArray *originalArr = indexPath.section == 1 ? _originalRedArr : _originalBlueArr;
    YXPieChartLineGraphicsModel *model = arr[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"标题：%@，个数：%.f个，百分比：%.f%%", model.name, model.value, (model.value /originalArr.count) *100];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, tableView.sectionHeaderHeight)];
    lab.backgroundColor = [UIColor whiteColor];
    lab.numberOfLines = 0;
    if (section == 0) {
        NSString *subStr = [NSString stringWithFormat:@"红球：%@\n篮球：%@", _mustRed, _mustBlue];
        lab.text = [NSString stringWithFormat:@"出现频率最高的号码：%@", subStr];
        lab.attributedText = [self attString:lab.text font:lab.font color:[UIColor blackColor] subString:subStr subFont:[UIFont boldSystemFontOfSize:16] subColor:[UIColor orangeColor]];
    }
    else {
        lab.text = section == 1 ? @"红球" : @"蓝球";
    }
    return lab;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 50;
}

#pragma mark - 初始化视图
- (void)initView {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.yxNaviHeight, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - self.yxNaviHeight) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = self.headerView;
    [self.view addSubview:_tableView];
}

#pragma mark - 初始化数据
- (void)initDataSource {
    
    NSMutableArray *arr = [YXProbabilityListArrModel arrayOfModelsFromDictionaries:[[YXProbabilityManager sharedManager] allArr]];
    
    NSMutableArray *redBallArr = [[NSMutableArray alloc] init];
    NSMutableArray *blueBallArr = [[NSMutableArray alloc] init];
    
    [arr enumerateObjectsUsingBlock:^(YXProbabilityListModel *  _Nonnull listModel, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [listModel.valueArr enumerateObjectsUsingBlock:^(YXProbabilityBallInfoModel *  _Nonnull infoModel, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (infoModel.boolBlue) {
                [blueBallArr addObject:infoModel.value];
            }
            else {
                [redBallArr addObject:infoModel.value];
            }
        }];
    }];
    
    _originalRedArr = [[NSMutableArray alloc] initWithArray:(NSArray *)redBallArr];
    _originalBlueArr = [[NSMutableArray alloc] initWithArray:(NSArray *)blueBallArr];
    
    _redArr = [YXPieChartLineGraphicsArrModel arrayOfModelsFromDictionaries:[self sortingByArr:(NSArray *)[self statisticalRepeatNum:redBallArr]]];
    _blueArr = [YXPieChartLineGraphicsArrModel arrayOfModelsFromDictionaries:[self sortingByArr:(NSArray *)[self statisticalRepeatNum:blueBallArr]]];
    
    self.headerView.redArr = [YXPieChartLineGraphicsArrModel arrayOfModelsFromDictionaries:[self statisticalRepeatNum:redBallArr]];
    self.headerView.blueArr = [YXPieChartLineGraphicsArrModel arrayOfModelsFromDictionaries:[self statisticalRepeatNum:blueBallArr]];
    
    NSMutableArray *mustRedArr = [[NSMutableArray alloc] init];
    NSMutableArray *valueRedArr = [[NSMutableArray alloc] init];
    [[self sortingByArr:(NSArray *)[self statisticalRepeatNum:redBallArr]] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        if (idx < 6) {
            [mustRedArr addObject:[obj objectForKey:kPieChartLineGraphicsName]];
            
            NSDictionary *dic = @{kBoolBlue:@(NO), kValue:[obj objectForKey:kPieChartLineGraphicsName]};
            [valueRedArr addObject:dic];
        }
    }];
    _mustRed = [mustRedArr componentsJoinedByString:@" "];
    
    NSMutableArray *mustBlueArr = [[NSMutableArray alloc] init];
    [[self sortingByArr:(NSArray *)[self statisticalRepeatNum:blueBallArr]] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        if (idx < 6) {
            [mustBlueArr addObject:[obj objectForKey:kPieChartLineGraphicsName]];
        }
    }];
    _mustBlue = [mustBlueArr firstObject];
    NSDictionary *dic = @{kBoolBlue:@(YES), kValue:_mustBlue};
    [valueRedArr addObject:dic];
    
    //概率最大的数据集合
    NSMutableDictionary *valueDic = [[NSMutableDictionary alloc] init];
    [valueDic setValue:@"statistical" forKey:kDate];
    [valueDic setObject:valueRedArr forKey:kValueArr];
    [YXProbabilityManager sharedManager].realListArr = @[valueDic];
    
    __weak typeof(self) weakSelf = self;
    NSMutableArray *probabilityRedArr = [[NSMutableArray alloc] init];
    [_redArr enumerateObjectsUsingBlock:^(YXPieChartLineGraphicsModel *  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGFloat probability = (model.value /weakSelf.originalRedArr.count) *100;
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{kProbability:@(probability), kValue:model.name}];
        [probabilityRedArr addObject:dic];
    }];
    [YXProbabilityManager sharedManager].probabilityRedArr = [[NSArray alloc] initWithArray:(NSArray *)probabilityRedArr];
    
    NSMutableArray *probabilityBlueArr = [[NSMutableArray alloc] init];
    [_blueArr enumerateObjectsUsingBlock:^(YXPieChartLineGraphicsModel *  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGFloat probability = (model.value /weakSelf.originalBlueArr.count) *100;
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{kProbability:@(probability), kValue:model.name}];
        [probabilityBlueArr addObject:dic];
    }];
    [YXProbabilityManager sharedManager].probabilityBlueArr = [[NSArray alloc] initWithArray:(NSArray *)probabilityBlueArr];
}

#pragma mark - 懒加载
- (YXProbabilityStatisticalHeaderView *)headerView {
 
    if (!_headerView) {
        CGFloat amount = (_redArr.count /2) + (_blueArr.count /2);
        _headerView = [[YXProbabilityStatisticalHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, amount *50)];
    }
    return _headerView;
}


@end
