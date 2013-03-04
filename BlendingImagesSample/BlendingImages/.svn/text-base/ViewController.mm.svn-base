//
//  ViewController.m
//  BlendingImages
//
//  Created by CHARU HANS on 6/13/12.
//  Copyright (c) 2012 University of Houston - Main Campus. All rights reserved.
//

#import "ViewController.h"
#import <opencv2/imgproc/imgproc_c.h>
#import <opencv2/objdetect/objdetect.hpp>
#import "UIImageCVMatConverter.h"

#pragma mark - 
#pragma mark - Private Interface
@interface ViewController ()
@property (strong, nonatomic) UIImage *imageOne;
@property (strong, nonatomic) UIImage *imageTwo;
@property (assign, nonatomic) cv::Mat sourceMat1;
@property (assign, nonatomic) cv::Mat sourceMat2;

-(UIImage *)blendingImage:(double) alpha;
@end

@implementation ViewController

#pragma mark - 
#pragma mark Properties
@synthesize imageView;
@synthesize imageOneButton;
@synthesize imageTwoButton;
@synthesize blendImageButton;
@synthesize alphaSlider;
@synthesize imageOne;
@synthesize imageTwo;
@synthesize sourceMat1;
@synthesize sourceMat2;

#pragma mark - 
#pragma mark Managing Views
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    alphaSlider.hidden = YES;
}

- (void)viewDidUnload
{
    [self setImageView:nil];
    [self setImageOneButton:nil];
    [self setImageTwoButton:nil];
    [self setBlendImageButton:nil];
    [self setAlphaSlider:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - 
#pragma mark ImagePickerViewController Methods
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    // button tag
    NSInteger tagIndex;     

	if ([segue.identifier isEqualToString:@"imageOne"] || [segue.identifier isEqualToString:@"imageTwo"])
	{
		ImagePickerViewController *imagePicker = (ImagePickerViewController *)[segue destinationViewController];
        imagePicker.delegate = (id)self;
        // Get button tag
        tagIndex = [(UIButton *)sender tag];
        [imagePicker setSelectedButton:tagIndex];
	}
}

- (void)addItemViewController:(ImagePickerViewController *)controller didFinishEnteringItem:(UIImage *)image buttonTag:(NSInteger)tag
{
    // image one button is clicked
    if(tag == 0)
    {
        imageOne = image;
        sourceMat1 =[UIImageCVMatConverter cvMatFromUIImage:imageOne];
    }
    // image two button is clicked
    else if(tag == 1)
    {
        imageTwo = image;
        sourceMat2 =[UIImageCVMatConverter cvMatFromUIImage:imageTwo];
    }
    imageView.image = image;
    alphaSlider.hidden = YES;
     
}
#pragma mark - 
#pragma mark Button Action
-(IBAction)blendImageAction:(id)sender
{
    
    if(imageOne == NULL)
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Image One!" message:@"image one is null" delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:nil];
        
        [alert show];
        return;
    }
    if(imageTwo == NULL)
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Image Two!" message:@"image two is null" delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:nil];
        
        [alert show];
        return;
    }
    alphaSlider.hidden = NO;
  //  alphaSlider.continuous = YES;
        
    float alpha = alphaSlider.value;
    UIImage* image = [self blendingImage:alpha];
    [self.imageView setImage:image];
}

#pragma mark - 
#pragma mark OpenCV Blend Images
-(UIImage *)blendingImage:(double) alpha
{
    double beta;
    cv::Mat destinationMat;
    // make sure inputs are of same size
    int Rows1 = sourceMat1.rows;
    int Cols1 =  sourceMat1.cols;
    int Rows2 = sourceMat2.rows;
    int Cols2 = sourceMat2.cols;
    
    int RowsMin = std::min(Rows1,Rows2);
    int ColsMin = std::min(Cols1,Cols2);
    cv::Size size = cvSize(RowsMin , ColsMin);
    
    cv::resize(sourceMat1, sourceMat1, size,0,0,CV_INTER_LINEAR);
    cv::resize(sourceMat2, sourceMat2, size,0,0,CV_INTER_LINEAR);
    

    beta = ( 1.0 - alpha );
    cv::addWeighted( sourceMat1, alpha, sourceMat2, beta, 0.0, destinationMat);
    
    UIImage* blend = [UIImageCVMatConverter UIImageFromCVMat:destinationMat];
    destinationMat.release();
    
    return blend;  
}


       
@end

