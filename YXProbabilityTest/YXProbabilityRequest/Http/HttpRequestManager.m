//
//  HttpRequest.m
//  horse
//
//  Created by peter on 15/3/18.
//  Copyright (c) 2015年 soho. All rights reserved.
//

#import "HttpRequestManager.h"

@implementation HttpRequestManager

+ (void)getRequest:(NSString *)url params:(NSDictionary *)params forHTTPHeaderField:(id)headerField success:(requestSuccessBlock)successHandler failure:(requestFailureBlock)failureHandler {
    
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"#%^{}\"[]|\\<> "].invertedSet];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //设置请求超时时间
    manager.requestSerializer.timeoutInterval = 10.0;
    //缓存策略
    manager.requestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    //数据格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/ javascript", @"text/html", @"text/plain", @"*/*", nil];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //安全相关
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.securityPolicy.validatesDomainName = NO;
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    [manager GET:url parameters:params headers:headerField progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]] || [responseObject isKindOfClass:[NSArray class]]) {
            successHandler(responseObject);
        }
        else if ([responseObject isKindOfClass:[NSString class]]) {
            
            successHandler(nil);
        }
        else {
            id object = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:object];
            NSInteger code = [[dic objectForKey:@"code"] integerValue];

            successHandler(dic);
            
            if (code != 200) {
                NSLog(@"报错的接口:%@ -- 错误码:%zd -- 错误信息:%@", url, code, dic[@"msg"]);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        failureHandler(error);
        
        NSLog(@"报错的接口:%@ -- 错误码:%zd -- 错误信息:%@", url, error.code, error.localizedDescription);
    }];
}

@end
