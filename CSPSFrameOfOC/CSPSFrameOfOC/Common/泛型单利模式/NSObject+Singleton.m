//
//  NSObject+Singleton.m
//  CSPSFrameOfOC
//
//  Created by Mac on 2017/9/6.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "NSObject+Singleton.h"

@implementation NSObject (Singleton)

+ (id)shareInstance {
    return [Singleton shareInstance:self];
}

@end
