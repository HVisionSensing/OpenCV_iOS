//
//  ViewController.m
//  RealtimeBallTracking
//
//  Created by CHARU HANS on 6/20/12.
//  Copyright (c) 2012 University of Houston - Main Campus. All rights reserved.
//

#import "ViewController.h"
#import "UIImageCVMatConverter.h"


#pragma mark - 
#pragma mark Private Interface

@interface ViewController ()
@property (nonatomic,strong) UIImagePickerController * photoFromLibraryPicker;
@property (nonatomic,strong) UIImagePickerController * photoFromCameraPicker;
@end

@implementation ViewController
#pragma mark - 
#pragma mark Public Properties
@synthesize photoLibraryButton;
@synthesize videoButton;
@synthesize cameraButton;
@synthesize imageView;
@synthesize cvBallTracker;

#pragma mark - 
#pragma mark Private Properties
@synthesize photoFromCameraPicker,photoFromLibraryPicker;


#pragma mark - 
#pragma mark Managing Views
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.cvBallTracker = [[BallTracker alloc] init];
    
}

- (void)viewDidUnload
{
    [self setPhotoLibraryButton:nil];
    [self setVideoButton:nil];
    [self setCameraButton:nil];
    [self setImageView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

#pragma mark - 
#pragma mark Button Action
- (IBAction)showCameraImage:(id)sender;
{
    if(!photoFromCameraPicker)
        photoFromCameraPicker = [[UIImagePickerController alloc] init];
    
	photoFromCameraPicker.delegate = self;
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        return;
    }
    photoFromCameraPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentModalViewController:photoFromCameraPicker animated:YES];  
}

- (IBAction)showPhotoLibrary:(id)sender;
{
	if(!photoFromLibraryPicker)
        photoFromLibraryPicker = [[UIImagePickerController alloc] init];
    photoFromLibraryPicker.delegate = self;
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        return;
    }
    photoFromLibraryPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentModalViewController:photoFromLibraryPicker animated:YES]; 
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark - 
#pragma mark Picker View
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	[picker dismissModalViewControllerAnimated:YES];
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"]; 
    
    if(picker==photoFromCameraPicker && picker.cameraDevice == UIImagePickerControllerCameraDeviceFront)
        image = [UIImageCVMatConverter scaleAndRotateImageFrontCamera:image];
    else
        image = [UIImageCVMatConverter scaleAndRotateImageBackCamera:image];
    

    UIImage *ball = [cvBallTracker detectBalls:image];
    imageView.image = ball;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissModalViewControllerAnimated:YES];
}

@end
