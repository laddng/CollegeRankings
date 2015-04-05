//
//  detailTableViewController.m
//  CollegeRankings
//
//  Created by Niclas Ladd on 4/4/15.
//  Copyright (c) 2015 Nick Ladd. All rights reserved.
//

#import "detailTableViewController.h"
#import "webViewController.h"
#import "criteriaTableViewCell.h"

@interface detailTableViewController ()

@property NSMutableArray *criteria;

@property NSMutableArray *quantity;

@end

@implementation detailTableViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    [self loadInfo];
    
    [self loadCriteria];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [_criteria count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    criteriaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"criteria" forIndexPath:indexPath];
    
    cell.criteriaText.text = [_criteria objectAtIndex:indexPath.row];
    
    cell.amount.text = [NSString stringWithFormat:@"%@",[_quantity objectAtIndex:indexPath.row]];
    
    return cell;
    
}

-(void) loadInfo
{
    
    _uniName.text = _collegeInfo.name;
    
    _uniTown.text = [NSString stringWithFormat:@"%@, %@", _collegeInfo.city, _collegeInfo.collegeState];
    
    _uniType.text = [NSString stringWithFormat:@"%@ University", _collegeInfo.collegeType];
    
    _rankingText.text = [NSString stringWithFormat:@"This university was #%i on your list", (int)_collegeInfo.ranking];
    
    [_uniURL setTitle:_collegeInfo.url forState:UIControlStateNormal];
    
}

- (void) loadCriteria
{
    
    _criteria = [[NSMutableArray alloc] init];
    
    _quantity = [[NSMutableArray alloc] init];
    
    [_criteria addObjectsFromArray: @[@"In-state Tuition", @"Out-of-state Tuition", @"Undergraduate Enrollment", @"Full Time Enrollment", @"Part Time Enrollment"]];
    
    NSNumberFormatter *format = [NSNumberFormatter new];
    
    [format setNumberStyle:NSNumberFormatterDecimalStyle];
    
    NSString *instateTuition = [NSString stringWithFormat:@"$%@",[format stringFromNumber:[NSNumber numberWithInteger:_collegeInfo.ins]]];
    
    NSString *outstateTuition = [NSString stringWithFormat:@"$%@",[format stringFromNumber:[NSNumber numberWithInteger:_collegeInfo.out]]];
    
    NSString *undergradEnrollmentAmount = [NSString stringWithFormat:@"%@",[format stringFromNumber:[NSNumber numberWithInteger:_collegeInfo.undergradEnrollment]]];
    
    NSString *fullTimeEnrollmentAmount = [NSString stringWithFormat:@"%@",[format stringFromNumber:[NSNumber numberWithInteger:_collegeInfo.undergradFullTimeEnrollment]]];
    
    NSString *partTimeEnrollmentAmount = [NSString stringWithFormat:@"%@",[format stringFromNumber:[NSNumber numberWithInteger:_collegeInfo.undergradPartTimeEnrollment]]];
    
    if (_collegeInfo.ins == 0)
    {
        instateTuition = @"N/A";
    }
    
    if (_collegeInfo.out == 0)
    {
        outstateTuition = @"N/A";
    }
    
    if (_collegeInfo.undergradEnrollment == 0)
    {
        undergradEnrollmentAmount = @"N/A";
    }
    
    if (_collegeInfo.undergradFullTimeEnrollment == 0)
    {
        fullTimeEnrollmentAmount = @"N/A";
    }
    
    if (_collegeInfo.undergradPartTimeEnrollment == 0)
    {
        partTimeEnrollmentAmount = @"N/A";
    }

    [_quantity addObjectsFromArray: @[instateTuition, outstateTuition, undergradEnrollmentAmount, fullTimeEnrollmentAmount, partTimeEnrollmentAmount]];
    
    [self.tableView reloadData];
    
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
