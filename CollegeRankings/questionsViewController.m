//
//  questionsViewController.m
//  CollegeRankings
//
//  Created by Nick Ladd on 10/18/14.
//  Copyright (c) 2014 Nick Ladd. All rights reserved.
//

#import "questionsViewController.h"
#import "questionTableViewCell.h"
#import "resultsTableViewController.h"
#import "questionsXMLParser.h"
#import "infoXMLParser.h"

@interface questionsViewController ()

@property NSArray *surveyQuestions;

@property NSArray *surveyInfo;

@property NSMutableArray *surveyInput;

@property float valueRemaining;

@end

@implementation questionsViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    [_tableView setDelegate:self];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self loadSurveyQuestions];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    _surveyInput = [[NSMutableArray alloc] init];
    
    [_surveyInput addObjectsFromArray:@[@"-1",@"-1",@"-1",@"-1",@"-1",@"-1",@"-1",@"-1",@"-1",@"-1",@"-1"]];
    
    _valueRemaining = 100.0;
    
    _progressMeter.progress = (100.0-_valueRemaining);
    
    _progressText.text = [NSString stringWithFormat:@"You have %i points left.", (int) _valueRemaining];
    
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

- (void) dismissKeyboard
{
    
    [self.view endEditing:YES];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    questionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"question" forIndexPath:indexPath];
    
    cell.surveyQuestion.text = [self.surveyQuestions objectAtIndex:indexPath.row];
    
    if([[self.surveyInput objectAtIndex:indexPath.row] isEqualToString:@"-1"])
    {
        
        cell.surveyInput.text = @"";
        
    }
    
    else
    {
        
        cell.surveyInput.text = [self.surveyInput objectAtIndex:indexPath.row];
        
    }
    
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

-(IBAction)textFieldReturn:(id) sender
{
    
    [self resignFirstResponder];
    
}

- (IBAction) recordInputValueEntered:(id)sender
{
    
    CGPoint pointOfTextField = [sender convertPoint:CGPointZero toView:self.tableView];
    
    NSIndexPath *indexOfTextField = [self.tableView indexPathForRowAtPoint:pointOfTextField];
    
    questionTableViewCell *cellToRecord = (questionTableViewCell*)[self.tableView cellForRowAtIndexPath:indexOfTextField];
    
    NSString *inputValue = cellToRecord.surveyInput.text;
    
    int value = [inputValue intValue];
    
    if(![inputValue isEqual: nil])
    {
        
        if (value < 0)
        {
            
            [self.tableView reloadRowsAtIndexPaths:@[indexOfTextField] withRowAnimation:UITableViewRowAnimationNone];
            
            UIAlertView *negAlert = [[UIAlertView alloc] initWithTitle:@"No Negative Points" message:@"Negative points are not allowed. Try again." delegate:nil cancelButtonTitle:@"Continue" otherButtonTitles:nil, nil];
            
            [negAlert show];
            
            [self.tableView reloadData];
            
        }
        
        else
        {
            
            _valueRemaining = 100.0;
            
            for (int i = 0; i < [self.surveyInput count]; i++) {
                
                if (i != indexOfTextField.row && ![[self.surveyInput objectAtIndex:i] isEqualToString:@"-1"])
                {
                    
                    _valueRemaining = _valueRemaining - [[self.surveyInput objectAtIndex:i] intValue];
                    
                }
                
            }
            
            if ((_valueRemaining - value) >= 0)
            {
                
                [self.surveyInput replaceObjectAtIndex:indexOfTextField.row withObject:[inputValue copy]];
                
                _valueRemaining = 100.0;
                
                for (int i = 0; i < [self.surveyInput count]; i++)
                {
                    
                    if (![[self.surveyInput objectAtIndex:i] isEqualToString:@"-1"])
                    {
                        
                        _valueRemaining = _valueRemaining - [[self.surveyInput objectAtIndex:i] intValue];
                        
                    }
                    
                }
                
                _progressText.text = [NSString stringWithFormat:@"You have %d points left.", (int) _valueRemaining];
                
                _progressMeter.progress = ((100-_valueRemaining)/100);
                
                _clearButton.hidden = NO;
                
                
            }
            
            else {
                
                UIAlertView *negAlert = [[UIAlertView alloc] initWithTitle:@"Limit Reached" message:@"You can only use a total of 100 points." delegate:nil cancelButtonTitle:@"Continue" otherButtonTitles:nil, nil];
                
                [negAlert show];
                
                [self.tableView reloadData];
                
            }
        }
    }
}

- (IBAction)clearValues
{
    
    [_surveyInput removeAllObjects];
    
    [_surveyInput addObjectsFromArray: @[@"-1",@"-1",@"-1",@"-1",@"-1",@"-1",@"-1",@"-1",@"-1",@"-1",@"-1"]];
    
    _valueRemaining = 100.0;
    
    _progressText.text = [NSString stringWithFormat:@"You have %d points left.", (int) _valueRemaining];
    
    _progressMeter.progress = ((100-_valueRemaining)/100);
    
    _clearButton.hidden = YES;
    
    [_tableView reloadData];
    
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    
    if ([identifier isEqualToString:@"showResults"])
    {
        
        if(_valueRemaining == 0)
        {
            
            return YES;
            
        }
        
        else
        {
            
            UIAlertView *stillPointsLeftPopup = [[UIAlertView alloc] initWithTitle:@"More Points" message:[NSString stringWithFormat:@"You still have %d points remaining. Please use all 100 points.", (int) _valueRemaining] delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [stillPointsLeftPopup show];
            
            return NO;
            
        }
        
    }
    
    else
    {
        
        return YES;
        
    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if([[segue identifier] isEqualToString:@"showResults"])
    {
                
        resultsTableViewController *resultsViewControllerSegue = segue.destinationViewController;
        
        NSArray *input_send = [[NSArray alloc] initWithArray:self.surveyInput];

        resultsViewControllerSegue.surveyInput = [input_send copy];
        
    }
    
}

-(IBAction) viewDidUnwind:(UIStoryboardSegue *) segue {}

@end