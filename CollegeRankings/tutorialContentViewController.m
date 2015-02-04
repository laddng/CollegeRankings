//
//  tutorialContentViewController.m
//  CollegeRankings
//
//  Created by Nick Ladd on 1/29/15.
//  Copyright (c) 2015 Nick Ladd. All rights reserved.
//

#import "tutorialContentViewController.h"

@interface tutorialContentViewController ()

@end

@implementation tutorialContentViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    [self populateWithTutorialContent];

}

- (void)  populateWithTutorialContent
{
    
    self.image.image = [UIImage imageNamed:self.pageImageFileName];
    
    self.statement.text = self.pageStatement;
    
}

@end