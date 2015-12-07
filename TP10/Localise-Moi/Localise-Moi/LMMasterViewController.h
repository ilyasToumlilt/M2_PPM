//
//  LMMasterViewController.h
//  Localise-Moi
//
//  Created by m2sar on 07/12/2015.
//  Copyright (c) 2015 Ilyas Toumlilt - Adrien Ferreira. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LMDetailsViewController.h"

@class LMSplitViewController;

@interface LMMasterViewController : UIViewController<UISplitViewControllerDelegate, UITabBarControllerDelegate>

@property (readwrite, nonatomic, retain) LMSplitViewController* splitVC;
@property (retain, nonatomic) LMDetailsViewController* detailsVC;


@end
