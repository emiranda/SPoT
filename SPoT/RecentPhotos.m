//
//  RecentPhotos.m
//  SPoT
//
//  Created by Edgar Miranda on 6/17/13.
//  Copyright (c) 2013 Edgar Miranda. All rights reserved.
//

#import "RecentPhotos.h"
#import "FlickrFetcher.h"

@implementation RecentPhotos



+(void)pushPhotoWithId:(NSNumber *)photoID withURL:(NSString *)url withTitle:(NSString *)title withSubTitle:(NSString *)subTitle
{    
    NSMutableArray *recentPhotos = [[[NSUserDefaults standardUserDefaults] arrayForKey:RECENT_PHOTOS_KEY] mutableCopy];
    
    if(!recentPhotos)
        recentPhotos = [[NSMutableArray alloc] init];
    
    [recentPhotos addObject:@{ID_KEY : photoID, URL_KEY: url, TITLE_KEY: title, FLICKR_PHOTO_DESCRIPTION: subTitle }];
    
    [[NSUserDefaults standardUserDefaults] setObject:recentPhotos forKey:RECENT_PHOTOS_KEY];

}

+(NSArray *)getRecentPhotos
{
//    id *test = [NSUserDefaults standardUserDefaults];
    
    return [[[NSUserDefaults standardUserDefaults] arrayForKey:RECENT_PHOTOS_KEY] mutableCopy];
}

@end
