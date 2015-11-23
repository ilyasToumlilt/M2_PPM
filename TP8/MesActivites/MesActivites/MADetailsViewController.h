//
//  MADetailsViewController.h
//  MesActivites
//
//  Created by m2sar on 23/11/2015.
//  Copyright (c) 2015 ilyas TOUMLILT. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef __MA_DETAILS_VC_H__
#define __MA_DETAILS_VC_H__

@class MASplitViewController;

@interface MADetailsViewController : UIViewController

@property (readwrite, nonatomic, retain) MASplitViewController *splitVC;

@end

#endif