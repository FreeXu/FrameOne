//
//  BaseResponse.h
//  CSPSFrameOfOC
//
//  Created by Mac on 2017/9/4.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseResponse : NSObject

@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *code;

@end
