//
//  Singleton.m
//  CSPSFrameOfOC
//
//  Created by Mac on 2017/9/6.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "Singleton.h"

@implementation Singleton

static NSMutableDictionary * __singletonsOfClasses = nil;

+(void)initialize {
    if (nil == __singletonsOfClasses) {
        __singletonsOfClasses = [NSMutableDictionary dictionary];
    }
}

+ (id)shareInstance:(Class)clazz {
//    if (![clazz conformsToProtocol:@protocol(SingletonDelegate)]) {
//        return nil;
//    }
    
    @synchronized(__singletonsOfClasses) {
        NSString *className = NSStringFromClass(clazz);
        id instance = [__singletonsOfClasses objectForKey:className];
        if ([instance isKindOfClass:[NSNull class]] || instance == nil) {
            if ([clazz respondsToSelector:@selector(anotherInit)]) {
                instance = [clazz anotherInit]; //读取数据，当数据保存在本地时
            }
            if (instance == nil) {
                instance = [[clazz alloc] init];
            }
            [__singletonsOfClasses setObject:instance forKey:className];
        }
        return instance;
    }
}

@end
