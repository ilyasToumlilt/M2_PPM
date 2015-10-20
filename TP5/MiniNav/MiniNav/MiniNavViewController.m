//
//  ViewController.m
//  MiniNav
//
//  Created by ilyas TOUMLILT on 20/10/2015.
//  Copyright (c) 2015 ilyas TOUMLILT. All rights reserved.
//

#import "MiniNavViewController.h"
#import "MiniNavView.h"

@interface MiniNavViewController () {
    MiniNavView* mnv;
}

@end

@implementation MiniNavViewController

NSString* homeUrl = @"http://www.lip6.fr";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    mnv = [[MiniNavView alloc] initWithFrame:self.view.frame];
    mnv.delegate = self;
    [self.view addSubview:mnv]; [mnv release];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [mnv drawSubviews:size];
}

- (void)loadPageFromUrl:(NSString*)targetUrl
{
    [mnv.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:targetUrl]]];
}

/**** I am a MiniNavViewDelegate :) ****/
- (void)loadHomeAction {
    [self loadPageFromUrl:homeUrl];
}

- (void)prevPageAction {
    if([mnv.myWebView canGoBack]){
        [mnv.myWebView goBack];
    }
}

- (void)changeHomePageAction:(NSString*)newUrl {
    homeUrl = newUrl;
}

- (void)nextPageAction {
    if ([mnv.myWebView canGoForward]) {
        [mnv.myWebView goForward];
    }
}

- (void)goToUrlAction:(NSString*)targetUrl {
    [self loadPageFromUrl:targetUrl];
}

@end
