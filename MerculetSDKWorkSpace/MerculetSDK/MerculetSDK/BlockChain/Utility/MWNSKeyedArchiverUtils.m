//
//  MWNSKeyedArchiverUtils.m
//
//
//  Created by JackLiu on 14-7-23.
//  Copyright (c) 2014年 All rights reserved.
//

#import "MWNSKeyedArchiverUtils.h"
#import "MWNSFileManagerUtils.h"
#import "MWLog.h"
#import "MWCommonUtil.h"

@implementation MWNSKeyedArchiverUtils

+ (void)archiveObject:(id)object toPath:(NSString *)path
{
    //TODO:*** -[NSFileManager fileSystemRepresentationWithPath:]: unable to allocate memory for length (1072) (merculet queuePersistent) 
//    [self clearArchive:path];
    if ([MWCommonUtil  isBlank:object]) return;
    
    NSData *data;
    if ([object isKindOfClass:[NSData class]])
    {
        data = (NSData *)object;
    }
    else
    {
        data = [NSKeyedArchiver archivedDataWithRootObject:object];
    }
    
    double dataLength = data.length/1024.0/1024.0/1024.0;
    
    if (dataLength > [self availableMeory])
    {
        return;
    }
    
    [NSKeyedArchiver archiveRootObject:object toFile: [MWNSFileManagerUtils filePath: path]];
}

+ (id)unarchiveObjectWithPath:(NSString *)path
{
    return  [NSKeyedUnarchiver unarchiveObjectWithFile: [MWNSFileManagerUtils filePath: path]];
}

+ (void)clearArchive:(NSString *)path
{
    NSString * filepath = [MWNSFileManagerUtils filePath: path];
    [[NSFileManager defaultManager] removeItemAtPath: filepath error: nil];
}

+ (double)availableMeory
{
    float totalSpace;
    float totalFreeSpace=0.f;
    
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    if (dictionary) {
        NSNumber *fileSystemSizeInBytes = [dictionary objectForKey: NSFileSystemSize];
        NSNumber *freeFileSystemSizeInBytes = [dictionary objectForKey:NSFileSystemFreeSize];
        totalSpace = [fileSystemSizeInBytes floatValue]/1024.0f/1024.0f/1024.0f;
        totalFreeSpace = [freeFileSystemSizeInBytes floatValue]/1024.0f/1024.0f/1024.0f;
        
        [MWLog log:[NSString stringWithFormat:@"Memory Capacity of %.2f GB with %.2f GB Free memory available.", totalSpace, totalFreeSpace]];
        
    } else {
        totalSpace = 1.0f;
        [MWLog log:[NSString stringWithFormat:@"Error Obtaining System Memory Info: Domain = %@, Code = %li", [error domain], (long)[error code]]];
    }
    return totalFreeSpace;
}

@end
