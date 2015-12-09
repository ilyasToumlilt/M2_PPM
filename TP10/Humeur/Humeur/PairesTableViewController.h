//
//  PairesTableView.h
//  Humeur
//
//  Created by m2sar on 05/12/2015.
//  Copyright (c) 2015 m2sar. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Constants.h"
#import "MoodViewController.h"



@class MoodSplitViewController;

@interface PairesTableViewController : UIViewController<NSNetServiceDelegate,
                                                        NSNetServiceBrowserDelegate,
                                                        UITableViewDataSource,
                                                        UITableViewDelegate,
                                                        UISplitViewControllerDelegate,
                                                        MoodViewControllerDelegate
                                                        >
@property (retain) UITableView*utbv;
@property (retain) MoodSplitViewController *splitVC;
-(void)setElementsSize:(CGSize)size;
@end


