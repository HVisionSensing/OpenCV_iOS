//
//  VideoViewController.h
//  RealtimeBallTracking
//
//  Created by CHARU HANS on 6/20/12.
//  Copyright (c) 2012 University of Houston - Main Campus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <opencv2/highgui/CvVideoCamera.h>
#include "BallTracker.h"


@interface VideoViewController : UIViewController<UINavigationControllerDelegate, CvVideoCameraDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *videoView;
- (IBAction)switchCamera:(id)sender;

@property (nonatomic, retain) CvVideoCamera* videoCamera;
@property (nonatomic, retain) BallTracker* cvBallTracker;
@end
