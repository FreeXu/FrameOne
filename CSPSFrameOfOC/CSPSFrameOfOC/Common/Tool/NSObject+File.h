//
//  NSObject+File.h
//  CSPSFrameOfOC
//
//  Created by Mac on 2017/9/6.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FilePath

@optional
+ (NSString *)filePath;

@end

@interface NSObject (File)

- (void)writeToFile;
- (void)writeToFile:(NSString *)file;
- (void)writeToFile:(NSString *)file atomically:(BOOL)useAuxiliaryFile;

+ (id)getFromFile;
+ (id)getFromFile:(NSString *)file;

@end
