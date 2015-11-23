//
//  MASplitViewController.h
//  MesActivites
//
//  Created by m2sar on 23/11/2015.
//  Copyright (c) 2015 ilyas TOUMLILT. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MAMasterViewController.h"
#import "MADetailsViewController.h"

@interface MASplitViewController : UISplitViewController

@property (readwrite, nonatomic, retain) MAMasterViewController*  masterVC;
@property (readwrite, nonatomic, retain) MADetailsViewController* detailsVC;

@end
