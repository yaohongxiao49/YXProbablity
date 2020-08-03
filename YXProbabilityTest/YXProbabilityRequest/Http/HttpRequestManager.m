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
    [manager.requestSerializer setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [manager.requestSerializer setValue:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.1.1 Safari/605.1.15" forHTTPHeaderField:@"User-Agent"];
    [manager.requestSerializer setValue:@"http://www.cwl.gov.cn/kjxx/ssq/kjgg/" forHTTPHeaderField:@"Referer"];
    [manager.requestSerializer setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    
    [manager.requestSerializer setValue:@"Sites=_21; UniqueID=TjdeJs6byRIBjf1g1596438184413; 21_vq=19; _ga=GA1.3.404967296.1596003999; _gat_gtag_UA_113065506_1=1; _gid=GA1.3.136085384.1596438187; _Jo0OQK=47F0A76952D36CAA01BD88B66B89ADC2E52C259EC7CAEE7F8517247471E74BC8DD49AE22BD7B56E9419357F5468E2908FBCF44D327936865D57425696CE5549D81414D60443865B47C6F1FDB3AE9ADADF3EF1FDB3AE9ADADF3EC64F657D1107C4183B656E699CAFAA31GJ1Z1Yg==" forHTTPHeaderField:@"Cookie"];
    
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
