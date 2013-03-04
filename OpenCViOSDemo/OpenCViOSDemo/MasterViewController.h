//
//  MasterViewController.h
//  OpenCViOSDemo
//
//  Created by CHARU HANS on 7/5/12.
//  Copyright (c) 2012 University of Houston - Main Campus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;

@property (nonatomic, strong) NSArray *demoList;

@end
