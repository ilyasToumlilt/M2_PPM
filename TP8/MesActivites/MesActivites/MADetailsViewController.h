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
@class MaTask;

@protocol MADetailsViewControllerDelegate;

@interface MADetailsViewController : UIViewController

@property (nonatomic, assign) id<MADetailsViewControllerDelegate> delegate;

@property (readwrite, nonatomic, retain) MASplitViewController *splitVC;

- (void)updateDetailsViewWithTask:(MaTask*)task;

@end

@protocol MADetailsViewControllerDelegate <NSObject>

- (void)didUpdateDetails;

@end

#endif