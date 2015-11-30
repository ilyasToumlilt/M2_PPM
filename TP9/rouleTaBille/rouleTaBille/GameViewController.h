//
//  GameViewController.h
//  rouleTaBille
//
//  Created by m2sar on 30/11/2015.
//  Copyright (c) 2015 Ilyas Toumlilt - Adrien Ferreira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameView.h"
#import "GameTimerView.h"

@interface GameViewController : UIViewController<GameTimerViewDelegate>

@property (nonatomic, retain) GameView* myView;
@property (nonatomic, retain) GameTimerView* myTimerView;

@end
