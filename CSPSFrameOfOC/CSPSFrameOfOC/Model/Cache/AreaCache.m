//
//  AreaCache.m
//  CSPSFrameOfOC
//
//  Created by Mac on 2017/9/6.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "AreaCache.h"
#import "CommonAPI.h"
#import "NSObject+File.h"
#import "MJExtension.h"

@implementation AreaCache

//MJCodingImplementation   //编码，解码；第三方封装；

+ (id)anotherInit {
    return [self getFromFile];
}

+ (NSArray *)getAreas {
    AreaCache *cache = [AreaCache shareInstance];
    if (cache.areas == nil || cache.areas.count == 0) {
        [CommonAPI areaList:nil
                  onSuccess:^(NSURLSessionDataTask *task, id responseObject) {
                      [self cacheAreas:responseObject];
                  }
                     onFail:^(NSURLSessionDataTask *task, ErrorResponse *errorResponse) {
                     }];
    }
    return cache.areas;
}

+ (void)cacheAreas:(NSArray *)areas {
    AreaCache *cache = [AreaCache shareInstance];
    cache.areas = areas;
    [cache writeToFile];
}

+ (void)clear {
    AreaCache *cache = [AreaCache shareInstance];
    cache.areas = nil;
    [cache writeToFile];
}

#pragma mark -  数据存档时，需要进行编码，解码
- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.areas forKey:@"areas"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.areas = [decoder decodeObjectForKey:@"areas"];
    }
    return self;
}

@end
