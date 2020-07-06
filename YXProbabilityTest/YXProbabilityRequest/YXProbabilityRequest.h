//
//  YXProbabilityRequest.h
//  YXProbabilityTest
//
//  Created by ios on 2020/7/6.
//  Copyright © 2020 August. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpRequestManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface YXProbabilityRequest : NSObject

+ (void)getBallHistoryListByIssueCount:(NSInteger)issueCount
                          successBlock:(requestSuccessBlock)successBlock
                             failBlock:(requestFailureBlock)failBlock;

@end

NS_ASSUME_NONNULL_END
