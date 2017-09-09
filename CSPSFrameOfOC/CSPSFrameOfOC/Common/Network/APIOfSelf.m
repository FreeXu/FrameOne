//
//  APIOfSelf.m
//  CSPSFrameOfOC
//
//  Created by Mac on 2017/9/4.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIOfSelf.h"
#import "MJExtension.h"

//服务器
#define BASE_URL @"http://192.168.1.3:8084"

#define TIMEOUT_INTERVAL 30.0f
#define API_VERSION @"10"
#define NORMAL_CODE 200
#define NOT_AUTHENTICATION_CODE 310
#define NOT_AUTHORIZATION_CODE 311

@implementation APIOfSelf

//同步请求
+ (NSURLSessionDataTask *)SynWithHttpMethod:(NSString *)method
                                  urlString:(NSString *)urlString
                                 parameters:(id)parameters
                              responseClass:(Class)responseClass
                                    success:(HttpSuccess)success
                                    failure:(HttpFailure)failure {
    NSData *paramData = nil;
    if (parameters) {
        [[parameters class] mj_referenceReplacedKeyWhenCreatingKeyValues:YES];
        paramData = [NSJSONSerialization dataWithJSONObject:[parameters mj_keyValues] options:NSJSONWritingPrettyPrinted error:nil];
    }
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,urlString]]];
    [request setTimeoutInterval:TIMEOUT_INTERVAL];
    [request setHTTPMethod:method];
    [request setValue:API_VERSION forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[paramData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:paramData];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);//
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                                                if (!error) {
                                                    [self onSucc:response data:data responseClass:responseClass succ:success fail:failure];
                                                } else {
                                                    [self onFail:response error:error fail:failure];
                                                }
                                                dispatch_semaphore_signal(semaphore);//
                                            }];
    [task resume];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);//
    
    return task;
}

//异步请求
+ (NSURLSessionDataTask *)AsyncWithHttpMethod:(NSString *)method
                                    urlString:(NSString *)urlString
                                   parameters:(id)parameters
                                responseClass:(Class)responseClass
                                      success:(HttpSuccess)success
                                      failure:(HttpFailure)failure {
    NSData *paramData = nil;
    if (parameters) {
        [[parameters class] mj_referenceReplacedKeyWhenCreatingKeyValues:YES];
        paramData = [NSJSONSerialization dataWithJSONObject:[parameters mj_keyValues] options:NSJSONWritingPrettyPrinted error:nil];
    }
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,urlString]]];
    [request setTimeoutInterval:TIMEOUT_INTERVAL];
    [request setHTTPMethod:method];
    [request setValue:API_VERSION forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[paramData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:paramData];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                                                if (!error) {
                                                    [self onSucc:response data:data responseClass:responseClass succ:success fail:failure];
                                                } else {
                                                    [self onFail:response error:error fail:failure];
                                                }
                                            }];
    [task resume];
    
    return task;
}

#pragma mark actions
+ (void)onSucc:(NSURLResponse *)urlResponse
          data:(NSData *)data
 responseClass:(Class)responseClass
          succ:(HttpSuccess)succBlock
          fail:(HttpFailure)failBlock {
    id responseObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSLog(@"[RESPONSE]-%@", responseObject);
    NSHTTPURLResponse *httpUrlResponse = (NSHTTPURLResponse *)urlResponse;
    
    if (httpUrlResponse.statusCode == NORMAL_CODE) {
        id response;
        if ([responseObject isKindOfClass:[NSArray class]]) {
            response = [responseClass mj_objectArrayWithKeyValuesArray:responseObject];
        }
        else if ([responseObject isKindOfClass:[NSDictionary class]]) {
            response = [responseClass mj_objectWithKeyValues:responseObject];
        }
        
        if (succBlock) {
            succBlock(response);
        }
    }
    else {
        ErrorResponse *response = [ErrorResponse mj_objectWithKeyValues:responseObject];
        if (failBlock) {
            failBlock(response);
        }
    }
}

+ (void)onFail:(NSURLResponse *)response
         error:(NSError *)error
          fail:(HttpFailure)failBlock {
    NSLog(@"[RESPONSE]-%@", response);
    NSHTTPURLResponse *httpUrlResponse = (NSHTTPURLResponse *)response;
    
    // 登录失效
    if (httpUrlResponse.statusCode == NOT_AUTHENTICATION_CODE) {
        //        [TokenCache clearToken];
        //        [self updateToken];
        //        [Utils presentLoginVC];
        return;
    }
    
    ErrorResponse *errorResponse = [ErrorResponse new];
    // 取消了
    if (error.code == kCFURLErrorCancelled) {
        return;
    }
    // 没有权限
    else if (httpUrlResponse.statusCode == NOT_AUTHORIZATION_CODE) {
        errorResponse.message = @"没有权限";
    }
    // 无网
    else if (error.code == kCFURLErrorNetworkConnectionLost||
             error.code == kCFURLErrorNotConnectedToInternet ||
             error.code == kCFURLErrorCannotConnectToHost ||
             error.code == kCFURLErrorDNSLookupFailed
             ) {
        errorResponse.message = @"网络连接失败，请检查网络";
    }
    // 超时
    else if (error.code == kCFURLErrorTimedOut) {
        errorResponse.message = @"网络超时，请检查网络";
    }
    // 解析不了
    else if (error.code == kCFURLErrorCannotDecodeContentData) {
        errorResponse.message = @"数据格式错误";
    }
    // 未知异常
    else {
        errorResponse.message = @"服务器异常";
    }
    
    errorResponse.error = [error copy];
    if (failBlock) {
        failBlock(errorResponse);
    }
}

#pragma mark -------
+ (NSString *)judgeNetworking {
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *children = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    int type = 0;
    for (id child in children) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            type = [[child valueForKeyPath:@"dataNetworkType"] intValue];
        }
    }
    
    NSString *msg = @"";
    switch (type) {
        case 0:
            msg = @"当前无网络";
            break;
        case 1:
            msg = @"当前网络为2G";
            break;
        case 2:
            msg = @"当前网络为3G";
            break;
        case 3:
            msg = @"当前网络为4G";
            break;
        case 5:
            msg = @"当前网络为WI-FI";
            break;
            
        default:
            msg = @"无法识别当前网络";
            break;
    }
    
    return msg;
}

@end
