//
//  APIOfAFNet.m
//  CSPSFrameOfOC
//
//  Created by Mac on 2017/9/4.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "APIOfAFNet.h"
#import "MJExtension.h"

//服务器
#define BASE_URL @"http://192.168.1.3:8084"

#define TIMEOUT_INTERVAL 30.0f
#define API_VERSION @"10" 
#define NORMAL_CODE 200
#define NOT_AUTHENTICATION_CODE 310
#define NOT_AUTHORIZATION_CODE 311

@implementation APIOfAFNet

static AFHTTPSessionManager *__manager = nil;

+(void)initialize {
    if (nil == __manager) {
        __manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
        __manager.requestSerializer.timeoutInterval = TIMEOUT_INTERVAL;
        __manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [__manager.requestSerializer setValue:API_VERSION forHTTPHeaderField:@"version"];
        [__manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [__manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        
        // 先导入证书
        //        NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"qa" ofType:@"cer"];//证书的路径
        //        NSData *certData = [NSData dataWithContentsOfFile:cerPath];
        //
        //        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
        //        securityPolicy.allowInvalidCertificates = YES;
        //        securityPolicy.validatesDomainName = NO;
        //        securityPolicy.pinnedCertificates = @[certData];
        //        [__manager setSecurityPolicy:securityPolicy];
        
        __manager.responseSerializer = [AFJSONResponseSerializer serializer];
        [self updateToken];
    }
}

+ (void)updateToken {
    //    [__manager.requestSerializer setValue:[TokenCache getToken] forHTTPHeaderField:@"access_token"];
}

+ (NSURLSessionDataTask *)GETWithURLString:(NSString *)URLString
                                parameters:(id)parameters
                             responseClass:(Class)responseClass
                                   success:(HttpSuccess)success
                                   failure:(HttpFailure)failure {
    // 防止重发
    NSURLSessionDataTask *exitOperation = [self getOperation:[[NSURL URLWithString:URLString relativeToURL:[NSURL URLWithString:BASE_URL]] absoluteString]];
    if (exitOperation != nil) {
        return nil;
    }
    
    [[parameters class] mj_referenceReplacedKeyWhenCreatingKeyValues:YES];
    __manager.requestSerializer.timeoutInterval = TIMEOUT_INTERVAL;
    NSURLSessionDataTask *sessionDataTask = [__manager GET:URLString
                                                parameters:[parameters mj_keyValues]
                                                  progress:nil
                                                   success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                       [self onSucc:task response:responseObject responseClass:responseClass succ:success fail:failure];
                                                   }
                                                   failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                       [self onFail:task error:error fail:failure];
                                                   }];
    return sessionDataTask;
}

+ (NSURLSessionDataTask *)POSTWithURLString:(NSString *)URLString
                                 parameters:(id)parameters
                              responseClass:(Class)responseClass
                                    success:(HttpSuccess)success
                                    failure:(HttpFailure)failure {
    // 防止重发
    NSURLSessionDataTask *exitOperation = [self getOperation:[[NSURL URLWithString:URLString relativeToURL:[NSURL URLWithString:BASE_URL]] absoluteString]];
    if (exitOperation != nil) {
        return nil;
    }
    
    [[parameters class] mj_referenceReplacedKeyWhenCreatingKeyValues:YES];
    __manager.requestSerializer.timeoutInterval = TIMEOUT_INTERVAL;
    NSURLSessionDataTask *sessionDataTask = [__manager POST:URLString
                                                 parameters:[parameters mj_keyValues]
                                                   progress:nil
                                                    success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                        [self onSucc:task response:responseObject responseClass:responseClass succ:success fail:failure];
                                                    }
                                                    failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                        [self onFail:task error:error fail:failure];
                                                    }];
    return sessionDataTask;
}

+ (NSURLSessionDataTask *)POSTWithURLString:(NSString *)URLString
                                 parameters:(id)parameters
                              responseClass:(Class)responseClass
                  constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                                    success:(HttpSuccess)success
                                    failure:(HttpFailure)failure {
    // 防止重发
    NSURLSessionDataTask *exitOperation = [self getOperation:[[NSURL URLWithString:URLString relativeToURL:[NSURL URLWithString:BASE_URL]] absoluteString]];
    if (exitOperation != nil) {
        return nil;
    }
    
    [[parameters class] mj_referenceReplacedKeyWhenCreatingKeyValues:YES];
    __manager.requestSerializer.timeoutInterval = TIMEOUT_INTERVAL;
    NSURLSessionDataTask *sessionDataTask = [__manager POST:URLString
                                                 parameters:[parameters mj_keyValues]
                                  constructingBodyWithBlock:block
                                                   progress:nil
                                                    success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                        [self onSucc:task response:responseObject responseClass:responseClass succ:success fail:failure];
                                                    }
                                                    failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                        [self onFail:task error:error fail:failure];
                                                    }];
    return sessionDataTask;
}

