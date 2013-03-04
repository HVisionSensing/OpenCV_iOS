//
//  ViewController.m
//  TestHighgui
//
//  Created by Eduard Feicho on 11.08.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    started = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newFrame:) name:CVCAPTURECONTROLLER_FRAME_NOTIFICATION object:nil];
    captureController = [[CvCaptureController alloc] init];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (IBAction)actionStart;
{
    if (started) {
        [captureController stopRunning];
//        started = NO;
    } else {
        [captureController run];
//        started = YES;
    }
}

- (void)newFrame:(NSNotification*)notification;
{
    NSLog(@"received new frame");
    if (notification.object == nil) {
        return;
    }
    
    UIImage* image = (UIImage*)notification.object;
    imageView.image = image;
}


@end
