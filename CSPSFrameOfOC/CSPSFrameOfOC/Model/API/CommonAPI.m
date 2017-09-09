//
//  CommonAPI.m
//  CSPSFrameOfOC
//
//  Created by Mac on 2017/9/4.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "CommonAPI.h"
#import "AreaResponse.h"

@implementation CommonAPI

+ (NSURLSessionDataTask *)areaList:(id)param onSuccess:(HttpSuccess)success onFail:(HttpFailure)failure {
    return [self GETWithURLString:@"/bac/area/list" parameters:param responseClass:[AreaResponse class] success:success failure:failure];
}

@end
