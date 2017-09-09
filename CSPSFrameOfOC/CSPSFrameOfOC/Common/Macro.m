//
//  Macro.m
//  CSPSFrameOfOC
//
//  Created by Mac on 2017/9/1.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "Macro.h"

@implementation Macro

@end

/* methods */
UINavigationController *packInNav(UIViewController *vc) {
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    return nav;
}
