//
//  RecentPhotos.h
//  SPoT
//
//  Created by Edgar Miranda on 6/17/13.
//  Copyright (c) 2013 Edgar Miranda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecentPhotos : NSObject

#define RECENT_PHOTOS_KEY @"recent_photos"
#define ID_KEY @"id"
#define URL_KEY @"url"
#define TITLE_KEY @"title"
#define SUB_TITLE_KEY @"sub_title"

+(void)pushPhotoWithId:(NSNumber *)photoID withURL:(NSString *)url withTitle:(NSString *)title withSubTitle:(NSString *)subTitle;

+(NSArray *)getRecentPhotos;

@end
