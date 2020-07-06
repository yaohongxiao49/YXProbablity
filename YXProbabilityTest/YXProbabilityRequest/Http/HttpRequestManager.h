//
//  HttpRequest.h
//  horse
//
//  Created by peter on 15/3/18.
//  Copyright (c) 2015年 soho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

/** 请求成功block */
typedef void (^requestSuccessBlock)(id responseObj);
/** 请求失败block */
typedef void (^requestFailureBlock) (NSError *error);
/** 网络异常block */
typedef void (^requestNetworkUseBlock) (id networkObj);

@interface HttpRequestManager : NSObject

+ (void)getRequest:(NSString *)url
            params:(NSDictionary *)params
forHTTPHeaderField:(id)headerField
           success:(requestSuccessBlock)successHandler
           failure:(requestFailureBlock)failureHandler;

@end
