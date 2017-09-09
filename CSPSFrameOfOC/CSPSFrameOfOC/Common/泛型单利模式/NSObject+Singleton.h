//
//  NSObject+Singleton.h
//  CSPSFrameOfOC
//
//  Created by Mac on 2017/9/6.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@interface NSObject (Singleton)

+ (id)shareInstance;

@end
