//
//  YXProbabilityRequest.m
//  YXProbabilityTest
//
//  Created by ios on 2020/7/6.
//  Copyright © 2020 August. All rights reserved.
//

#import "YXProbabilityRequest.h"

@implementation YXProbabilityRequest

+ (void)getBallHistoryListByIssueCount:(NSInteger)issueCount successBlock:(requestSuccessBlock)successBlock failBlock:(requestFailureBlock)failBlock {
    
    NSString *url = [NSString stringWithFormat:@"%@", @"http://www.cwl.gov.cn/cwl_admin/kjxx/findDrawNotice"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@"ssq" forKey:@"name"];
    [params setObject:@(issueCount) forKey:@"issueCount"];
    
    [HttpRequestManager getRequest:url params:params forHTTPHeaderField:nil success:^(id responseObj) {
        
        if (successBlock) {
            NSArray *arr = responseObj[@"result"];
            successBlock(arr);
        }
    } failure:^(NSError *error) {
        
        if (failBlock) {
            failBlock(error);
        }
    }];
}

@end
