//
//  ViewController.h
//  RealtimeBallTracking
//
//  Created by CHARU HANS on 6/20/12.
//  Copyright (c) 2012 University of Houston - Main Campus. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "BallTracker.h"

@interface ViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *photoLibraryButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *videoButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cameraButton;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) BallTracker* cvBallTracker;

- (IBAction)showCameraImage:(id)sender;
- (IBAction)showPhotoLibrary:(id)sender;

@end
