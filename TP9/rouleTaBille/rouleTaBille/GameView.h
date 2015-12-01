//
//  GameView.h
//  rouleTaBille
//
//  Created by m2sar on 30/11/2015.
//  Copyright (c) 2015 Ilyas Toumlilt - Adrien Ferreira. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameView : UIView

@property (nonatomic, retain) UIView* billeView;

@property (nonatomic, retain) UIDynamicAnimator* animator;
@property (nonatomic, retain) UIGravityBehavior* gravity;
@property (nonatomic, retain) UICollisionBehavior* collision;

- (void)newGame;

@end
