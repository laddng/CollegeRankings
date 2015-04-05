//
//  filtersViewController.h
//  CollegeRankings
//
//  Created by Nick Ladd on 11/19/14.
//  Copyright (c) 2014 Nick Ladd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "filterObject.h"
#import "NMRangeSlider.h"

@interface filtersViewController : UIViewController

@property (weak, nonatomic) IBOutlet NMRangeSlider *standardSlider;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIPickerView *stateSelector;

@property (weak, nonatomic) IBOutlet UISegmentedControl *typeSelector;

@property (weak, nonatomic) IBOutlet UISlider *enrollmentSlider;

@property (weak, nonatomic) IBOutlet UILabel *enrollmentCounter;

@property (weak, nonatomic) IBOutlet UISlider *maxTuitionSlider;

@property (weak, nonatomic) IBOutlet UILabel *maxTuitionCounter;

@property filterObject *filtersToBeApplied;

@end