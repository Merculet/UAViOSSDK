//
//  MWNSFileManagerUtils.h
//
//
//  Created by JackLiu on 14-7-23.
//  Copyright (c) 2014年 All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MWNSFileManagerUtils : NSObject

// 获取
+ (NSString *)filePath:(NSString *)name;

+ (NSString *)documentFilePath:(NSString *)name;

+ (void)moveFilesWithPath:(NSString *)name;

@end
