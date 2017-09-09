//
//  APIOfSyn.h
//  CSPSFrameOfOC
//
//  Created by Mac on 2017/9/4.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "APIOfSelf.h"

@interface APIOfSyn : APIOfSelf

+ (NSURLSessionDataTask *)areaList:(id)param onSuccess:(HttpSuccess)success onFail:(HttpFailure)failure;

@end
