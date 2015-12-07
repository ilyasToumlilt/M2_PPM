//
//  LMDetailsViewController.h
//  Localise-Moi
//
//  Created by m2sar on 07/12/2015.
//  Copyright (c) 2015 Ilyas Toumlilt - Adrien Ferreira. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LMMapView.h"

@class LMSplitViewController;

@interface LMDetailsViewController : UIViewController

@property (readwrite, nonatomic, retain) LMSplitViewController* splitVC;
@property (nonatomic, retain) LMMapView* myLMMapView;

@end
