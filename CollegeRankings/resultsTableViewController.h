//
//  resultsTableViewController.h
//  CollegeRankings
//
//  Created by Nick Ladd on 12/7/14.
//  Copyright (c) 2014 Nick Ladd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "filterObject.h"

@interface resultsTableViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *surveyInputValues;

@property filterObject *filters;

@property (weak, nonatomic) IBOutlet UIButton *showMoreResults;

@end