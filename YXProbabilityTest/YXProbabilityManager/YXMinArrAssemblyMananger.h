//
//  YXMinArrAssemblyMananger.h
//  YXProbabilityTest
//
//  Created by ios on 2020/9/1.
//  Copyright © 2020 August. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXMinArrAssemblyMananger : NSObject

+ (instancetype)sharedManager;

- (NSMutableArray *)assemblyRegularValueByArr:(NSArray *)arr;

@end

NS_ASSUME_NONNULL_END
