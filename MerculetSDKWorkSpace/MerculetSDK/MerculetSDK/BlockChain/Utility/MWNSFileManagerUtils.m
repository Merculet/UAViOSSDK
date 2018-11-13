//
//  MWNSFileManagerUtils.m
//
//
//  Created by JackLiu on 14-7-23.
//  Copyright (c) 2014年 All rights reserved.
//

#import "MWNSFileManagerUtils.h"

@implementation MWNSFileManagerUtils

+ (NSString *)filePath:(NSString *)name
{
    NSString *Path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filename = [Path stringByAppendingPathComponent:name];
    return filename;
}

+ (NSString *)documentFilePath:(NSString *)name
{
    NSString *Path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filename = [Path stringByAppendingPathComponent:name];
    return filename;
}

+ (void)moveFilesWithPath:(NSString *)name
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:[MWNSFileManagerUtils documentFilePath: name]])
    {
        return;
    }
    [[NSFileManager defaultManager] moveItemAtPath:[MWNSFileManagerUtils documentFilePath: name] toPath:[MWNSFileManagerUtils filePath: name] error:nil];
}

@end
