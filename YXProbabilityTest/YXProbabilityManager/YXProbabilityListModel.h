//
//  YXProbabilityListModel.h
//  YXProbabilityTest
//
//  Created by ios on 2020/6/12.
//  Copyright © 2020 August. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YXProbabilityBallInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YXProbabilityListModel : NSObject

@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSMutableArray *valueArr;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

@interface YXProbabilityListArrModel : NSObject

+ (NSMutableArray *)arrayOfModelsFromDictionaries:(NSArray *)arr;

@end



NS_ASSUME_NONNULL_END
