//
//  ErrorResponse.h
//  CSPSFrameOfOC
//
//  Created by Mac on 2017/9/4.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ErrorResponse : NSObject

@property (nonatomic, assign) NSString *code;
@property (nonatomic, retain) NSString *message;
@property (nonatomic, retain) NSError *error;
@property (nonatomic, retain) NSDictionary *data;

@end
