//
//  MAMasterViewController.h
//  MesActivites
//
//  Created by m2sar on 23/11/2015.
//  Copyright (c) 2015 ilyas TOUMLILT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MAMasterViewController : UIViewController<UISplitViewControllerDelegate>

@property (readwrite, nonatomic, retain) MASplitViewController *splitVC;

@end
