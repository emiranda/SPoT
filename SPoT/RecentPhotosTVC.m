//
//  RecentPhotosTVC.m
//  SPoT
//
//  Created by Edgar Miranda on 6/17/13.
//  Copyright (c) 2013 Edgar Miranda. All rights reserved.
//

#import "RecentPhotosTVC.h"
#import "RecentPhotos.h"

@interface RecentPhotosTVC ()

@end

@implementation RecentPhotosTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.saveLastViewdPicture = NO;
	// Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.items = [RecentPhotos getRecentPhotos];
}

-(NSURL *)getUrlAtRow:(NSInteger)row
{
    return [[NSURL alloc] initWithString:self.items[row][URL_KEY]];
    
    
}





@end
