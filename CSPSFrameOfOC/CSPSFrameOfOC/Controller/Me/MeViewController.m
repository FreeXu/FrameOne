//
//  MeViewController.m
//  CSPSFrameOfOC
//
//  Created by Mac on 2017/9/1.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "MeViewController.h"
#import "APIOfSyn.h"

@interface MeViewController ()

@end

@implementation MeViewController

+ (NSString *)sbFileName {
    return @"Me";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [APIOfSyn areaList:nil
             onSuccess:^(id responseObject) {
                 NSLog(@"Me:%@",responseObject);
             }
                onFail:^(ErrorResponse *errorResponse) {
                    
                }];
    NSLog(@"========Me========");
    NSLog(@"%@",[APIOfSyn judgeNetworking]);
}

@end
