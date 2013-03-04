//
//  DetailViewController.m
//  OpenCViOSDemo
//
//  Created by CHARU HANS on 7/5/12.
//  Copyright (c) 2012 University of Houston - Main Campus. All rights reserved.
//

#import "DetailViewController.h"
#import "ImageFilterViewController.h"

#pragma mark - 
#pragma mark Private Interface
@interface DetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end


@implementation DetailViewController
#pragma mark - 
#pragma mark Public Properties
@synthesize detailItem = _detailItem;
@synthesize imageView = _imageView;
@synthesize descriptionText = _descriptionText;

@synthesize masterPopoverController = _masterPopoverController;
@synthesize imageFilter;
@synthesize imageFilterController;

#pragma mark - 
#pragma mark Managing Views

- (void)setDetailItem:(NSString *)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        self.navigationItem.title = [newDetailItem capitalizedString];
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if ([self.detailItem isEqualToString:@"image filter"]) 
    {
        NSString *name = [imageFilterController getImageName];
        _imageView.image = [UIImage imageNamed:name];
        _descriptionText.text = [imageFilterController getDescription];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    imageFilterController = [[ImageFilterViewController alloc]init];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)viewDidUnload
{
   
    [self setImageView:nil];
    [self setDescriptionText:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

#pragma mark - 
#pragma mark Switching Views

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"image filter"])
    {
         imageFilterController = [segue destinationViewController];
    }
    else {
        
    }
}

- (IBAction)runButtonAction:(id)sender
{
    if([_detailItem isEqualToString:@"image filter"])
     [self performSegueWithIdentifier:@"image filter" sender:self];
}

@end
