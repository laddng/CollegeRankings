//
//  questionsTableViewController.m
//  CollegeRankings
//
//  Created by Niclas Ladd on 2/16/15.
//  Copyright (c) 2015 Nick Ladd. All rights reserved.
//

#import "questionsTableViewController.h"
#import "questionTableViewCell.h"
#import "resultsTableViewController.h"
#import "questionsXMLParser.h"
#import "infoXMLParser.h"

@interface questionsTableViewController ()

@property NSArray *surveyQuestions;

@property NSArray *surveyInfo;

@property NSMutableArray *surveyInput;

@property float totalValueEntered;

@end

@implementation questionsTableViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    [self loadSurveyQuestions];

    _surveyInput = [[NSMutableArray alloc] init];

    [_surveyInput addObjectsFromArray:@[@0.0,@0.0,@0.0,@0.0,@0.0,@0.0,@0.0,@0.0,@0.0,@0.0,@0.0]];

    _totalValueEntered = 0.0;

    _clearButton.hidden = YES;
    
}

-(void) loadSurveyQuestions
{
    
    NSString* pathToQuestionsFile = [[NSBundle mainBundle] pathForResource:@"questions" ofType:@"xml"];
    
    NSXMLParser *fileParser = [[NSXMLParser alloc] initWithData:[NSData dataWithContentsOfFile:pathToQuestionsFile]];
    
    questionsXMLParser *xmlParserDelegate = [[questionsXMLParser alloc] initXMLParser];
    
    [fileParser setDelegate:xmlParserDelegate];
    
    [fileParser parse];
    
    _surveyQuestions = xmlParserDelegate.questions;
    
    NSString *pathToInformationFile = [[NSBundle mainBundle] pathForResource:@"information" ofType:@"xml"];
    
    NSXMLParser *infoFileParser = [[NSXMLParser alloc] initWithData:[NSData dataWithContentsOfFile:pathToInformationFile]];
    
    infoXMLParser *infoParserDelegate = [[infoXMLParser alloc] initInfoXMLParser];
    
    [infoFileParser setDelegate:infoParserDelegate];
    
    [infoFileParser parse];
    
    _surveyInfo = infoParserDelegate.info;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [_surveyQuestions count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    questionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"question" forIndexPath:indexPath];

    cell.surveyQuestion.text = [self.surveyQuestions objectAtIndex:indexPath.row];

    [cell.sliderMeter setValue:[[self.surveyInput objectAtIndex:indexPath.row] floatValue]];

    return cell;

}

-(IBAction) moreInformationOnQuestion:(id)sender
{

    CGPoint pointOfSelectedButton = [sender convertPoint:CGPointZero toView:self.tableView];

    NSIndexPath *indexOfSelectedButton = [self.tableView indexPathForRowAtPoint:pointOfSelectedButton];

    NSString *message = [self.surveyInfo objectAtIndex:indexOfSelectedButton.row];

    UIAlertView *moreInformationPopupWindow = [[UIAlertView alloc] initWithTitle:@"More Information" message:message delegate: NULL cancelButtonTitle: @"Done" otherButtonTitles:nil, nil];

    [moreInformationPopupWindow show];

}

- (IBAction) recordInputValueEntered:(id)sender
{

    CGPoint pointOfTextField = [sender convertPoint:CGPointZero toView:self.tableView];
    
    NSIndexPath *indexOfTextField = [self.tableView indexPathForRowAtPoint:pointOfTextField];

    questionTableViewCell *cellToRecord = (questionTableViewCell*)[self.tableView cellForRowAtIndexPath:indexOfTextField];

    NSNumber *inputValue = [NSNumber numberWithFloat: cellToRecord.sliderMeter.value];

    [self.surveyInput replaceObjectAtIndex:indexOfTextField.row withObject:inputValue];

    _totalValueEntered = 0.0;

    for (int i = 0; i < [self.surveyInput count]; i++)
    {

        _totalValueEntered = _totalValueEntered + [[self.surveyInput objectAtIndex:i] floatValue];

    }

    _clearButton.hidden = NO;

}

- (IBAction)clearValues
{

    [_surveyInput removeAllObjects];

    [_surveyInput addObjectsFromArray: @[@0.0,@0.0,@0.0,@0.0,@0.0,@0.0,@0.0,@0.0,@0.0,@0.0,@0.0]];

    _totalValueEntered = 0.0;

    _clearButton.hidden = YES;

    [self.tableView reloadData];

}

- (NSMutableArray *) cleanResults
{
    
    NSMutableArray *cleanArray = [[NSMutableArray alloc] init];
    
    for (int i=0; i<[_surveyInput count]; i++)
    {
        
        float newValue = [[_surveyInput objectAtIndex:i] floatValue]/_totalValueEntered;
        
        NSNumber *inputValue = [NSNumber numberWithFloat:newValue];
        
        [cleanArray addObject:inputValue];
        
    }
    
    return cleanArray;
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if([[segue identifier] isEqualToString:@"showResults"])
    {
        
        resultsTableViewController *resultsViewControllerSegue = [segue destinationViewController];
                
        resultsViewControllerSegue.surveyInputValues = [self cleanResults];
        
    }
    
}

-(IBAction) viewDidUnwind:(UIStoryboardSegue *) segue {}

@end