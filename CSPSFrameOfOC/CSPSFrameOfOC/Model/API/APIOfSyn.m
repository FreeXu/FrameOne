//
//  APIOfSyn.m
//  CSPSFrameOfOC
//
//  Created by Mac on 2017/9/4.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "APIOfSyn.h"
#import "AreaResponse.h"

@implementation APIOfSyn

+ (NSURLSessionDataTask *)areaList:(id)param onSuccess:(HttpSuccess)success onFail:(HttpFailure)failure {
    return [self SynWithHttpMethod:@"GET" urlString:@"/bac/area/list" parameters:param responseClass:[AreaResponse class] success:success failure:failure];
}

@end
