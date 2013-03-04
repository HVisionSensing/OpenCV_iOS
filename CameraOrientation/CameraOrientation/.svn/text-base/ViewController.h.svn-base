//
//  ViewController.h
//  CameraOrientation
//
//  Created by Eduard Feicho on 26.06.12.
//  Copyright (c) 2012 Eduard Feicho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <opencv2/highgui/CvVideoCamera.h>


@interface ViewController : UIViewController<CvVideoCameraDelegate>
{
	UIImageView* imageView;
	
	CvVideoCamera* videoCamera;
	BOOL enableProcessing;
}


@property (nonatomic, retain) IBOutlet UIImageView* imageView;
@property (nonatomic, retain) CvVideoCamera* videoCamera;

- (IBAction)switchProcessingOnOff:(id)sender;
- (IBAction)setPortrait:(id)sender;
- (IBAction)setPortraitUpsideDown:(id)sender;
- (IBAction)setPortraitLandscapeLeft:(id)sender;
- (IBAction)setPortraitLandscapeRight:(id)sender;

- (void)loadCamera:(AVCaptureVideoOrientation)orientation;


@end

