//
//  tutorialContentViewController.h
//  CollegeRankings
//
//  Created by Nick Ladd on 1/29/15.
//  Copyright (c) 2015 Nick Ladd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface tutorialContentViewController : UIViewController

@property NSInteger pageIndex;

@property NSString *pageStatement;

@property NSString *pageImageFileName;

@property (weak, nonatomic) IBOutlet UILabel *statement;

@property (weak, nonatomic) IBOutlet UIImageView *image;

@end