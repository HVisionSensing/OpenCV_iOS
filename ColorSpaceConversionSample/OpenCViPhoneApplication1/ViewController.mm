//
//  ViewController.m
//  OpenCViPhoneApplication1
//


#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController

#pragma mark - 
#pragma mark Properties
@synthesize thresholdSlider;
@synthesize imageView;
@synthesize hsvButton;
@synthesize grayButton;
@synthesize binaryButton;
@synthesize inputMat;

#pragma mark - 
#pragma mark Managing Views
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSString *imageName = [[NSBundle mainBundle] pathForResource:@"fruits" ofType:@"jpg"];
    imageView.image = [UIImage imageWithContentsOfFile:imageName];
    inputMat =[self cvMatFromUIImage:imageView.image];
    thresholdSlider.hidden = YES;

}

- (void)viewDidUnload
{
    [self setImageView:nil];
    [self setHsvButton:nil];
    [self setGrayButton:nil];
    [self setBinaryButton:nil];
    [self setThresholdSlider:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - 
#pragma mark button action

-(IBAction)hsvImageAction:(id)sender
{
    thresholdSlider.hidden = YES;
    cv::Mat hsvImage;
    cv::cvtColor (inputMat, hsvImage, CV_BGR2HSV); 
    // convert cvMat to UIImage
    imageView.image = [self UIImageFromCVMat:hsvImage];
    hsvImage.release();
    
}
-(IBAction)grayImageAction:(id)sender
{
    thresholdSlider.hidden = YES;
    cv::Mat greyMat;
    cv::cvtColor(inputMat, greyMat, CV_BGR2GRAY);
    // convert cvMat to UIImage
    self.imageView.image = [self UIImageFromCVMat:greyMat];
    greyMat.release();
}
-(IBAction)binaryImageAction:(id)sender
{
    cv::Mat binaryMat, greyMat;
    thresholdSlider.hidden = NO;
    thresholdSlider.continuous = YES;
    float threshold = thresholdSlider.value;
    cv::cvtColor(inputMat, greyMat, CV_BGR2GRAY);
    cv::threshold(greyMat,binaryMat,threshold,255,cv::THRESH_BINARY);
    greyMat.release();
    // convert cvMat to UIImage
    imageView.image = [self UIImageFromCVMat:binaryMat];
    binaryMat.release();
    
}

-(UIImage *)UIImageFromCVMat:(cv::Mat)cvMat
{
    NSData *data = [NSData dataWithBytes:cvMat.data length:cvMat.elemSize()*cvMat.total()];
    CGColorSpaceRef colorSpace;
    
    if (cvMat.elemSize() == 1) {
        colorSpace = CGColorSpaceCreateDeviceGray();
    } else {
        colorSpace = CGColorSpaceCreateDeviceRGB();
    }
    
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);
    
    // Creating CGImage from cv::Mat
    CGImageRef imageRef = CGImageCreate(cvMat.cols,                                 //width
                                        cvMat.rows,                                 //height
                                        8,                                          //bits per component
                                        8 * cvMat.elemSize(),                       //bits per pixel
                                        cvMat.step[0],                            //bytesPerRow
                                        colorSpace,                                 //colorspace
                                        kCGImageAlphaNone|kCGBitmapByteOrderDefault,// bitmap info
                                        provider,                                   //CGDataProviderRef
                                        NULL,                                       //decode
                                        false,                                      //should interpolate
                                        kCGRenderingIntentDefault                   //intent
                                        );
    
    
    // Getting UIImage from CGImage
    UIImage *finalImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(colorSpace);
    
    return finalImage; 
}
- (cv::Mat)cvMatFromUIImage:(UIImage *)image
{
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(image.CGImage);
    CGFloat cols = image.size.width;
    CGFloat rows = image.size.height;
    
    cv::Mat cvMat(rows, cols, CV_8UC4); // 8 bits per component, 4 channels
    
    CGContextRef contextRef = CGBitmapContextCreate(cvMat.data,                 // Pointer to  data
                                                    cols,                       // Width of bitmap
                                                    rows,                       // Height of bitmap
                                                    8,                          // Bits per component
                                                    cvMat.step[0],              // Bytes per row
                                                    colorSpace,                 // Colorspace
                                                    kCGImageAlphaNoneSkipLast |
                                                    kCGBitmapByteOrderDefault); // Bitmap info flags
    
    CGContextDrawImage(contextRef, CGRectMake(0, 0, cols, rows), image.CGImage);
    CGContextRelease(contextRef);
    CGColorSpaceRelease(colorSpace);
    
    return cvMat;
}
- (cv::Mat)cvMatGrayFromUIImage:(UIImage *)image
{
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(image.CGImage);
    CGFloat cols = image.size.width;
    CGFloat rows = image.size.height;
    
    cv::Mat cvMat(rows, cols, CV_8UC1); // 8 bits per component, 1 channels
    
    CGContextRef contextRef = CGBitmapContextCreate(cvMat.data,                 // Pointer to data
                                                    cols,                       // Width of bitmap
                                                    rows,                       // Height of bitmap
                                                    8,                          // Bits per component
                                                    cvMat.step[0],              // Bytes per row
                                                    colorSpace,                 // Colorspace
                                                    kCGImageAlphaNoneSkipLast |
                                                    kCGBitmapByteOrderDefault); // Bitmap info flags
    
    CGContextDrawImage(contextRef, CGRectMake(0, 0, cols, rows), image.CGImage);
    CGContextRelease(contextRef);
    CGColorSpaceRelease(colorSpace);
    
    return cvMat;
}


@end
