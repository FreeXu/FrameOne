//
//  NSObject+File.m
//  CSPSFrameOfOC
//
//  Created by Mac on 2017/9/6.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "NSObject+File.h"

@implementation NSObject (File)

+ (NSString *)getFileRootDir {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSString *)getDefaultFilePath {
    NSString *className = NSStringFromClass(self.class);
    return [className lowercaseString];
}

+ (NSString *)getFinalFilePath {
    NSString *filePath;
    if ([self conformsToProtocol:@protocol(FilePath)] && [self respondsToSelector:@selector(filePath)]) {
        filePath = [self.class filePath];
    }
    else {
        filePath = [self getDefaultFilePath];
    }
    filePath = [[self getFileRootDir] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", filePath]];
    return filePath;
}

- (void)writeToFile {
    [self writeToFile:[self.class getFinalFilePath]];
}

- (void)writeToFile:(NSString *)file {
    [self writeToFile:file atomically:YES];
}

- (void)writeToFile:(NSString *)file atomically:(BOOL)useAuxiliaryFile {
    if (![self respondsToSelector:@selector(encodeWithCoder:)]) {
        NSLog(@"未实现encode方法，写入失败");
        return;
    }
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    [data writeToFile:file atomically:useAuxiliaryFile];
}

+ (id)getFromFile {
    return [self getFromFile:[self getFinalFilePath]];
}

+ (id)getFromFile:(NSString *)file {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:file];
}

@end
