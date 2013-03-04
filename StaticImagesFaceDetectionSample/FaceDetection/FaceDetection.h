//
//  FaceDetector.h
//  FaceDetection
//
//  Created by CHARU HANS on 6/28/12.
//  Copyright (c) 2012 University of Houston - Main Campus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FaceDetection : NSObject
-(UIImage*)detect_and_draw:(UIImage* )inputImage;
@end
