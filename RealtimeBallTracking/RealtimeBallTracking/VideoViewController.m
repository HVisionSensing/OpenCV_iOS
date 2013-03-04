//
//  VideoViewController.m
//  RealtimeBallTracking
//
//  Created by CHARU HANS on 6/20/12.
//  Copyright (c) 2012 University of Houston - Main Campus. All rights reserved.
//

#import "VideoViewController.h"

@interface VideoViewController ()

@end

@implementation VideoViewController
@synthesize videoView;
@synthesize videoCamera;
@synthesize cvBallTracker;


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
    self.cvBallTracker = [[BallTracker alloc] init];
	
	self.videoCamera = [[CvVideoCamera alloc] init];
	self.videoCamera.delegate = self;
	self.videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionFront;
	self.videoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
	self.videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset352x288;
	self.videoCamera.defaultFPS = 15;
    [self.videoCamera start];
}


- (void)viewDidUnload
{
    [self setVideoView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - 
#pragma mark Button Action

- (IBAction)switchCamera:(id)sender;
{
	[self.videoCamera switchCameras];
}

#pragma mark - Protocol VideoCameraControllerDelegate


- (void)videoCameraViewController:(CvVideoCamera*)videoCameraViewController capturedImage:(UIImage *)image;
{
	NSLog(@"videoCameraViewController capturedImage: image info [w,h] = [%f,%f]", image.size.width, image.size.height);
	[self.videoView setImage:image];
}

- (CGImageRef)processImage:(const vImage_Buffer)image withRenderContext:(CGContextRef)contextRef;
{
    [cvBallTracker detectBallsInMat:image withRenderContext:(CGContextRef)contextRef];
	return nil;
}

- (void)videoCameraViewControllerDone:(CvVideoCamera*)videoCameraViewController;
{
	
}
- (BOOL)allowPreviewLayer;
{
	return NO;
}

- (BOOL)allowMultipleImages;
{
	return YES;
}

- (UIView*)getPreviewView;
{
	return self.videoView;
}

@end
