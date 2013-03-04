//
//  ImagePickerViewController.m
//  BlendingImages
//
//  Created by CHARU HANS on 6/13/12.
//  Copyright (c) 2012 University of Houston - Main Campus. All rights reserved.
//

#import "ImagePickerViewController.h"
#import "UIImageCVMatConverter.h"

@interface ImagePickerViewController ()
@property (nonatomic,strong) UIImagePickerController * photoFromLibraryPicker;
@property (nonatomic,strong) UIImagePickerController * photoFromCameraPicker;
@end

#pragma mark - 
#pragma mark Properties

@implementation ImagePickerViewController
@synthesize photoImageView;
@synthesize cameraButton;
@synthesize albumButton;
@synthesize doneButton;
@synthesize delegate;
@synthesize selectedButton;
@synthesize photoFromCameraPicker,photoFromLibraryPicker;

#pragma mark - 
#pragma mark Managing Views
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    doneButton.enabled = NO;
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setPhotoImageView:nil];
    [self setCameraButton:nil];
    [self setAlbumButton:nil];
    [self setDelegate:nil];
    [self setSelectedButton:nil];
    [self setDoneButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
    
    photoImageView.image = image;
    
    
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
    
    
    doneButton.enabled = YES;
    
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
    

    doneButton.enabled = YES;
    
}
-(IBAction)doneButtonAction:(id)sender
{
    UIImage* image = photoImageView.image;
    [delegate addItemViewController:self didFinishEnteringItem:image buttonTag:selectedButton];
    [self dismissModalViewControllerAnimated:YES];
}

@end
