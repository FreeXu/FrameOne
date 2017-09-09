//
//  NewsViewController.m
//  CSPSFrameOfOC
//
//  Created by Mac on 2017/9/1.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "NewsViewController.h"
#import "AreaCache.h"

@interface NewsViewController ()

@end

@implementation NewsViewController

+ (NSString *)sbFileName {
    return @"News";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AreaCache *areaCache = [AreaCache shareInstance];
    NSLog(@"===========News========== %@",areaCache.areas);
}

@end
