//
//  ViewController.h
//  OpenCViPhoneApplication1
//

#include <opencv2/core/mat.hpp>
#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *hsvButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *grayButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *binaryButton;
@property (weak, nonatomic) IBOutlet UISlider *thresholdSlider;

#ifdef __cplusplus
@property (readonly, nonatomic) cv::Mat inputMat;
#endif 

- (UIImage *)UIImageFromCVMat:(cv::Mat)cvMat;
- (cv::Mat)cvMatFromUIImage:(UIImage *)image;
- (cv::Mat)cvMatGrayFromUIImage:(UIImage *)image;

-(IBAction)hsvImageAction:(id)sender;
-(IBAction)grayImageAction:(id)sender;
-(IBAction)binaryImageAction:(id)sender;
@end
