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
    
    [self configureStandardSlider];
    
    [self setupStates];

    [self loadSelectedType];

    [self setupMaxTuition];

}

- (void) configureStandardSlider
{
    
    self.standardSlider.stepValue = 0.025;

    self.standardSlider.lowerValue = ((float)_filtersToBeApplied.setMinEnrollmentFilter/(float)_filtersToBeApplied.maxEnrollmentFilter);

    self.standardSlider.upperValue = ((float)_filtersToBeApplied.setMaxEnrollmentFilter/(float)_filtersToBeApplied.maxEnrollmentFilter);

    NSNumberFormatter *format = [NSNumberFormatter new];
    
    [format setNumberStyle:NSNumberFormatterDecimalStyle];
    
    NSString *formattedMax = [format stringFromNumber:[NSNumber numberWithInteger:_filtersToBeApplied.setMaxEnrollmentFilter]];
    
    NSString *formattedMin = [format stringFromNumber:[NSNumber numberWithInteger:_filtersToBeApplied.setMinEnrollmentFilter]];
    
    _enrollmentCounter.text = [NSString stringWithFormat:@"%@ - %@ students", formattedMin, formattedMax];

    
}

- (IBAction)changedEnrollmentValue:(id)sender
{

    _filtersToBeApplied.setMinEnrollmentFilter = self.standardSlider.lowerValue * _filtersToBeApplied.maxEnrollmentFilter;
    
    _filtersToBeApplied.setMaxEnrollmentFilter = self.standardSlider.upperValue * _filtersToBeApplied.maxEnrollmentFilter;

    NSNumberFormatter *format = [NSNumberFormatter new];
    
    [format setNumberStyle:NSNumberFormatterDecimalStyle];
    
    NSString *formattedMax = [format stringFromNumber:[NSNumber numberWithInteger:_filtersToBeApplied.setMaxEnrollmentFilter]];
    
    NSString *formattedMin = [format stringFromNumber:[NSNumber numberWithInteger:_filtersToBeApplied.setMinEnrollmentFilter]];
    
    _enrollmentCounter.text = [NSString stringWithFormat:@"%@ - %@ students", formattedMin, formattedMax];
    
}

- (void) setupStates
{
    
    _states = [[NSArray alloc] init];
    
    _states = @[@"All States", @"Alabama", @"Alaska", @"Arizona", @"Arkansas", @"California", @"Colorado", @"Connecticut", @"Delaware", @"Florida", @"Georgia", @"Hawaii", @"Idaho", @"Illinois", @"Indiana", @"Iowa", @"Kansas", @"Kentucky", @"Louisiana", @"Maine", @"Maryland", @"Massachusetts", @"Michigan", @"Minnesota", @"Mississippi", @"Missouri", @"Montana", @"Nebraska", @"Nevada", @"New Hampshire", @"New Jersey", @"New Mexico", @"New York", @"North Carolina", @"North Dakota", @"Ohio", @"Oklahoma", @"Oregon", @"Pennsylvania", @"Rhode Island", @"South Carolina", @"South Dakota", @"Tennessee", @"Texas", @"Utah", @"Vermont", @"Virginia", @"Washington", @"West Virginia", @"Wisconsin", @"Wyoming"];
    
    _stateAbbreviations = @[@"ALL", @"AL", @"AK", @"AZ", @"AR", @"CA", @"CO", @"CT", @"DE", @"FL", @"GA", @"HI", @"ID", @"IL", @"IN", @"IA", @"KS", @"KY", @"LA", @"ME", @"MD", @"MA", @"MI", @"MN", @"MS", @"MO", @"MT", @"NE", @"NV", @"NH", @"NJ", @"NM", @"NY", @"NC", @"ND", @"OH", @"OK", @"OR", @"PA", @"RI", @"SC", @"SD", @"TN", @"TX", @"UT", @"VT", @"VA", @"WA", @"WV", @"WI", @"WY"];
    
    int index = (int)[_stateAbbreviations indexOfObject:_filtersToBeApplied.filteredState];
    
    [_stateSelector selectRow:index inComponent:0 animated:YES];
    
}

- (void) loadSelectedType
{
    
    if ([_filtersToBeApplied.filteredType isEqualToString:@"ALL"])
    {
        
        _typeSelector.selectedSegmentIndex = 0;
        
    }
    
    else if ([_filtersToBeApplied.filteredType isEqualToString:@"Private"])
    {
        
        _typeSelector.selectedSegmentIndex = 1;
        
    }
    
    else if ([_filtersToBeApplied.filteredType isEqualToString:@"Public"])
    {

        _typeSelector.selectedSegmentIndex = 2;
        
    }
    
}

- (IBAction)changeType:(id)sender
{
    
    if(_typeSelector.selectedSegmentIndex == 2)
    {
        
        _filtersToBeApplied.filteredType = @"Public";
        
    }
    
    else if (_typeSelector.selectedSegmentIndex == 1)
    {
        
        _filtersToBeApplied.filteredType = @"Private";
        
    }
    
    else
    {
        
        _filtersToBeApplied.filteredType = @"ALL";
        
    }
    
}

- (void) setupMaxTuition
{
    
    if (_filtersToBeApplied.setMaxTuitionFilter < _filtersToBeApplied.maxTuitionFilter)
    {
        float value = (_filtersToBeApplied.setMaxTuitionFilter *1.0)/(_filtersToBeApplied.maxTuitionFilter*1.0);
        
        _maxTuitionSlider.value = value;
        
    }
    
    else
    {
        
        _maxTuitionSlider.value = 1;
        
    }
    
    
    NSNumberFormatter *format = [NSNumberFormatter new];
    
    [format setNumberStyle:NSNumberFormatterDecimalStyle];
    
    NSString *formatted = [format stringFromNumber:[NSNumber numberWithInteger:_filtersToBeApplied.setMaxTuitionFilter]];
    
    _maxTuitionCounter.text = [NSString stringWithFormat:@"$%@", formatted];
    
}

- (IBAction) changedValueOnMaxTuition
{
    
    _filtersToBeApplied.setMaxTuitionFilter = _filtersToBeApplied.maxTuitionFilter * _maxTuitionSlider.value;
    
    NSNumberFormatter *format = [NSNumberFormatter new];
    
    [format setNumberStyle:NSNumberFormatterDecimalStyle];
    
    NSString *formatted = [format stringFromNumber:[NSNumber numberWithInteger:_filtersToBeApplied.setMaxTuitionFilter]];
    
    _maxTuitionCounter.text = [NSString stringWithFormat:@"$%@", formatted];
    
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
    
    _filtersToBeApplied.filteredState = [_stateAbbreviations objectAtIndex:row];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if([[segue identifier] isEqualToString:@"unwindFilterVC"])
    {
        
        resultsTableViewController *path = [segue destinationViewController];
        
        path.filters = self.filtersToBeApplied;
        
    }
    
}

@end