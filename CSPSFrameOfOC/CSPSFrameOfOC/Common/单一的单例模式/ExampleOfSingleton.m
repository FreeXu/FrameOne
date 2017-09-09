//
//  ExampleOfSingleton.m
//  CSPSFrameOfOC
//
//  Created by Mac on 2017/9/6.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "ExampleOfSingleton.h"
#import "AreaCache.h"

@implementation ExampleOfSingleton

/*
     这里定义的是AreaCache单例，也就是这个单例只是一个AreaCache单例，是单一的；如果需要其他的单例，需要重新定义；
     有点重复代码，那么可以考虑如何重用单例初始化代码；
 */
static id _instance = nil;

#pragma mark =============  单例初始化，方法一  =============
+ (AreaCache *)shareInstance {
    @synchronized (self) {
        if (_instance == nil) {
            _instance = [[AreaCache alloc] init];
        }
    }
    
    return _instance;
}

#pragma mark =============  单例初始化，方法二 =======  推荐  ======
//+ (id)shareInstance {
//    if (_instance == nil) {
//        static dispatch_once_t onceToken;
//        dispatch_once(&onceToken, ^{
//            _instance = [[AreaCache alloc] init];
//        });
//    }
//    return _instance;
//}
//
//+ (id)allocWithZone:(struct _NSZone *)zone {
//    if (_instance == nil) {
//        static dispatch_once_t onceToken;
//        dispatch_once(&onceToken, ^{
//            _instance = [super allocWithZone:zone];
//        });
//    }
//    return _instance;
//}
//
//+ (id)copyWithZone:(NSZone *)zone {
//    return _instance;
//}

@end
