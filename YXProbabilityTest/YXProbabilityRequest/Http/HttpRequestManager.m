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
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/ javascript", @"text/html", @"text/plain", @"*/*", nil];
//    [manager.requestSerializer setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
//    [manager.requestSerializer setValue:@"gzip, deflate, br" forHTTPHeaderField:@"Accept-Encoding"];
//    [manager.requestSerializer setValue:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.0 Safari/605.1.15" forHTTPHeaderField:@"User-Agent"];
//    [manager.requestSerializer setValue:@"https://www.cwl.gov.cn/ygkj/wqkjgg/ssq/" forHTTPHeaderField:@"Referer"];
//    [manager.requestSerializer setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    
//    [manager.requestSerializer setValue:@"21_vq=3; HMF_CI=2f1cc050c9b02d590dbe83d00b102b7b1f7495bf79b92bbbb03d35dc7c71e535750de9f4fc5fd88dc86088f2b4dde34b025a9937eebf68d4ab3fe737ffc7594383" forHTTPHeaderField:@"Cookie"];
    
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
            NSInteger code = [[dic objectForKey:@"state"] integerValue];

            successHandler(dic);
            
            if (code != 0) {
                NSLog(@"报错的接口:%@ -- 错误码:%zd -- 错误信息:%@", url, code, dic[@"msg"]);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        failureHandler(error);
        
        NSLog(@"报错的接口:%@ -- 错误码:%zd -- 错误信息:%@", url, error.code, error.localizedDescription);
    }];
}

@end
