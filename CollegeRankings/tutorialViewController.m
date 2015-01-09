//
//  tutorialViewController.m
//  CollegeRankings
//
//  Created by Nick Ladd on 11/22/14.
//  Copyright (c) 2014 Nick Ladd. All rights reserved.
//

#import "tutorialViewController.h"

@interface tutorialViewController ()

@end

@implementation tutorialViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    
}

- (IBAction) questionViewDidUnwind:(UIStoryboardSegue *)segue
{
    
}

- (IBAction) userAgreementDidUnwind:(UIStoryboardSegue *)segue
{
    
}

- (void) completedTutorial
{
    
    NSString* pathToAgreementFile = [[NSBundle mainBundle] pathForResource:@"userAgreement" ofType:@"txt"];
    
    NSData *userAgreementData = [NSData dataWithContentsOfFile:pathToAgreementFile];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:@"tutorialCompletion"];
    
    [[NSFileManager defaultManager] createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, @"tutorialCompletion"];
    
    [userAgreementData writeToFile:filePath atomically:YES];
    
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if([[segue identifier] isEqualToString:@"questionsVC"])
    {
        
        [self completedTutorial];
        
    }
    
}

@end