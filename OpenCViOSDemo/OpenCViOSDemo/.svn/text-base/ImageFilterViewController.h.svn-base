//
//  ImageFilterViewController.h
//  OpenCViOSDemo
//
//  Created by CHARU HANS on 7/6/12.
//  Copyright (c) 2012 University of Houston - Main Campus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class imageFilter;
@interface ImageFilterViewController : UIViewController<UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageFilterView;
@property (weak, nonatomic) IBOutlet UISlider *thresholdSlider;
@property (weak, nonatomic) IBOutlet UIToolbar *myToolbar;

@property (nonatomic, retain) imageFilter *filter;

-(NSString *)getDescription;
-(NSString *)getImageName;

- (void) saveProcessingResult:(id) sender;
- (IBAction)showPhotoLibrary:(id)sender;
- (IBAction)showCameraImage:(id)sender;
-(IBAction)feelingLucky:(id)sender;
- (IBAction)sliderValueChangedAction:(id)sender;

@end
