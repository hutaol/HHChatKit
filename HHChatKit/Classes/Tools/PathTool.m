//
//  PathTool.m
//  HHChatKit
//
//  Created by Henry on 2020/8/14.
//  Copyright © 2020 Henry. All rights reserved.
//

#import "PathTool.h"

@implementation PathTool

+ (NSString *)getDocumentPath {
    NSArray *userPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [userPaths objectAtIndex:0];
}

+ (NSString *)getCachePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSString *)getTemporaryPath {
    return NSTemporaryDirectory();
}

+ (NSString *)getFileDocumentPath:(NSString *)fileName {
    if (!fileName) {
        return nil;
    }
    NSString *documentDirectory = [PathTool getDocumentPath];
    NSString *fileFullPath = [documentDirectory stringByAppendingPathComponent:fileName];
    return fileFullPath;
}

+ (NSString *)getFileCachePath:(NSString *)fileName {
    if (!fileName) {
        return nil;
    }
    NSString *cacheDirectory = [PathTool getCachePath];
    NSString *fileFullPath = [cacheDirectory stringByAppendingPathComponent:fileName];
    return fileFullPath;
}

+ (NSString *)getFileResourcePath:(NSString *)fileName {
    if (!fileName) {
        return nil;
    }
    NSString *resourceDir = [[NSBundle mainBundle] resourcePath];
    return [resourceDir stringByAppendingPathComponent:fileName];
}

+ (BOOL)isExistFileInDocument:(NSString *)fileName {
    if (!fileName || fileName.length == 0) {
        return NO;
    }
    NSString *filePath = [PathTool getFileDocumentPath:fileName];
    if (!fileName) {
        return NO;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:filePath];
}

+ (BOOL)isExistFileInCache:(NSString *)fileName {
    if (!fileName || fileName.length == 0) {
        return NO;
    }
    NSString *filePath = [PathTool getFileCachePath:fileName];
    if (!fileName) {
        return NO;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:filePath];
}

+ (BOOL)isExistFileInResource:(NSString *)fileName {
    if (!fileName || fileName.length == 0) {
        return NO;
    }
    NSString *filePath = [PathTool getFileResourcePath:fileName];
    if (!filePath) {
        return NO;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:filePath];
}

+ (BOOL)isExistFile:(NSString *)aFilePath {
    if (!aFilePath || aFilePath.length == 0) {
        return NO;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:aFilePath];
}

+ (BOOL)createDirectoryAtDocument:(NSString *)dirName {
    if (!dirName) {
        return NO;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *dirPath = [PathTool getFileDocumentPath:dirName];
    if ([fileManager fileExistsAtPath:dirPath]) {
        return YES;
    }
    BOOL succ = [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    return succ;
}

+ (BOOL)createDirectoryAtCache:(NSString *)dirName {
    if (!dirName) {
        return NO;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *dirPath = [PathTool getFileCachePath:dirName];
    if ([fileManager fileExistsAtPath:dirPath]) {
        return YES;
    }
    BOOL succ = [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    return succ;
}

+ (BOOL)createDirectoryAtTemporary:(NSString *)dirName {
    if (!dirName) {
        return NO;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *tempPath = [PathTool getTemporaryPath];
    NSString *dirPath = [NSString stringWithFormat:@"%@/%@", tempPath, dirName];
    if ([fileManager fileExistsAtPath:dirPath]) {
        return YES;
    }
    BOOL succ = [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    return succ;
}

+ (BOOL)createDirectory:(NSString *)filePath {
    if (!filePath || filePath.length == 0) {
        return NO;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        return YES;
    }
    BOOL succ = [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    return succ;
}

+ (BOOL)removeFolderInDocumet:(NSString *)aFolderNameInDoc {
    if (!aFolderNameInDoc || aFolderNameInDoc.length == 0) {
        return YES;
    }
    if (![PathTool isExistFileInDocument:aFolderNameInDoc]) {
        return YES;
    }
    NSString *filePath = [PathTool getFileDocumentPath:aFolderNameInDoc];
    if (!filePath) {
        return YES;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager removeItemAtPath:filePath error:nil];
}

+ (BOOL)removeFolderInCache:(NSString *)aFolderNameInCache {
    if (!aFolderNameInCache || aFolderNameInCache.length == 0) {
        return YES;
    }
    if (![PathTool isExistFileInCache:aFolderNameInCache]) {
        return YES;
    }
    NSString *filePath = [PathTool getFileDocumentPath:aFolderNameInCache];
    if (!filePath) {
        return YES;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager removeItemAtPath:filePath error:nil];
}

+ (BOOL)deleteFileAtPath:(NSString *)filePath {
    if (!filePath || filePath.length == 0) {
        return NO;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        return [fileManager removeItemAtPath:filePath error:nil];
    }
    return NO;
}

+ (BOOL)copySourceFile:(NSString *)sourceFile toDesPath:(NSString *)desPath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSData *sourceData = [NSData dataWithContentsOfFile:sourceFile];
    BOOL e = NO;
    if (sourceData) {
        e = [fileManager createFileAtPath:desPath contents:sourceData attributes:nil];
    }
    return e;
}

+ (BOOL)moveSourceFile:(NSString *)sourceFile toDesPath:(NSString *)desPath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    [fileManager moveItemAtPath:sourceFile toPath:desPath error:&error];
    if (error) {
        return NO;
    }
    return YES;
}

+ (NSDictionary *)getFileAttributsAtPath:(NSString *)filePath {
    if (!filePath || filePath.length == 0) {
        return nil;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath] == NO) {
        return nil;
    }
    return [fileManager attributesOfItemAtPath:filePath error:nil];
}

+ (long long)getFileSize:(NSString *)filePath {
    NSDictionary *fileAttributes = [self getFileAttributsAtPath:filePath];
    if (fileAttributes) {
        NSNumber *fileSize = (NSNumber*)[fileAttributes objectForKey: NSFileSize];
        if (fileSize) {
            return [fileSize longLongValue];
        }
    }
    return 0;
}

+ (unsigned long long int)folderSize:(NSString *)folderPath {
    NSFileManager *mgr = [NSFileManager defaultManager];
    NSArray *filesArray = [mgr subpathsOfDirectoryAtPath:folderPath error:nil];
    NSEnumerator *filesEnumerator = [filesArray objectEnumerator];
    NSString *fileName;
    unsigned long long int fileSize = 0;
    while (fileName = [filesEnumerator nextObject]) {
        NSDictionary *fileDictionary = [mgr attributesOfItemAtPath:[folderPath stringByAppendingPathComponent:fileName] error:nil];
        fileSize += [fileDictionary fileSize];
    }
    return fileSize;
}

+ (long long)getFreeSpaceOfDisk {
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    NSNumber *freeSpace = [fattributes objectForKey:NSFileSystemFreeSize];
    long long space = [freeSpace longLongValue];
    return space;
}

@end
