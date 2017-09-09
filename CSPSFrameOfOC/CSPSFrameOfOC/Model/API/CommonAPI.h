//
//  CommonAPI.h
//  CSPSFrameOfOC
//
//  Created by Mac on 2017/9/4.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "APIOfAFNet.h"

@interface CommonAPI : APIOfAFNet

+ (NSURLSessionDataTask *)areaList:(id)param onSuccess:(HttpSuccess)success onFail:(HttpFailure)failure;

@end
