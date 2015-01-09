//
//  AppDelegate.m
//  CollegeRankings
//
//  Created by Nick Ladd on 10/12/14.
//  Copyright (c) 2014 Nick Ladd. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    return YES;
    
}

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    NSString * destination = @"rootNavigationController";
    
    if (!self.acceptedUserAgreement)
    {
        
        destination = @"rootNavigationController";
        
    }
    
    else if (!self.completedTutorial)
    {
        
        destination = @"tutorialViewController";
        
    }
    
    else
    {
        
        destination = @"questionViewController";
        
    }
    
    UIStoryboard *storyboard = self.window.rootViewController.storyboard;
    
    UIViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:destination];
    
    self.window.rootViewController = rootViewController;
    
    [self.window makeKeyAndVisible];
    
    return YES;
    
}

- (BOOL) acceptedUserAgreement
{
    
    return [self cookieCheck:@"userAgreement"];
    
}

- (BOOL) completedTutorial
{
    
    return [self cookieCheck:@"tutorialCompletion"];
    
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

@end