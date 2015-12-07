//
//  LMSplitViewController.h
//  Localise-Moi
//
//  Created by m2sar on 07/12/2015.
//  Copyright (c) 2015 Ilyas Toumlilt - Adrien Ferreira. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LMMasterViewController.h"
#import "LMDetailsViewController.h"

@interface LMSplitViewController : UISplitViewController

@property (nonatomic, retain) LMMasterViewController*  masterVC;
@property (nonatomic, retain) LMDetailsViewController* detailsVC;

@end