//upload image
+ (NSURLSessionDataTask *)POSTWithURLString:(NSString *)URLString
                                uploadImage:(UIImage *)image
                                 parameters:(id)parameters
                              responseClass:(Class)responseClass
                                    success:(HttpSuccess)success
                                    failure:(HttpFailure)failure {
    // 防止重发
    NSURLSessionDataTask *exitOperation = [self getOperation:[[NSURL URLWithString:URLString relativeToURL:[NSURL URLWithString:BASE_URL]] absoluteString]];
    if (exitOperation != nil) {
        return nil;
    }
    
    [[parameters class] mj_referenceReplacedKeyWhenCreatingKeyValues:YES];
    __manager.requestSerializer.timeoutInterval = TIMEOUT_INTERVAL;
    NSURLSessionDataTask *sessionDataTask = [__manager POST:URLString
                                                 parameters:[parameters mj_keyValues]
                                  constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                                      [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.5)
                                                                  name:@"file"   //注意这里，不同的设置
                                                              fileName:@"image.png"
                                                              mimeType:@"images/png"];
                                  }
                                                   progress:nil
                                                    success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                        [self onSucc:task response:responseObject responseClass:responseClass succ:success fail:failure];
                                                    }
                                                    failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                        [self onFail:task error:error fail:failure];
                                                    }];
    return sessionDataTask;
}

#pragma mark - Action
//得到某一个URL当前是否正在请求队列中
+ (NSURLSessionDataTask *)getOperation:(NSString *)URLString {
    for (NSURLSessionDataTask *operation in __manager.operationQueue.operations) {
        if ([operation.currentRequest.URL.absoluteString isEqualToString:URLString]) {
            return operation;
        }
    }
    return nil;
}

+ (void)onSucc:(NSURLSessionDataTask *)task
      response:(id)responseObject
 responseClass:(Class)responseClass
          succ:(HttpSuccess)succBlock
          fail:(HttpFailure)failBlock {
    NSLog(@"[RESPONSE]-%@", responseObject);
    
    NSHTTPURLResponse *httpUrlResponse = (NSHTTPURLResponse *)task.response;
    if (httpUrlResponse.statusCode == NORMAL_CODE) {
        id response;
        if ([responseObject isKindOfClass:[NSArray class]]) {
            response = [responseClass mj_objectArrayWithKeyValuesArray:responseObject];
        }
        else if ([responseObject isKindOfClass:[NSDictionary class]]) {
            response = [responseClass mj_objectWithKeyValues:responseObject];
        }
        
        if (succBlock) {
            succBlock(task, response);
        }
    }
    else {
        ErrorResponse *response = [ErrorResponse mj_objectWithKeyValues:responseObject];
        if (failBlock) {
            failBlock(task, response);
        }
    }
}

+ (void)onFail:(NSURLSessionDataTask *)task
         error:(NSError *)error
          fail:(HttpFailure)failBlock {
    NSLog(@"[RESPONSE]-%@", task.response);
    NSHTTPURLResponse *httpUrlResponse = (NSHTTPURLResponse *)task.response;
    // 登录失效
    if (httpUrlResponse.statusCode == NOT_AUTHENTICATION_CODE) {
        //        [TokenCache clearToken];
        //        [self updateToken];
        //        [Utils presentLoginVC];
        return;
    }
    
    ErrorResponse *response = [ErrorResponse new];
    // 取消了
    if (error.code == kCFURLErrorCancelled) {
        return;
    }
    // 没有权限
    else if (httpUrlResponse.statusCode == NOT_AUTHORIZATION_CODE) {
        response.message = @"没有权限";
    }
    // 无网
    else if (error.code == kCFURLErrorNetworkConnectionLost||
             error.code == kCFURLErrorNotConnectedToInternet ||
             error.code == kCFURLErrorCannotConnectToHost ||
             error.code == kCFURLErrorDNSLookupFailed
             ) {
        response.message = @"网络连接失败，请检查网络";
    }
    // 超时
    else if (error.code == kCFURLErrorTimedOut) {
        response.message = @"网络超时，请检查网络";
    }
    // 解析不了
    else if (error.code == kCFURLErrorCannotDecodeContentData) {
        response.message = @"数据格式错误";
    }
    // 未知异常
    else {
        response.message = @"服务器异常";
    }
    
    response.error = [error copy];
    if (failBlock) {
        failBlock(task, response);
    }
}

@end
