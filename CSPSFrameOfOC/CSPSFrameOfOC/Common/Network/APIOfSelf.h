//
//  APIOfSelf.h
//  CSPSFrameOfOC
//
//  Created by Mac on 2017/9/4.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ErrorResponse.h"

typedef void (^HttpSuccess)(id responseObject);
typedef void (^HttpFailure)(ErrorResponse *errorResponse);

@interface APIOfSelf : NSObject

//同步请求
+ (NSURLSessionDataTask *)SynWithHttpMethod:(NSString *)method
                                  urlString:(NSString *)urlString
                                 parameters:(id)parameters
                              responseClass:(Class)responseClass
                                    success:(HttpSuccess)success
                                    failure:(HttpFailure)failure;

//异步请求
+ (NSURLSessionDataTask *)AsyncWithHttpMethod:(NSString *)method
                                    urlString:(NSString *)urlString
                                   parameters:(id)parameters
                                responseClass:(Class)responseClass
                                      success:(HttpSuccess)success
                                      failure:(HttpFailure)failure;

+ (NSString *)judgeNetworking;

@end
