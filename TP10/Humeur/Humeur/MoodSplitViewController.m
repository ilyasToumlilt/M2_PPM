//
//  HumeurSplitViewController.m
//  Humeur
//
//  Created by m2sar on 07/12/2015.
//  Copyright (c) 2015 m2sar. All rights reserved.
//

#import "MoodSplitViewController.h"

@implementation MoodSplitViewController
- (instancetype)init
{
    self = [super init];

    if( self ){
        
        self.masterVC = [[PairesTableViewController alloc] init];
        self.masterVC.splitVC = self;

        self.detailsVC = [[MoodViewController alloc] init];
        self.detailsVC.splitVC = self;

        [self.detailsVC setDelegate:self.masterVC];
        
        [self displayModeButtonItem];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    }

    return self;
}


-(void)deviceOrientationDidChange:(NSNotification *)notification{

    [self.masterVC setElementsSize:self.view.frame.size];
}

@end
