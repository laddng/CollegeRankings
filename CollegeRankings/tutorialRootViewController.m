//
//  tutorialRootViewController.m
//  CollegeRankings
//
//  Created by Nick Ladd on 1/29/15.
//  Copyright (c) 2015 Nick Ladd. All rights reserved.
//

#import "tutorialRootViewController.h"
#import "tutorialEndViewController.h"

@interface tutorialRootViewController ()

@end

@implementation tutorialRootViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    [self populateTutorialContent];
    
}

- (void) populateTutorialContent
{
    
    self.pageImages = @[@"first tutorial screen", @"tutorialIphone", @"tutorialIphone", @"tutorialIphone", @"tutorialIphone", @"tutorialIphone", @"end of tutorial"];
    
    self.pageTitles = @[@"First tutorial screen", @"With 100 points, distribute them among each of the 11 questions in the survey.", @"Discover the list of universities that best suit you.", @"Find out details on each university.", @"Filter your search results.",@"End of tutorial"];
    
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    
    self.pageViewController.dataSource = self;
    
    UIViewController *startingViewController = [self viewControllerAtIndex:0];
    
    NSArray *viewControllers = @[startingViewController];
    
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 45);
    
    [self addChildViewController:_pageViewController];
    
    [self.view addSubview:_pageViewController.view];
    
    [self.pageViewController didMoveToParentViewController:self];
    
}

- (UIViewController *) pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    
    NSInteger index = ((tutorialContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound))
    {
        return nil;
    }
    
    index--;
    
    return [self viewControllerAtIndex:index];
    
}

- (UIViewController *) pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    
    NSUInteger index = ((tutorialContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound)
    {
        
        return nil;
        
    }
    
    index++;
    
    if (index == [self.pageTitles count])
    {
        
        return nil;
        
    }
    
    return [self viewControllerAtIndex:index];
    
}

- (UIViewController *) viewControllerAtIndex:(NSUInteger)index
{
    
    if (([self.pageTitles count] == 0) || (index >= [self.pageTitles count]))
    {
        
        return nil;
        
    }
    
    if (index == 0)
    {
        
        tutorialEndViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"tutorialStartViewController"];
        
        pageContentViewController.pageIndex = index;
        
        return pageContentViewController;
        
    }
    
    else if (index == [self.pageTitles count]-1)
    {
        
        tutorialEndViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"tutorialEndViewController"];
        
        pageContentViewController.pageIndex = index;
        
        return pageContentViewController;
        
    }
    
    else
    {
        tutorialContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"tutorialContentViewController"];
        
        pageContentViewController.pageImageFileName = self.pageImages[index];
        
        pageContentViewController.pageStatement = self.pageTitles[index];
        
        pageContentViewController.pageIndex = index;
        
        return pageContentViewController;
    }
    
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    
    return [self.pageTitles count];
    
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    
    return 0;
    
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