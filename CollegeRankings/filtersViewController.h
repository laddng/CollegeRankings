//
//  filtersViewController.h
//  CollegeRankings
//
//  Created by Nick Ladd on 11/19/14.
//  Copyright (c) 2014 Nick Ladd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface filtersViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIPickerView *stateSelector;

@property (weak, nonatomic) IBOutlet UISegmentedControl *typeSelector;

@property NSString *filteredByState;

@property NSString *filteredByType;

@end