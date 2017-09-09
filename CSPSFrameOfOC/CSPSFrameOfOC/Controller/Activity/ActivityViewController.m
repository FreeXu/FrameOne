//
//  ActivityViewController.m
//  CSPSFrameOfOC
//
//  Created by Mac on 2017/9/1.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "ActivityViewController.h"
#import "NSObject+File.h"
#import "AreaCache.h"

@interface ActivityViewController ()

@end

@implementation ActivityViewController

+ (NSString *)sbFileName {
    return @"Activity";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AreaCache *cache = [AreaCache getFromFile];
    NSLog(@"______%@",cache.areas);
}

@end
