//
//  BallTracker.m
//  RealtimeBallTracking
//
//  Created by CHARU HANS on 6/20/12.
//  Copyright (c) 2012 University of Houston - Main Campus. All rights reserved.
//



#import "BallTracker.h"
#include "UIImageCVMatConverter.h"


#pragma mark - 
#pragma mark Private Interface

@interface BallTracker(PrivateMethods)
#ifdef __cplusplus
-(cv::Mat) getThresholdMat:(cv::Mat) src;
- (CGContextRef)getContextForImage:(UIImage*)image;
#endif
@end

@implementation BallTracker


#pragma mark - 
#pragma mark OpenCV Methods

-(cv::Mat) getThresholdMat:(cv::Mat) srcMat
{
    
    cv::Mat matHSV;     
    cv::cvtColor(srcMat, matHSV, CV_BGR2HSV);// Convert the src into an HSV image
    
    cv::Mat thresholdMat;    
    // Change cvScalar values in the order of desired H(hue),S(saturation),V(value).
 // cv::inRange(matHSV, cv::Scalar( 40 , 80 , 32 , 0), cv::Scalar( 70 , 255 , 255 , 0), thresholdMat);
    //cv::inRange(matHSV, cv::Scalar(90 , 84 , 69 , 0), cv::Scalar(100 , 255 , 255 , 0), thresholdMat);
    cv::inRange(matHSV, cv::Scalar(20 , 100 , 100 , 0), cv::Scalar(100 , 255 , 255 , 0 ), thresholdMat);
    matHSV.release();
    
    return thresholdMat;
}

- (void)detectBallsInMat:(const vImage_Buffer)image withRenderContext:(CGContextRef)contextRef
{
	// process pixel buffer before rendering
	cv::Mat colorMat(image.height, image.width, CV_8UC4, image.data, image.rowBytes);
    cv::Mat thresholdMat;
    thresholdMat = [self getThresholdMat:colorMat];
    cv::GaussianBlur(thresholdMat, thresholdMat, cv::Size(9,9), 2);
    cv::Size strel_size;
    strel_size.width = 3;
    strel_size.height = 3;
    // Create an elliptical structuring element
    cv::Mat strel = cv::getStructuringElement(cv::MORPH_ELLIPSE,strel_size);
     // morpholgical smoothing
    cv::morphologyEx(thresholdMat, thresholdMat, cv::MORPH_CLOSE, strel);
    
    std::vector<cv::Vec3f> circles;
    /// Apply the Hough Transform to find the circles
    cv::HoughCircles(thresholdMat, circles, CV_HOUGH_GRADIENT, 2, thresholdMat.rows/4, 100, 100, 20, 200);
    /// Draw the circles detected
    for( size_t i = 0; i < circles.size(); i++ )
    {
        cv::Point center(cvRound(circles[i][0]), cvRound(circles[i][1]));
        int radius = cvRound(circles[i][2]);
        // circle center
        cv::circle( colorMat, center, 3, cv::Scalar(0,0,0), -1, 8, 0 );
        // circle outline
        cv::circle( colorMat, center, radius, cv::Scalar(0,0,255), 3, 8, 0 );
    }
}

- (UIImage*)detectBalls:(UIImage*)image
{

    cv::Mat colorMat = [UIImageCVMatConverter cvMatFromUIImage:image];
    cv::Mat thresholdMat;
    thresholdMat = [self getThresholdMat:colorMat];
    cv::GaussianBlur(thresholdMat, thresholdMat, cv::Size(9,9), 2);
    cv::Size strel_size;
    strel_size.width = 3;
    strel_size.height = 3;
    // Create an elliptical structuring element
    cv::Mat strel = cv::getStructuringElement(cv::MORPH_ELLIPSE,strel_size);
    // morpholgical smoothing
    cv::morphologyEx(thresholdMat, thresholdMat, cv::MORPH_CLOSE, strel);
    

    std::vector<cv::Vec3f> circles;
    /// Apply the Hough Transform to find the circles
    cv::HoughCircles(thresholdMat, circles, CV_HOUGH_GRADIENT, 1, thresholdMat.rows/4, 200, 40, 20, 200);
    // Draw the circles detected
    // get a CGContext with the image 
    CGContextRef contextRef = [self getContextForImage:image];
    // set line color
    CGContextSetRGBStrokeColor(contextRef, 1.0, 0.0, 0.0, 1);
    // set line width
    CGContextSetLineWidth(contextRef, 5.0);
    CGRect rect;

    for( size_t i = 0; i < circles.size(); i++ )
    {
        cv::Point center(cvRound(circles[i][0]), cvRound(circles[i][1]));
        int radius = cvRound(circles[i][2]);
       // circle center
        CGContextSetRGBFillColor(contextRef,0.0,0.0,0.0,1);
        rect = CGContextConvertRectToDeviceSpace(contextRef, CGRectMake(cvRound(circles[i][0]),cvRound(circles[i][1]), 8.0, 8.0));
		CGContextAddEllipseInRect(contextRef, rect);
        CGContextSetInterpolationQuality(contextRef, kCGInterpolationLow);
         CGContextDrawPath(contextRef, kCGPathFill);
        // circle outline
        rect = CGContextConvertRectToDeviceSpace(contextRef, CGRectMake(cvRound(circles[i][0]) - radius,cvRound(circles[i][1]) - radius, 2*radius, 2*radius));
		CGContextAddEllipseInRect(contextRef, rect);
        CGContextSetInterpolationQuality(contextRef, kCGInterpolationLow);
		CGContextStrokePath(contextRef);
    }
    // make image out of bitmap context
    CGImageRef cgImage = CGBitmapContextCreateImage(contextRef);
    UIImage* ballImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    CGContextRelease(contextRef);
    
    return ballImage;

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