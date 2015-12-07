//
//  HumeurSplitViewController.h
//  Humeur
//
//  Created by m2sar on 07/12/2015.
//  Copyright (c) 2015 m2sar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PairesTableViewController.h"
#import "MoodViewController.h"


@class PairesTableViewController;
@class MoodViewController;

@interface MoodSplitViewController : UISplitViewController<UISplitViewControllerDelegate>
@property (readwrite, nonatomic, retain) PairesTableViewController*  masterVC;
@property (readwrite, nonatomic, retain) MoodViewController* detailsVC;
@end
