//
//  questionsViewController.h
//  CollegeRankings
//
//  Created by Nick Ladd on 10/18/14.
//  Copyright (c) 2014 Nick Ladd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface questionsViewController : UIViewController <UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIProgressView *progressMeter;

@property (weak, nonatomic) IBOutlet UILabel *progressText;

@property (weak, nonatomic) IBOutlet UIButton *clearButton;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *finishButton;

@end