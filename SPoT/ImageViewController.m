//
//  ImageViewController.m
//  SPoT
//
//  Created by Edgar Miranda on 6/17/13.
//  Copyright (c) 2013 Edgar Miranda. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (strong, nonatomic) UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (nonatomic) BOOL didUserZoom;
@end

@implementation ImageViewController

-(void)setImageURL:(NSURL *)imageURL
{
    _imageURL = imageURL;
    [self resetImage];
}

-(void)resetImage
{
    
    if (self.scrollView)
    {
        self.scrollView.contentSize = CGSizeZero;
        self.imageView.image = nil;
        
        // Need to make sure the user didn't try to load
        // another image while we were still loading this image
        NSURL *imageURL = self.imageURL;
        
        dispatch_queue_t imageFectherQ = dispatch_queue_create("Image Fetcher",NULL);
        
        dispatch_async(imageFectherQ, ^{
            
            [self.spinner startAnimating];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
            NSData *imageData = [[NSData alloc] initWithContentsOfURL:self.imageURL];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            UIImage *image = [[UIImage alloc] initWithData:imageData];
            [self.spinner stopAnimating];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if(self.imageURL == imageURL && image){
                    
                    self.scrollView.zoomScale = 1.0;
                    //            float zoomScale = self.scrollView.bounds.size.width / self.imageView.image.size.width;;
                    //            self.scrollView.zoomScale = zoomScale;
                    self.scrollView.contentSize = image.size;
                    self.imageView.image = image;
                    self.imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
                }
            });
        });
    }
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    float zoomScale = self.scrollView.bounds.size.width / self.imageView.image.size.width;;
    self.scrollView.zoomScale = zoomScale;
}


-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
//    float imageWidth = self.imageView.image.size.width;
    
//    float scrollWidth = self.scrollView.bounds.size.width;
    
    return self.imageView;
}

-(UIImageView *)imageView
{
    if(!_imageView) _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    return _imageView;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.scrollView addSubview:self.imageView];
    
    self.didUserZoom = NO;
    
    self.scrollView.minimumZoomScale = 0.2;
    self.scrollView.maximumZoomScale = 5.0;
    self.scrollView.delegate = self;
    
    if (self.barButtonItem) {
        [self.toolBar setItems:@[self.barButtonItem] animated:YES];
    }
    
    [self resetImage];
}

-(void)setBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    
    _barButtonItem = barButtonItem;
    
    self.toolBar.items = nil;
    
    if(barButtonItem)
        [self.toolBar setItems:@[self.barButtonItem] animated:YES];
    
//    if(self.barButtonItem)
//        [self.toolBar setItems:@[self.barButtonItem] animated:YES];
//    else
//        [self.toolBar.items mutableCopy]
    
        
        
}





@end
