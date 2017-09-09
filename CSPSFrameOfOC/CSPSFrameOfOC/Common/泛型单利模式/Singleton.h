//
//  Singleton.h
//  CSPSFrameOfOC
//
//  Created by Mac on 2017/9/6.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SingletonDelegate

@optional
+ (id)anotherInit;

@end

@interface Singleton : NSObject

+ (id)shareInstance:(Class)clazz;

@end
