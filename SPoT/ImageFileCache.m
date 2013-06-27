//
//  ImageFileCache.m
//  SPoT
//
//  Created by Edgar Miranda on 6/26/13.
//  Copyright (c) 2013 Edgar Miranda. All rights reserved.
//

#import "ImageFileCache.h"

@implementation ImageFileCache


+(void)cacheFileUrl:(NSURL *)url
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    NSURL *cacheURL = [fileManager URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    
    
    
    
    
}

@end
