//
//  detailTableViewController.h
//  CollegeRankings
//
//  Created by Niclas Ladd on 4/4/15.
//  Copyright (c) 2015 Nick Ladd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "collegeObject.h"

@interface detailTableViewController : UITableViewController

@property collegeObject *collegeInfo;

@property (weak, nonatomic) IBOutlet UILabel *uniName;
@property (weak, nonatomic) IBOutlet UILabel *uniTown;
@property (weak, nonatomic) IBOutlet UILabel *uniType;
@property (weak, nonatomic) IBOutlet UIButton *uniURL;
@property (weak, nonatomic) IBOutlet UILabel *rankingText;

@end