//
//  DetailViewController.h
//  OpenCViOSDemo
//
//  Created by CHARU HANS on 7/5/12.
//  Copyright (c) 2012 University of Houston - Main Campus. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "imageFilter.h"

@class ImageFilterViewController;
@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) NSString *detailItem;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *descriptionText;

@property (nonatomic, retain) imageFilter *imageFilter;
@property (strong, nonatomic) ImageFilterViewController* imageFilterController;

- (IBAction)runButtonAction:(id)sender;
@end
