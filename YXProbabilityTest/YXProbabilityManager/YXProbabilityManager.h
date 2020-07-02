//
//  YXProbabilityManager.h
//  YXProbabilityTest
//
//  Created by ios on 2020/6/12.
//  Copyright © 2020 August. All rights reserved.
//
// 红色球号码区由（1 - 33）共三十三个号码组成，蓝色球号码区由（1 - 16）共十六个号码组成

#import <Foundation/Foundation.h>
#import "YXProbabilityListModel.h"

#define kRandomListArr @"randomListArr"
#define kYXToolLocalSaveDocDirectoryPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

NS_ASSUME_NONNULL_BEGIN

@interface YXProbabilityManager : NSObject

+ (instancetype)sharedManager;

/** 数据数组 */
@property (nonatomic, strong) NSMutableArray *allArr;

/** 随机数据集合数组 */
@property (nonatomic, copy) NSArray *randomListArr;

@end

NS_ASSUME_NONNULL_END
