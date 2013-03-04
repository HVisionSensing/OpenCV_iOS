//
//  FaceDetector.m
//  FaceDetection
//
//  Created by CHARU HANS on 6/28/12.
//  Copyright (c) 2012 University of Houston - Main Campus. All rights reserved.
//

#import "FaceDetection.h"
#import <opencv2/imgproc/imgproc_c.h>
#import <opencv2/objdetect/objdetect.hpp>
#import "UIImageCVMatConverter.h"


@interface FaceDetection ()


- (CGContextRef)getContextForImage:(UIImage*)image;
-(cv::CascadeClassifier*)loadClassifier;
@end

@implementation FaceDetection




#pragma mark - 
#pragma mark Face Detection

-(cv::CascadeClassifier*)loadClassifier
{
    NSString* haar = [[NSBundle mainBundle] pathForResource:@"haarcascade_frontalface_default" ofType:@"xml"];    
    cv::CascadeClassifier* cascade = new cv::CascadeClassifier();
    cascade->load([haar UTF8String]);
    return cascade;
}

-(UIImage*)detect_and_draw:(UIImage* )inputImage
{
    int scale = 2;
    cv::Size minSize = cvSize(30, 30);
    float haarScale = 1.3f;
    int minNeighbors = 2;
    int haarFlags = 0 | CV_HAAR_DO_CANNY_PRUNING;
    cv::Mat grayMat;
    std::vector<cv::Rect> faces;
    cv::CascadeClassifier* faceCascade;
    cv::Mat cvMat =[UIImageCVMatConverter cvMatFromUIImage:inputImage];
    if(cvMat.channels() == 1)
        grayMat = cvMat;
    else{
        grayMat = cv :: Mat(cvMat.rows,cvMat.cols, CV_8UC3);
        cv::cvtColor(cvMat, grayMat, CV_BGR2GRAY);
    }
    cv::Mat smallMat =  cv::Mat((cvMat.rows / scale),(cvMat.cols / scale),CV_8UC3);
    
    // scale input image for faster processing
    cv::resize(grayMat, smallMat, smallMat.size(),0,0,CV_INTER_LINEAR);
    cv::equalizeHist(smallMat, smallMat);
    
    // Load XML   
    faceCascade = [self loadClassifier];
    CvMemStorage* storage = cvCreateMemStorage(0);
    // detect face
    faceCascade->detectMultiScale( grayMat, faces, haarScale, minNeighbors, haarFlags, minSize );
    smallMat.release();
    
    // get a CGContext with the image 
	CGContextRef contextRef = [self getContextForImage:inputImage];
    // set line color
    CGContextSetRGBStrokeColor(contextRef, 1.0, 1.0, 0.0, 1);
    // set line width
    CGContextSetLineWidth(contextRef, 5.0);
    
    // for each face found, draw a box
    for( int i = 0; i < faces.size(); i++ )
    {        
        CvRect rect = faces[i];
        CGRect faceRect = CGContextConvertRectToDeviceSpace(contextRef,CGRectMake(rect.x , rect.y , rect.width , rect.height));
        CGContextAddRect(contextRef, faceRect);
        CGContextStrokePath(contextRef);
    }
    // make image out of bitmap context
    CGImageRef cgImage = CGBitmapContextCreateImage(contextRef);
    UIImage* faceImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    CGContextRelease(contextRef);
    
    cvReleaseMemStorage(&storage);
    
    return faceImage;
    
}

#pragma mark - 
#pragma mark Image Context

- (CGContextRef)getContextForImage:(UIImage*)image
{
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(image.CGImage);
    CGFloat cols = image.size.width;
    CGFloat rows = image.size.height;
    CGFloat widthStep = image.size.width;
    
    CGContextRef contextRef = CGBitmapContextCreate(NULL,                 // Pointer to  data
                                                    cols,                       // Width of bitmap
                                                    rows,                       // Height of bitmap
                                                    8,                          // Bits per component
                                                    widthStep*4,              // Bytes per row
                                                    colorSpace,                 // Colorspace
                                                    kCGImageAlphaNoneSkipLast |
                                                    kCGBitmapByteOrderDefault); // Bitmap info flags
    
    CGContextDrawImage(contextRef, CGRectMake(0, 0, cols, rows), image.CGImage);
    
    return contextRef;
    
}

@end
