//
//  ViewController.m
//  Shooter
//
//  Created by Geppy Parziale on 2/24/12.
//  Copyright (c) 2012 iNVASIVECODE, Inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <AVCaptureVideoDataOutputSampleBufferDelegate>

@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoDataOutput *dataOutput;
@property (nonatomic, strong) CALayer *customPreviewLayer;

- (void)setupCameraSession;
@end


@implementation ViewController
{
    AVCaptureSession *_captureSession;
    AVCaptureVideoDataOutput *_dataOutput;
    
    CALayer *_customPreviewLayer;
}


@synthesize captureSession = _captureSession;
@synthesize dataOutput = _dataOutput;
@synthesize customPreviewLayer = _customPreviewLayer;


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupCameraSession];    
    
    [_captureSession startRunning];
}

- (void)setupCameraSession
{    
    ICLog;
    
    // Session
    _captureSession = [AVCaptureSession new];    
    [_captureSession setSessionPreset:AVCaptureSessionPresetLow];        
    
    // Capture device
    AVCaptureDevice *inputDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error;
    
    // Device input
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:inputDevice error:&error];
	if ( [_captureSession canAddInput:deviceInput] )
		[_captureSession addInput:deviceInput];
    
    // Preview
    _customPreviewLayer = [CALayer layer];
    _customPreviewLayer.bounds = CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width);
    _customPreviewLayer.position = CGPointMake(self.view.frame.size.width/2., self.view.frame.size.height/2.);
    _customPreviewLayer.affineTransform = CGAffineTransformMakeRotation(M_PI/2); 
    [self.view.layer addSublayer:_customPreviewLayer];
    
    _dataOutput = [AVCaptureVideoDataOutput new];
    _dataOutput.videoSettings = [NSDictionary dictionaryWithObject:[NSNumber numberWithUnsignedInt:kCVPixelFormatType_420YpCbCr8BiPlanarFullRange] 
                                                            forKey:(NSString *)kCVPixelBufferPixelFormatTypeKey];
    
    [_dataOutput setAlwaysDiscardsLateVideoFrames:YES];
        
    if ( [_captureSession canAddOutput:_dataOutput] )
        [_captureSession addOutput:_dataOutput];    
    
    [_captureSession commitConfiguration];

    dispatch_queue_t queue = dispatch_queue_create("VideoQueue", DISPATCH_QUEUE_SERIAL);
    [_dataOutput setSampleBufferDelegate:self queue:queue];
}


- (void)maxFromImage:(const vImage_Buffer)src toImage:(const vImage_Buffer)dst
{
    int kernelSize = 7;
    vImageMin_Planar8(&src, &dst, NULL, 0, 0, kernelSize, kernelSize, kvImageDoNotTile);
}


- (void)captureOutput:(AVCaptureOutput *)captureOutput
didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer
       fromConnection:(AVCaptureConnection *)connection
{
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    CVPixelBufferLockBaseAddress(imageBuffer, 0);

    // For the iOS the luma is contained in full plane (8-bit)
    size_t width = CVPixelBufferGetWidthOfPlane(imageBuffer, 0);
    size_t height = CVPixelBufferGetHeightOfPlane(imageBuffer, 0);
    size_t bytesPerRow = CVPixelBufferGetBytesPerRowOfPlane(imageBuffer, 0);
    
    Pixel_8 *lumaBuffer = CVPixelBufferGetBaseAddressOfPlane(imageBuffer, 0);
    
    const vImage_Buffer inImage = { lumaBuffer, height, width, bytesPerRow };
    
    Pixel_8 *outBuffer = (Pixel_8 *)calloc(width*height, sizeof(Pixel_8));            
    const vImage_Buffer outImage = { outBuffer, height, width, bytesPerRow };
    [self maxFromImage:inImage toImage:outImage];
    
    CGColorSpaceRef grayColorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate(outImage.data, width, height, 8, bytesPerRow, grayColorSpace, kCGImageAlphaNone);
    CGImageRef dstImageFilter = CGBitmapContextCreateImage(context);
    
    dispatch_sync(dispatch_get_main_queue(), ^{
        _customPreviewLayer.contents = (__bridge id)dstImageFilter;
    });
    
    CGImageRelease(dstImageFilter);
    CGContextRelease(context);
    CGColorSpaceRelease(grayColorSpace);
}



//- (CAAnimation *)animationForRotationX:(float)x Y:(float)y andZ:(float)z
//{
//    CATransform3D transform;
//    transform = CATransform3DMakeRotation(M_PI, x, y, z);
//    
//    CABasicAnimation* animation;
//    animation = [CABasicAnimation animationWithKeyPath:@"transform"];
//    animation.toValue = [NSValue valueWithCATransform3D:transform];
//    animation.duration = 2;
//    animation.cumulative = YES;
//    animation.repeatCount = 10000;
//    
//    return animation;
//}     

@end
