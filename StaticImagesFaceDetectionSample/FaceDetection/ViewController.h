//
//  ViewController.h
//  FaceDetection
//


#import <UIKit/UIKit.h>
#include "FaceDetection.h"

@interface ViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate> 
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *loadButton;

@property (weak, nonatomic) NSString *fileName;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cameraButton;
@property (nonatomic, retain) FaceDetection* cvFaceDetection;

- (IBAction)loadImageFromPhotoLibrary:(id)sender;
- (IBAction)loadImageFromCamera:(id)sender;

@end
