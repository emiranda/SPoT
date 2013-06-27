//
//  ImageFileCache.h
//  SPoT
//
//  Created by Edgar Miranda on 6/26/13.
//  Copyright (c) 2013 Edgar Miranda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageFileCache : NSObject

+(id)getCachedFile:(NSURL *)url;
+(void)cacheFileUrl:(NSURL *)url;

@end
