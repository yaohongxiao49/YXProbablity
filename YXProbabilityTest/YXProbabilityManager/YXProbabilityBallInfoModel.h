//
//  YXProbabilityBallInfoModel.h
//  YXProbabilityTest
//
//  Created by ios on 2020/6/12.
//  Copyright © 2020 August. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kDate @"date"
#define kValueArr @"valueArr"
#define kValue @"value"
#define kBoolBlue @"boolBlue"

#define kProbability @"probability"

NS_ASSUME_NONNULL_BEGIN

@interface YXProbabilityBallInfoModel : NSObject

@property (nonatomic, assign) BOOL boolBlue;
@property (nonatomic, copy) NSString *value;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
