//
//  AreaCache.h
//  CSPSFrameOfOC
//
//  Created by Mac on 2017/9/6.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+Singleton.h"

@interface AreaCache : NSObject<SingletonDelegate>

@property (nonatomic, strong) NSArray *areas;

+ (void)cacheAreas:(NSArray *)areas;
+ (NSArray *)getAreas;
+ (void)clear;

@end
