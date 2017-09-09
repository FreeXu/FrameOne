//
//  APIOfAFNet.h
//  CSPSFrameOfOC
//
//  Created by Mac on 2017/9/4.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "ErrorResponse.h"

typedef void (^HttpSuccess)(NSURLSessionDataTask *task, id responseObject);
typedef void (^HttpFailure)(NSURLSessionDataTask *task, ErrorResponse *errorResponse);

@interface APIOfAFNet : NSObject

+ (void)updateToken;

+ (NSURLSessionDataTask *)GETWithURLString:(NSString *)URLString
                                parameters:(id)parameters
                             responseClass:(Class)responseClass
                                   success:(HttpSuccess)success
                                   failure:(HttpFailure)failure;

+ (NSURLSessionDataTask *)POSTWithURLString:(NSString *)URLString
                                 parameters:(id)parameters
                              responseClass:(Class)responseClass
                                    success:(HttpSuccess)success
                                    failure:(HttpFailure)failure;

+ (NSURLSessionDataTask *)POSTWithURLString:(NSString *)URLString
                                 parameters:(id)parameters
                              responseClass:(Class)responseClass
                  constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                                    success:(HttpSuccess)success
                                    failure:(HttpFailure)failure;

//upload image
+ (NSURLSessionDataTask *)POSTWithURLString:(NSString *)URLString
                                uploadImage:(UIImage *)image
                                 parameters:(id)parameters
                              responseClass:(Class)responseClass
                                    success:(HttpSuccess)success
                                    failure:(HttpFailure)failure;

@end
