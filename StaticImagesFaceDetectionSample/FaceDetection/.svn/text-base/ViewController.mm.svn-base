//
//  ViewController.m
//  FaceDetection
//
//  Created by Charu Hans on 6/8/12.
//  Copyright (c) 2012 University of Houston - Main Campus. All rights reserved.
//

#import "ViewController.h"
#import "UIImageCVMatConverter.h"

@interface ViewController ()
@property (nonatomic,strong) UIImagePickerController * photoFromLibraryPicker;
@property (nonatomic,strong) UIImagePickerController * photoFromCameraPicker;
@end

#pragma mark - 
#pragma mark Properties
@implementation ViewController
@synthesize imageView;
@synthesize loadButton;
@synthesize fileName;
@synthesize cameraButton;
@synthesize cvFaceDetection;
@synthesize photoFromCameraPicker,photoFromLibraryPicker;

#pragma mark - 
#pragma mark Managing Views
- (void)viewDidLoad
{
    [super viewDidLoad];
	self.cvFaceDetection = [[FaceDetection alloc] init];
}

- (void)viewDidUnload
{
    [self setImageView:nil];
    [self setLoadButton:nil];
    [self setCameraButton:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
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
    
    
    UIImage *face = [cvFaceDetection detect_and_draw:image];
    if (face != nil) {
        imageView.image = face;
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissModalViewControllerAnimated:YES];
}

#pragma mark - 
#pragma mark Button Action

- (IBAction)loadImageFromPhotoLibrary:(id)sender
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


- (IBAction)loadImageFromCamera:(id)sender
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


@end
