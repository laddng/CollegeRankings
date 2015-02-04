//
//  tutorialEndViewController.m
//  CollegeRankings
//
//  Created by Nick Ladd on 1/30/15.
//  Copyright (c) 2015 Nick Ladd. All rights reserved.
//

#import "tutorialEndViewController.h"

@interface tutorialEndViewController ()

@end

@implementation tutorialEndViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) completedTutorial
{
    
    NSString* pathToAgreementFile = [[NSBundle mainBundle] pathForResource:@"userAgreement" ofType:@"txt"];
    
    NSData *userAgreementData = [NSData dataWithContentsOfFile:pathToAgreementFile];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:@"completedTutorial"];
    
    [[NSFileManager defaultManager] createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, @"completedTutorial"];
    
    [userAgreementData writeToFile:filePath atomically:YES];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"completedTutorial"])
    {
        
        [self completedTutorial];
        
    }
    
}

@end
