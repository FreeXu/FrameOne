//
//  Macro.h
//  CSPSFrameOfOC
//
//  Created by Mac on 2017/9/1.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Macro : NSObject

@end

/* methods */
UINavigationController *packInNav(UIViewController *vc);

/* image */
#define SImage(name)  [UIImage imageNamed:name]
#define SOImage(name) [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
