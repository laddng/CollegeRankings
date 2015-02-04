//
//  resultsTableViewController.h
//  CollegeRankings
//
//  Created by Nick Ladd on 12/7/14.
//  Copyright (c) 2014 Nick Ladd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface resultsTableViewController : UITableViewController <UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) UISearchController *controller;

@property NSArray *surveyInput;

@property NSString *filteredState;

@property NSString *filteredType;

@property (weak, nonatomic) IBOutlet UIButton *showMoreResults;

@end