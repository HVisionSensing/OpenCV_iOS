//
//  ViewController.m
//  FindHomography
//
//  Created by Eduard Feicho on 26.06.12.
//  Copyright (c) 2012 Eduard Feicho. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()


@end

@implementation ViewController



#pragma mark - Properties



@synthesize imageView;
@synthesize videoCamera;


#pragma mark - UIViewController lifecycle



- (void)viewDidAppear:(BOOL)animated;
{
	[super viewDidAppear:animated];
}



- (void)viewDidLoad;
{
    [super viewDidLoad];
	
	[self loadCamera:AVCaptureVideoOrientationPortrait];
	
	enableProcessing = NO;
}



- (void)loadCamera:(AVCaptureVideoOrientation)orientation;
{
	[self.videoCamera stop];
	
	self.videoCamera = [[CvVideoCamera alloc] initWithParentView:self.imageView];
	self.videoCamera.delegate = self;
	self.videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionBack;
	self.videoCamera.defaultAVCaptureVideoOrientation = orientation;
	self.videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset352x288;
	self.videoCamera.defaultFPS = 15;
	self.videoCamera.grayscaleMode = YES;
	
	if (enableProcessing) {
		[self.videoCamera start];
	}
}

/*
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration;
{
	
}
*/

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration;
{
	NSLog(@"willRotate..");
	
	CGRect screen = [[UIScreen mainScreen] bounds];
	float pos_y, pos_x;
	pos_y = UIDeviceOrientationIsLandscape(toInterfaceOrientation) ? screen.size.width/2. : screen.size.height/2.;
	pos_x = UIDeviceOrientationIsLandscape(toInterfaceOrientation) ? screen.size.height/2. : screen.size.width/2.;
	
	CGRect bounds = self.imageView.bounds;
	NSLog(@"imageView bounds: %f, %f, %f, %f", bounds.origin.x, bounds.origin.y, bounds.size.width, bounds.size.height);
	bool flip_bounds = false;
	
	switch (toInterfaceOrientation) {
		case UIDeviceOrientationPortrait:
		case UIDeviceOrientationPortraitUpsideDown:
			flip_bounds = (bounds.size.width > bounds.size.height);
			break;
		case UIDeviceOrientationLandscapeLeft:
		case UIDeviceOrientationLandscapeRight:
			flip_bounds = (bounds.size.width < bounds.size.height);
			break;
		default:
			break;
	}
	
	if (flip_bounds) {
		bounds = CGRectMake(0, 0, bounds.size.height, bounds.size.width);
	}
	
	self.imageView.center = CGPointMake(pos_x, pos_y);
//	self.imageView.bounds = bounds;
	
	NSLog(@"-> imageView bounds: %f, %f, %f, %f", bounds.origin.x, bounds.origin.y, bounds.size.width, bounds.size.height);
//	[self.videoCamera adjustLayoutToInterfaceOrientation:toInterfaceOrientation];
	
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;
{
	return YES;
}






#pragma mark - UI Interface



- (IBAction)switchProcessingOnOff:(id)sender;
{
	enableProcessing = !enableProcessing;
	if (enableProcessing) {
		[self.videoCamera start];
	} else {
		[self.videoCamera stop];
	}
}


- (IBAction)setPortrait:(id)sender;
{
	[self loadCamera:AVCaptureVideoOrientationPortrait];
}


- (IBAction)setPortraitUpsideDown:(id)sender;
{
	[self loadCamera:AVCaptureVideoOrientationPortraitUpsideDown];
}


- (IBAction)setPortraitLandscapeLeft:(id)sender;
{
	[self loadCamera:AVCaptureVideoOrientationLandscapeLeft];
}


- (IBAction)setPortraitLandscapeRight:(id)sender;
{
	[self loadCamera:AVCaptureVideoOrientationLandscapeRight];
}



#pragma mark - Protocol VideoCameraControllerDelegate


#ifdef __cplusplus
- (void)processImage:(Mat&)image;
{
}
#endif








@end
