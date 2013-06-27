//
//  FlickrTableViewController.h
//  SPoT
//
//  Created by Edgar Miranda on 6/13/13.
//  Copyright (c) 2013 Edgar Miranda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlickrTableViewController : UITableViewController

// Perhaps change this to somethign more appropriate, like title strings
@property (nonatomic, strong) NSArray *items; // of NSdictionary
@property BOOL saveLastViewdPicture;

@end
