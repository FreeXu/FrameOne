//
//  UIViewController+SB.h
//  CSPSFrameOfOC
//
//  Created by Mac on 2017/9/1.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SBLoader

@optional
+ (NSString *)sbFileName;
+ (NSString *)sbIdentifierID;

@end

@interface UIViewController (SB)<SBLoader>

+ (id)loadFromSB;

@end
