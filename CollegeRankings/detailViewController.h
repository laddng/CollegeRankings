//
//  detailViewController.h
//  CollegeRankings
//
//  Created by Nick Ladd on 10/18/14.
//  Copyright (c) 2014 Nick Ladd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "collegeObject.h"

@interface detailViewController : UIViewController

@property collegeObject *collegeInfo;

@property (weak, nonatomic) IBOutlet UILabel *uniName;
@property (weak, nonatomic) IBOutlet UILabel *uniTown;
@property (weak, nonatomic) IBOutlet UILabel *uniType;
@property (weak, nonatomic) IBOutlet UIButton *uniURL;

@property (weak, nonatomic) IBOutlet UILabel *uniIn;
@property (weak, nonatomic) IBOutlet UILabel *uniInLabel;
@property (weak, nonatomic) IBOutlet UILabel *uniOut;
@property (weak, nonatomic) IBOutlet UILabel *uniOutLabel;

@end