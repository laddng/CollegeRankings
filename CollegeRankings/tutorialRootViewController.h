//
//  tutorialRootViewController.h
//  CollegeRankings
//
//  Created by Nick Ladd on 1/29/15.
//  Copyright (c) 2015 Nick Ladd. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "tutorialContentViewController.h"

@interface tutorialRootViewController : UIViewController <UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageViewController;

@property (strong, nonatomic) NSArray *pageTitles;

@property (strong, nonatomic) NSArray *pageImages;

@property (weak, nonatomic) IBOutlet UIButton *skipButton;

@end