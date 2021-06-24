//
//  YXProbabilityAllPossibleModel.h
//  YXProbabilityTest
//
//  Created by ios on 2021/6/18.
//  Copyright © 2021 August. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define kAllItem @"kAllItem"
#define kFourCount @"kFourCount"
#define kFiveCount @"kFiveCount"
#define kSixCount @"kSixCount"
#define kSevenCount @"kSevenCount"

@interface YXProbabilityAllPossibleModel : NSObject

@property (nonatomic, copy) NSString *item;
@property (nonatomic, assign) NSInteger fourCount;
@property (nonatomic, assign) NSInteger fiveCount;
@property (nonatomic, assign) NSInteger sixCount;
@property (nonatomic, assign) NSInteger sevenCount;
@property (nonatomic, assign) NSInteger money;

+ (NSMutableArray *)arrayOfModelsFromDictionaries:(NSArray *)arr;
- (instancetype)initWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
