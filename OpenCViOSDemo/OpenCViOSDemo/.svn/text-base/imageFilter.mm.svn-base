//
//  imageFilter.m
//  OpenCViOSDemo
//
//  Created by CHARU HANS on 7/6/12.
//  Copyright (c) 2012 University of Houston - Main Campus. All rights reserved.
//

#import "imageFilter.h"
#import "UIImageCVMatConverter.h"

@interface imageFilter ()
#ifdef __cplusplus
-(cv::Mat)hsvMatConversion:(cv::Mat)inputMat;
-(cv::Mat)hslMatConversion:(cv::Mat)inputMat;
-(cv::Mat)grayMatConversion:(cv::Mat)inputMat;
-(cv::Mat)yuvMatConversion:(cv::Mat)inputMat;
-(cv::Mat)yCrCbMatConversion:(cv::Mat)inputMat;
-(cv::Mat)binaryMatConversion:(cv::Mat)inputMat threshold:(float)value;

#endif
@end

@implementation imageFilter


-(UIImage *)processImage:(UIImage *)image number:(int)randomNumber sliderValue:(float)value
{
    cv::Mat inputMat = [UIImageCVMatConverter cvMatFromUIImage:image];
    
    cv::Mat resultMat;
    switch (randomNumber)
    {
        case 0:
            resultMat = [self hsvMatConversion:inputMat];
            break;
        case 1:
            resultMat = [self hslMatConversion:inputMat];
            break;
        case 2:
            resultMat = [self grayMatConversion:inputMat];
            break;
        case 3:
            resultMat = [self yuvMatConversion:inputMat];
            break;
        case 4:
            resultMat = [self yCrCbMatConversion:inputMat];
            break;
        case 5:
            resultMat = [self binaryMatConversion:inputMat threshold:value];
            break;
        default:
            break;
    }
    
return [UIImageCVMatConverter UIImageFromCVMat:resultMat];

}

-(cv::Mat)hsvMatConversion:(cv::Mat)inputMat
{
    cv::Mat hsvMat;
    cv::cvtColor(inputMat, hsvMat, CV_BGR2HSV); 
    return hsvMat;
}

-(cv::Mat)hslMatConversion:(cv::Mat)inputMat
{
    cv::Mat hlsMat;
    cv::cvtColor(inputMat, hlsMat, CV_BGR2HLS);
    return hlsMat;
}
-(cv::Mat)grayMatConversion:(cv::Mat)inputMat
{
    cv::Mat grayMat;
    cv::cvtColor(inputMat, grayMat, CV_BGR2GRAY);
    return grayMat;
}
-(cv::Mat)yuvMatConversion:(cv::Mat)inputMat
{
    cv::Mat yuvMat;
    cv::cvtColor(inputMat, yuvMat, CV_BGR2YUV);
    return yuvMat;
}
-(cv::Mat)yCrCbMatConversion:(cv::Mat)inputMat
{
    cv::Mat yCrCbMat;
    cv::cvtColor(inputMat, yCrCbMat, CV_BGR2YCrCb);
    return yCrCbMat;
}

-(cv::Mat)binaryMatConversion:(cv::Mat)inputMat threshold:(float)value
{
    cv::Mat binaryMat, grayMat;
    
    cv::cvtColor(inputMat, grayMat, CV_BGR2GRAY);
    cv::threshold(grayMat,binaryMat,value,255,cv::THRESH_BINARY);
    grayMat.release();
    return binaryMat;
    
}

@end
