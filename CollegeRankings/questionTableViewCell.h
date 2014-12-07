//
//  questionTableViewCell.h
//  CollegeRankings
//
//  Created by Nick Ladd on 10/18/14.
//  Copyright (c) 2014 Nick Ladd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface questionTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextView *surveyQuestion;

@property (weak, nonatomic) IBOutlet UITextField *surveyInput;

@end