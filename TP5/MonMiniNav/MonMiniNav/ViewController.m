//
//  ViewController.m
//  MonMiniNav
//
//  Created by m2sar on 17/10/2015.
//  Copyright (c) 2015 m2sar. All rights reserved.
//

#import "ViewController.h"
#import "MiniNavView.h"


@interface ViewController(){
    MiniNavView* mnv;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self->mnv =[[MiniNavView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self->mnv];
    /* TODO : release view */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [self->mnv setElementSize:size];
}


@end
