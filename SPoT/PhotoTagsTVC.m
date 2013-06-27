//
//  StanfordPhotosTVC.m
//  SPoT
//
//  Created by Edgar Miranda on 6/13/13.
//  Copyright (c) 2013 Edgar Miranda. All rights reserved.
//

#import "PhotoTagsTVC.h"
#import "FlickrFetcher.h"

@interface  PhotoTagsTVC()

@property (strong, nonatomic) NSMutableDictionary *tagValues;
@property (strong, nonatomic) NSArray *ignoredTags;

@end


@implementation PhotoTagsTVC

-(NSArray *)ignoredTags
{
    return @[@"cs193pspot", @"portrait", @"landscape"];
}

-(NSMutableDictionary *)tagValues
{
    if(!_tagValues) _tagValues = [[NSMutableDictionary alloc] init];
    return _tagValues;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadLatestPhotosFromFlickr];
    [self.refreshControl addTarget:self action:@selector(loadLatestPhotosFromFlickr) forControlEvents:UIControlEventValueChanged];
}

-(void)loadLatestPhotosFromFlickr
{
    [self.refreshControl beginRefreshing];
    dispatch_queue_t fetchQ = dispatch_queue_create("Fetch Q", NULL);
    dispatch_async(fetchQ, ^{
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        NSArray *latestPhotos = [self formatDataForDisplay:[FlickrFetcher stanfordPhotos]];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.items = [latestPhotos sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                
                NSString *string1 = (NSString *)obj1;
                NSString *string2 = (NSString *)obj2;
                NSComparisonResult result =  [string1 caseInsensitiveCompare:string2];
               
                
                return result;
            }];
            [self.refreshControl endRefreshing];
        });
    });
}


// Returns an NSArray that contains dictionaries with tags and keys and an array of
// photos as values
-(NSArray *)formatDataForDisplay:(NSArray *)items
{

    for (NSDictionary *photo in items) {
        
        NSString *stringOfTags = photo[FLICKR_TAGS];
        NSArray *tags = [stringOfTags componentsSeparatedByString:@" "];
        
        // TODO: Do not include the tags described in the assignment
        for (NSString *tag in tags)
        {
            if(![self isValidTag:tag])
                continue;
                
            NSMutableArray *photosAssociatedWithTag = [self.tagValues objectForKey:tag];

            if (!photosAssociatedWithTag) {
                photosAssociatedWithTag = [[NSMutableArray alloc] initWithObjects:photo, nil];
                
                [self.tagValues setObject:photosAssociatedWithTag forKey:tag];
            }else{
                [photosAssociatedWithTag addObject:photo];
            }
        }
    }
    
    
    
    return [self.tagValues allKeys];
}

-(BOOL)isValidTag:(NSString *)tag
{
    for (NSString *ignoredTag in self.ignoredTags) {
        if([tag isEqualToString:ignoredTag])
            return NO;
    }
    
    return YES;
}

- (NSString *)titleForRow:(NSUInteger)row
{
    return [self.items[row] capitalizedString];
}

- (NSString *)subTitleForRow:(NSUInteger)row
{

    NSUInteger numberOfPhotos = [[self.tagValues valueForKey:self.items[row]] count];
    NSArray *finalStringArray = [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%d", numberOfPhotos], @" photos", nil];
    
    return [finalStringArray componentsJoinedByString:@""];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if (indexPath) {
            if ([segue.identifier isEqualToString:@"Show Photo List"]) {
                if([segue.destinationViewController respondsToSelector:@selector(setItems:)])
                {
                    
                    UITableViewCell *cell = (UITableViewCell *)sender;
                    NSArray *photos = [self.tagValues objectForKey:[[[NSString alloc] initWithString:cell.textLabel.text] lowercaseString]];
                    
                    [segue.destinationViewController setTitle:cell.textLabel.text];
                    
                    [segue.destinationViewController performSelector:@selector(setItems:) withObject:photos];
                }

            }
        }
    }
}



@end
