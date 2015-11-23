//
//  MAMasterViewController.h
//  MesActivites
//
//  Created by m2sar on 23/11/2015.
//  Copyright (c) 2015 ilyas TOUMLILT. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef __MA_MASTER_VC_H__
#define __MA_MASTER_VC_H__

@class MASplitViewController;

@interface MAMasterViewController : UIViewController<UITableViewDataSource, UITableViewDelegate,UISplitViewControllerDelegate>

@property (readwrite, nonatomic, retain) MASplitViewController *splitVC;

@property (retain, nonatomic) UITableView* tasksTableView;
@property (retain, nonatomic) UIViewController* detailsVC;
@property (retain, nonatomic) NSMutableArray *tasksData;

@end

#endif