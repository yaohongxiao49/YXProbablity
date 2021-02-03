//
//  YXProbabilityManager.h
//  YXProbabilityTest
//
//  Created by ios on 2020/6/12.
//  Copyright © 2020 August. All rights reserved.
//
// 红色球号码区由（1 - 33）共三十三个号码组成，蓝色球号码区由（1 - 16）共十六个号码组成

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YXProbabilityListModel.h"

#define kRandomListArr @"randomListArr"
#define kProbablityRandomListArr @"probablityRandomListArr"

#define kRealListArr @"realListArr"
#define kProbabilityRedArr @"probabilityRedArr"
#define kProbabilityBlueArr @"probabilityBlueArr"
#define kYXToolLocalSaveDocDirectoryPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

NS_ASSUME_NONNULL_BEGIN

@interface YXProbabilityManager : NSObject

+ (instancetype)sharedManager;

/** 以往数据依次最大 */
- (void)getMaxNumByIndex:(NSInteger)index begainArr:(NSMutableArray *)begainArr baseVC:(UIViewController *)baseVC;

+ (NSString *)assemblyProbabilityArrByRandomCount:(NSInteger)randomCount valueSet:(id)valueSet probabilityArr:(NSArray *)probabilityArr boolRed:(BOOL)boolRed;

/** 数据数组 */
@property (nonatomic, strong) NSMutableArray *allArr;
/** 随机数据集合数组 */
@property (nonatomic, copy) NSArray *randomListArr;
/** 概率随机数据集合数组 */
@property (nonatomic, copy) NSArray *probablityRandomListArr;

/** 往期数据统计评率最大数集合 */
@property (nonatomic, copy) NSArray *realListArr;
/** 概率数据集合 */
@property (nonatomic, copy) NSArray *probabilityRedArr;
@property (nonatomic, copy) NSArray *probabilityBlueArr;

@end

NS_ASSUME_NONNULL_END
