//
//  initialViewController.m
//  CollegeRankings
//
//  Created by Nick Ladd on 1/29/15.
//  Copyright (c) 2015 Nick Ladd. All rights reserved.
//
#import "initialViewController.h"
#import "questionsTableViewController.h"
#import "tutorialRootViewController.h"
#import "userAgreementViewController.h"

@interface initialViewController ()

@end

@implementation initialViewController

- (void) viewDidAppear:(BOOL)animated
{
    
    [_spinner startAnimating];
    
    [self segueToFirstViewController];

}

- (void) segueToFirstViewController
{
    
    if (!self.acceptedUserAgreement)
    {
        
        userAgreementViewController *userAgreementScreen = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"userAgreementViewController"];
        
        [self.navigationController presentViewController:userAgreementScreen animated:NO completion:nil];
        
    }
    
    else if (!self.completedTutorial)
    {
        
        tutorialRootViewController *tutorialScreen = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"tutorialViewController"];
        
        [self.navigationController presentViewController:tutorialScreen animated:NO completion:nil];
        
    }
    
    else
    {

        questionsTableViewController *questionsScreen = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"questionsViewController"];
        
        [self.navigationController presentViewController:questionsScreen animated:NO completion:nil];
        
    }

}

- (BOOL) acceptedUserAgreement
{
    
    return [self cookieCheck:@"userAgreement"];
    
}

- (BOOL) completedTutorial
{
    
    return [self cookieCheck:@"completedTutorial"];
    
}

- (BOOL) cookieCheck: (NSString*) string
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:string];
    
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, string];
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    if([fileManager fileExistsAtPath:filePath])
    {
        
        return YES;
        
    }
    
    else
    {
        
        return NO;
        
    }
    
}

- (IBAction) unwindUserAgreementViewController: (UIStoryboardSegue *) segue
{
    
}

@end