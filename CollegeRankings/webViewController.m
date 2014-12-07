//
//  webViewController.m
//  CollegeRankings
//
//  Created by Nick Ladd on 10/18/14.
//  Copyright (c) 2014 Nick Ladd. All rights reserved.
//

#import "webViewController.h"

@interface webViewController ()

@end

@implementation webViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    _web.delegate = self;
    
    [self loadWebpage];
    
}



- (void) loadWebpage
{
    
    NSURL *url_path = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://%@",_url]];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url_path];
    
    [_web loadRequest:request];
    
    
}

- (void) webViewDidStartLoad:(UIWebView *)webView
{
    
    _activityIndicator.hidden = FALSE;
    
    [_activityIndicator startAnimating];
    
}

- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    
    _activityIndicator.hidden = TRUE;
    
    [_activityIndicator stopAnimating];
    
}

@end