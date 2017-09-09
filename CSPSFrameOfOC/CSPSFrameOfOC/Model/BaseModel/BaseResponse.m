//
//  BaseResponse.m
//  CSPSFrameOfOC
//
//  Created by Mac on 2017/9/4.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "BaseResponse.h"
#import "MJExtension.h"

@implementation BaseResponse

MJCodingImplementation

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{
             @"message" : @"msg",
             @"code" : @"code"
             };
}

- (id)newValueFromOldValue:(id)oldValue property:(MJProperty *)property {
    if (property.type.typeClass == [NSDate class] && ![oldValue isKindOfClass:[NSNull class]]) {
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"yyyyMMddHHmmss";
        return [fmt dateFromString:oldValue];
    }
    return oldValue;
}

@end
