//
//  GameViewController.h
//  rouleTaBille
//
//  Created by m2sar on 30/11/2015.
//  Copyright (c) 2015 Ilyas Toumlilt - Adrien Ferreira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

#import "GameView.h"
#import "GameTimerView.h"
#import "GameScoreView.h"

@protocol GameViewControllerDelegate;

@interface GameViewController : UIViewController<GameTimerViewDelegate, UICollisionBehaviorDelegate>

@property (nonatomic, assign) id<GameViewControllerDelegate> delegate;

@property (nonatomic, retain) GameView* myView;
@property (nonatomic, retain) GameTimerView* myTimerView;
@property (nonatomic, retain) GameScoreView* myScoreView;

@property (nonatomic, retain) CMMotionManager *motionManager;

- (void)startGame;
- (void)restartGame;

@end

@protocol GameViewControllerDelegate <NSObject>

- (void)gameEndedWithScore:(int)score;

@end