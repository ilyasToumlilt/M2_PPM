//
//  ViewController.h
//  rouleTaBille
//
//  Created by m2sar on 30/11/2015.
//  Copyright (c) 2015 Ilyas Toumlilt - Adrien Ferreira. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MainView.h"
#import "GameViewController.h"
#import "StartGameAlertView.h"

@interface ViewController : UIViewController<StartGameAlertViewDelegate>

@property (nonatomic, retain) MainView* myView;
@property (nonatomic, retain) GameViewController* myGameVC;
@property (nonatomic, retain) StartGameAlertView* startGameAlertV;

@end

