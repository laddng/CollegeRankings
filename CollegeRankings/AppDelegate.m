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
    
    UIPageControl *pageControl = [UIPageControl appearance];
    
    pageControl.pageIndicatorTintColor = [UIColor darkGrayColor];
    
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    
    return YES;

}

@end