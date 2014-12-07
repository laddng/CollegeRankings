//
//  detailViewController.m
//  CollegeRankings
//
//  Created by Nick Ladd on 10/18/14.
//  Copyright (c) 2014 Nick Ladd. All rights reserved.
//

#import "detailViewController.h"
#import "webViewController.h"
#import "collegeObject.h"

@interface detailViewController ()

@end

@implementation detailViewController

- (void)viewDidLoad
{

    [super viewDidLoad];
    
    [self loadInfo];
    
}

-(void) loadInfo
{
    
    _uniName.text = _collegeInfo.name;
    
    _uniTown.text = [NSString stringWithFormat:@"%@, %@", _collegeInfo.city, _collegeInfo.collegeState];
    
    _uniType.text = [NSString stringWithFormat:@"%@ University", _collegeInfo.collegeType];
    
    
    
    [_uniURL setTitle:_collegeInfo.url forState:UIControlStateNormal];
    
    if([_collegeInfo.ins intValue] == 0 && [_collegeInfo.out intValue] == 0)
    {
        
        _uniIn.hidden = YES;
        
        _uniInLabel.hidden = YES;
        
        _uniOut.hidden = YES;
        
        _uniOutLabel.hidden = YES;
        
    }

    else
    {
        
        NSNumberFormatter *format = [NSNumberFormatter new];
        
        [format setNumberStyle:NSNumberFormatterDecimalStyle];
        
        NSString *formatted = [format stringFromNumber:[NSNumber numberWithInteger:[_collegeInfo.ins intValue]]];
        
        _uniIn.text = [NSString stringWithFormat:@"$%@",formatted];
        
        formatted = [format stringFromNumber:[NSNumber numberWithInteger:[_collegeInfo.out intValue]]];
        
        _uniOut.text = [NSString stringWithFormat:@"$%@",formatted];
        
    }
    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if([[segue identifier] isEqualToString:@"webVC"])
    {
        
        webViewController *view = [segue destinationViewController];
        
        view.url = _collegeInfo.url;
        
    }
    
}

@end