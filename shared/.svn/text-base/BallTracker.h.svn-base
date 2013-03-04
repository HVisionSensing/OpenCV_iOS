//
//  BallTracker.h
//  RealtimeBallTracking
//
//  Created by CHARU HANS on 6/20/12.
//  Copyright (c) 2012 University of Houston - Main Campus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <Accelerate/Accelerate.h>

#ifdef __cplusplus

#include <opencv2/objdetect/objdetect.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/core/core.hpp>

#endif

@interface BallTracker : NSObject
- (void)detectBallsInMat:(const vImage_Buffer)image withRenderContext:(CGContextRef)contextRef;
- (UIImage*)detectBalls:(UIImage*)image;
@end
