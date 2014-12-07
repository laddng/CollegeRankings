//
//  filtersViewController.m
//  CollegeRankings
//
//  Created by Nick Ladd on 11/19/14.
//  Copyright (c) 2014 Nick Ladd. All rights reserved.
//

#import "filtersViewController.h"
#import "resultsTableViewController.h"

@interface filtersViewController ()

@property NSArray *states;

@property NSArray *stateAbbreviations;

@end

@implementation filtersViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _states = [[NSArray alloc] init];
    
    _states = @[@"All States", @"Alabama", @"Alaska", @"Arizona", @"Arkansas", @"California", @"Colorado", @"Connecticut", @"Delaware", @"Florida", @"Georgia", @"Hawaii", @"Idaho", @"Illinois", @"Indiana", @"Iowa", @"Kansas", @"Kentucky", @"Louisiana", @"Maine", @"Maryland", @"Massachusetts", @"Michigan", @"Minnesota", @"Mississippi", @"Missouri", @"Montana", @"Nebraska", @"Nevada", @"New Hampshire", @"New Jersey", @"New Mexico", @"New York", @"North Carolina", @"North Dakota", @"Ohio", @"Oklahoma", @"Oregon", @"Pennsylvania", @"Rhode Island", @"South Carolina", @"South Dakota", @"Tennessee", @"Texas", @"Utah", @"Vermont", @"Virginia", @"Washington", @"West Virginia", @"Wisconsin", @"Wyoming"];
    
    _stateAbbreviations = @[@"ALL", @"AL", @"AK", @"AZ", @"AR", @"CA", @"CO", @"CT", @"DE", @"FL", @"GA", @"HI", @"ID", @"IL", @"IN", @"IA", @"KS", @"KY", @"LA", @"ME", @"MD", @"MA", @"MI", @"MN", @"MS", @"MO", @"MT", @"NE", @"NV", @"NH", @"NJ", @"NM", @"NY", @"NC", @"ND", @"OH", @"OK", @"OR", @"PA", @"RI", @"SC", @"SD", @"TN", @"TX", @"UT", @"VT", @"VA", @"WA", @"WV", @"WI", @"WY"];
    
    int index = (int)[_stateAbbreviations indexOfObject:_filteredByState];
    
    [_stateSelector selectRow:index inComponent:0 animated:YES];
    
    [self loadSelectedType];

}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 1;
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
    
    return 51;
    
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    return [self.states objectAtIndex:row];
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    _filteredByState = [_stateAbbreviations objectAtIndex:row];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if([[segue identifier] isEqualToString:@"unwindFilterVC"])
    {
        
        resultsTableViewController *path = [segue destinationViewController];
        
        path.filteredState = self.filteredByState;
        
        path.filteredType = self.filteredByType;
        
    }
    
}

- (void) loadSelectedType
{
    
    if ([_filteredByType isEqualToString:@"ALL"])
    {
        
        _typeSelector.selectedSegmentIndex = 0;
        
    }
    
    else if ([_filteredByType isEqualToString:@"Private"])
    {
        
        _typeSelector.selectedSegmentIndex = 1;
        
    }
    
    else if ([_filteredByType isEqualToString:@"Public"])
    {
        
        _typeSelector.selectedSegmentIndex = 2;
        
    }
    
}

- (IBAction)changeType:(id)sender
{
    
    if(_typeSelector.selectedSegmentIndex == 2)
    {
        
        _filteredByType = @"Public";
        
    }
    
    else if (_typeSelector.selectedSegmentIndex == 1)
    {
        
        _filteredByType = @"Private";
        
    }
    
    else
    {
        
        _filteredByType = @"ALL";
        
    }
    
}

@end