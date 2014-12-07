//
//  webViewController.h
//  CollegeRankings
//
//  Created by Nick Ladd on 10/18/14.
//  Copyright (c) 2014 Nick Ladd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface webViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *web;

@property NSString *url;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end