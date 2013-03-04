//
//  ImageFilterViewController.m
//  OpenCViOSDemo
//
//  Created by CHARU HANS on 7/6/12.
//  Copyright (c) 2012 University of Houston - Main Campus. All rights reserved.
//

#import "ImageFilterViewController.h"
#import "imageFilter.h"
#import "UIImageCVMatConverter.h"


#pragma mark - 
#pragma mark Private Interface
@interface ImageFilterViewController ()
@property (nonatomic, retain) UIImagePickerController * photoFromLibraryPicker;
@property (nonatomic,strong) UIImagePickerController * photoFromCameraPicker;
@property(nonatomic, strong) UIImage *loadImage;
@end


@implementation ImageFilterViewController
#pragma mark - 
#pragma mark Public Properties

@synthesize imageFilterView;
@synthesize filter;
@synthesize thresholdSlider;
@synthesize myToolbar;

#pragma mark - 
#pragma mark Private Propertie
@synthesize photoFromLibraryPicker;
@synthesize loadImage;
@synthesize photoFromCameraPicker;


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
	// Do any additional setup after loading the view.
    filter = [[imageFilter alloc]init];
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveProcessingResult:)];
    NSString *fileName = [[NSBundle mainBundle] pathForResource:@"fruits" ofType:@"jpg"];
    imageFilterView.image = [UIImage imageWithContentsOfFile:fileName];
    loadImage = imageFilterView.image;
    thresholdSlider.hidden = YES;
    
    //Add buttons
    UIBarButtonItem *systemItem1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                 target:self
                                                                                 action:@selector(showPhotoLibrary:)];
    
    UIBarButtonItem *systemItem2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera
                                                                                 target:self
                                                                                 action:@selector(showCameraImage:)];
    
    UIImage *diceImage = [UIImage imageNamed:@"dice.png"];
    UIButton *dice = [UIButton buttonWithType:UIButtonTypeCustom];
    dice.bounds = CGRectMake( 0, 0, diceImage.size.width, diceImage.size.height);
    [dice addTarget:self action:@selector(feelingLucky:) forControlEvents:UIControlEventTouchDown];
    [dice setImage:diceImage forState:UIControlStateNormal];
    [dice setShowsTouchWhenHighlighted:YES];
    UIBarButtonItem *systemItem3 = [[UIBarButtonItem alloc] initWithCustomView:dice];
    
    //Use this to put space in between your toolbox buttons
    UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                              target:nil
                                                                              action:nil];
    
    //Add buttons to the array
    NSArray *items = [NSArray arrayWithObjects: systemItem1, flexItem, systemItem2, flexItem, systemItem3, nil];
    
   
    
    //add array of buttons to toolbar
    [myToolbar setItems:items animated:NO];
    [self.view addSubview:myToolbar];
 
}
#pragma mark - 
#pragma mark Button Action
- (IBAction)showCameraImage:(id)sender;
{
    if(!photoFromCameraPicker)
        photoFromCameraPicker = [[UIImagePickerController alloc] init];
    
	photoFromCameraPicker.delegate = (id)self;
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
    photoFromLibraryPicker.delegate = (id)self;
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        return;
    }
    photoFromLibraryPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentModalViewController:photoFromLibraryPicker animated:YES]; 
}

-(IBAction)feelingLucky:(id)sender
{
    
    int random = arc4random()%6;
    
    if(random == 5)
        
    {   thresholdSlider.hidden = NO;
        [thresholdSlider  addTarget:self action:@selector(sliderValueChangedAction:) forControlEvents:UIControlEventValueChanged];
        imageFilterView.image = [filter processImage:loadImage number:random sliderValue:thresholdSlider.value];
        self.navigationItem.title = @"BINARY";
    }
    else
    {
        if(random == 0)
        {
            self.navigationItem.title = @"HSV";
        }
        if(random == 1)
        {
            self.navigationItem.title = @"HSL";
        }
        if(random == 2)
        {
            self.navigationItem.title = @"GRAY";
        }
        if(random == 3)
        {
            self.navigationItem.title = @"YUV";
        }
        if(random == 4)
        {
            self.navigationItem.title = @"yCrCb";
        }
        thresholdSlider.hidden = YES;
        imageFilterView.image = [filter processImage:loadImage number:random sliderValue:thresholdSlider.value];
            
        
    }
}

- (IBAction)sliderValueChangedAction:(id)sender 
{
    // particular number reflect binary
    imageFilterView.image = [filter processImage:loadImage number:5 sliderValue:[(UISlider *)sender value]];
}

#pragma mark - 
#pragma mark Picker View
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	[picker dismissModalViewControllerAnimated:YES];
    [picker dismissModalViewControllerAnimated:YES];
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"]; 
    
    if(picker==photoFromCameraPicker && picker.cameraDevice == UIImagePickerControllerCameraDeviceFront)
        image = [UIImageCVMatConverter scaleAndRotateImageFrontCamera:image];
    else
        image = [UIImageCVMatConverter scaleAndRotateImageBackCamera:image];

    imageFilterView.image = image;
    loadImage = image;
    thresholdSlider.hidden = YES;
}

- (void) saveProcessingResult:(id) sender
{
    if(imageFilterView.image) 
    {
		UIImageWriteToSavedPhotosAlbum(imageFilterView.image, self, @selector(finishUIImageWriteToSavedPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
	}
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissModalViewControllerAnimated:YES];
}

- (void)finishUIImageWriteToSavedPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
	
}


- (void)viewDidUnload
{
    [self setImageFilterView:nil];
    [self setThresholdSlider:nil];
    [self setMyToolbar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error 
  contextInfo:(void *)contextInfo
{
    // Was there an error?
    if (error != NULL)
    {
        // Show error message...
        
    }
    else  // No errors
    {
        // Show message image successfully saved
    }
}

-(NSString *)getDescription
{
    return @"Image filtering is the process of bringing variation in appearance of Image. In this demo you will experince varous types on filteration, like HSV, gray, HLS and Binary. ";
}
-(NSString *)getImageName
{
    NSString *name = [NSString stringWithString:@"imageFilter.png"];
    NSLog(@"name is %p", name);
    return name;
}

@end
