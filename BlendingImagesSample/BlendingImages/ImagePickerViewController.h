//
//  ImagePickerViewController.h
//  BlendingImages
//
//  Created by CHARU HANS on 6/13/12.
//  Copyright (c) 2012 University of Houston - Main Campus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

#pragma mark - ImagePickerViewControllerDelegate
@class ImagePickerViewController;

@protocol ImagePickerViewControllerDelegate <NSObject>
- (void)addItemViewController:(ImagePickerViewController*)controller didFinishEnteringItem:(UIImage *)item buttonTag:(NSInteger)tag;
@end


@interface ImagePickerViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate> 
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;

@property (nonatomic, weak) id <ImagePickerViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cameraButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *albumButton;
@property (nonatomic) NSInteger selectedButton;

- (IBAction)loadImageFromPhotoLibrary:(id)sender;
- (IBAction)loadImageFromCamera:(id)sender;
-(IBAction)doneButtonAction:(id)sender;
@end
