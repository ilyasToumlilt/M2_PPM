//
//  ViewController.h
//  MesActivites
//
//  Created by ilyas TOUMLILT on 22/11/2015.
//  Copyright (c) 2015 ilyas TOUMLILT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UISplitViewControllerDelegate>

@property (retain, nonatomic) UITableView* tasksTableView;
@property (retain, nonatomic) UIViewController* detailsVC;
@property (retain, nonatomic) NSMutableArray *tasksData;

@end

