//
//  GameView.h
//  rouleTaBille
//
//  Created by m2sar on 30/11/2015.
//  Copyright (c) 2015 Ilyas Toumlilt - Adrien Ferreira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVAudioPlayer.h>

@interface GameView : UIView<AVAudioPlayerDelegate>

@property (nonatomic, retain) UIView* billeView;
@property (nonatomic, retain) UIView* etoileView;

@property (nonatomic, retain) UIDynamicAnimator* animator;
@property (nonatomic, retain) UIGravityBehavior* gravity;
@property (nonatomic, retain) UICollisionBehavior* collision;
@property (nonatomic, retain) UIDynamicItemBehavior* itemBehaviour;

@property (nonatomic, retain) AVAudioPlayer* myPlayer;
@property (nonatomic, retain) AVAudioPlayer* myEtoilePlayer;
@property (nonatomic, retain) AVAudioPlayer* mySonPlayer;
@property (nonatomic, retain) AVAudioPlayer* mySqueezePlayer;

- (void)newGame;
- (void)stopGame;
- (void)restartGame;
- (void)sonMur;
- (void)drawNewEtoileWithId:(int)identifier;

@end
