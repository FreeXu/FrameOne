//
//  UIViewController+SB.m
//  CSPSFrameOfOC
//
//  Created by Mac on 2017/9/1.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "UIViewController+SB.h"

@implementation UIViewController (SB)

+ (id)loadFromSB {
    NSString *className = NSStringFromClass(self);
    NSString *sbFileName;
    NSString *sbIdentifierID = className;
    if ([self conformsToProtocol:@protocol(SBLoader)] && [self respondsToSelector:@selector(sbFileName)]) {
        sbFileName = [self sbFileName];
    }
    if ([self conformsToProtocol:@protocol(SBLoader)] && [self respondsToSelector:@selector(sbIdentifierID)]) {
        sbIdentifierID = [self sbIdentifierID];
    }
    
    id vc = [[UIStoryboard storyboardWithName:sbFileName bundle:nil] instantiateViewControllerWithIdentifier:sbIdentifierID];
    return vc;
}

@end
