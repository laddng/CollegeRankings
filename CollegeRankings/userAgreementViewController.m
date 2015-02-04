//
//  userAgreementViewController.m
//  CollegeRankings
//
//  Created by Nick Ladd on 11/19/14.
//  Copyright (c) 2014 Nick Ladd. All rights reserved.
//
#import "userAgreementViewController.h"

@interface userAgreementViewController ()

@end

@implementation userAgreementViewController

- (void)viewDidLoad
{

    [super viewDidLoad];

    [self loadAgreementText];

}

- (void) loadAgreementText
{
    
    NSString *pathToFile = [[NSBundle mainBundle] pathForResource:@"userAgreement" ofType:@"txt"];
    
    NSString *textFromFile = [[NSString alloc] initWithContentsOfFile:pathToFile encoding:NSUTF8StringEncoding error:nil];
    
    _agreementText.text = textFromFile;
    
    _agreementText.scrollsToTop = YES;
    
    [_agreementText setContentOffset:CGPointMake(1.0, 0.0) animated:NO];

}

- (void) acceptedAgreement
{
    
    NSString* pathToAgreementFile = [[NSBundle mainBundle] pathForResource:@"userAgreement" ofType:@"txt"];
    
    NSData *userAgreementData = [NSData dataWithContentsOfFile:pathToAgreementFile];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:@"userAgreement"];
    
    [[NSFileManager defaultManager] createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, @"userAgreement"];
    
    [userAgreementData writeToFile:filePath atomically:YES];
    
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"unwindUserAgreement"])
    {
        
        [self acceptedAgreement];

    }
    
}

- (IBAction) disagreementDidUnwind:(UIStoryboardSegue *) segue
{
    
}

- (IBAction) tutorialDidUnwind:(UIStoryboardSegue *) segue
{
    
}

@end