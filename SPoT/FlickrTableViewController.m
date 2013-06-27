//
//  FlickrTableViewController.m
//  SPoT
//
//  Created by Edgar Miranda on 6/13/13.
//  Copyright (c) 2013 Edgar Miranda. All rights reserved.
//

#import "FlickrTableViewController.h"
#import "FlickrFetcher.h"
#import "RecentPhotos.h"
#import "ImageViewController.h"

@interface FlickrTableViewController () <UISplitViewControllerDelegate>

@end

@implementation FlickrTableViewController

-(void)setItems:(NSArray *)items
{
    _items = items;
    
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [self.items count];
}

- (NSString *)titleForRow:(NSUInteger)row
{
    return [self.items[row][FLICKR_PHOTO_TITLE] description];
    // Abstract
    return @"";
}

- (NSString *)subTitleForRow:(NSUInteger)row
{
    return [self.items[row] valueForKeyPath:FLICKR_PHOTO_DESCRIPTION];    // Abstract
    return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Stanford Photo";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [self titleForRow:indexPath.row];
    cell.detailTextLabel.text = [self subTitleForRow:indexPath.row];
    
    return cell;
}

-(NSURL *)getUrlAtRow:(NSInteger)row
{
    return [FlickrFetcher urlForPhoto:self.items[row] format:FlickrPhotoFormatLarge];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if (indexPath) {
            if ([segue.identifier isEqualToString:@"Show Image"]) {
                if([segue.destinationViewController respondsToSelector:@selector(setImageURL:)])
                {
                    
                    ImageViewController *destinationImageVC = (ImageViewController *)segue.destinationViewController;
                    
                    ImageViewController *currentImageVC = (ImageViewController *)[self.splitViewController.viewControllers lastObject];
                    
                    destinationImageVC.barButtonItem = currentImageVC.barButtonItem;
                    
                    
                    NSURL *url = [self getUrlAtRow:indexPath.row];//[FlickrFetcher urlForPhoto:self.items[indexPath.row] format:FlickrPhotoFormatLarge];
                    
                    [segue.destinationViewController performSelector:@selector(setImageURL:) withObject:url];
                    
                    [segue.destinationViewController setTitle:[self titleForRow:indexPath.row]];
                    
                    
                    if (self.saveLastViewdPicture)
                        [RecentPhotos pushPhotoWithId:self.items[indexPath.row][FLICKR_PHOTO_ID] withURL:[url absoluteString] withTitle:[self titleForRow:indexPath.row] withSubTitle:[self.items[indexPath.row] valueForKeyPath:FLICKR_PHOTO_DESCRIPTION]];
                    
                }
                
            }
        }
    }
}

#pragma mark - UISplitViewControllerDelegate
-(void)awakeFromNib
{
    self.splitViewController.delegate = self;
}

-(void)splitViewController:(UISplitViewController *)svc
    willHideViewController:(UIViewController *)aViewController
         withBarButtonItem:(UIBarButtonItem *)barButtonItem
      forPopoverController:(UIPopoverController *)pc
{

    barButtonItem.title = @"Photo List";
    
    ImageViewController *imageVC = (ImageViewController *)self.splitViewController.viewControllers[1];

    
    imageVC.barButtonItem = barButtonItem;
    
//    if([imageVC respondsToSelector:@selector(addButtonToToolBar:)])
//        [imageVC performSelector:@selector(addButtonToToolBar:) withObject:barButtonItem];

}

-(void)splitViewController:(UISplitViewController *)svc
    willShowViewController:(UIViewController *)aViewController
 invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
        ImageViewController *imageVC = (ImageViewController *)self.splitViewController.viewControllers[1];
    
    imageVC.barButtonItem = nil;
}



@end
















