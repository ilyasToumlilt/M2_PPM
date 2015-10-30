//
//  GameView.h
//  
//
//  Created by ilyas TOUMLILT on 26/10/2015.
//
//

#import <UIKit/UIKit.h>

#import "MinionView.h"
#import "AsteroidView.h"

@interface GameView : UIView

@property (retain, nonatomic) UILabel* levelLabel;
@property (retain, nonatomic) UILabel* scoreLabel;

@property (retain, nonatomic) UIButton* leftButton;
@property (retain, nonatomic) UIButton* rightButton;

@property (assign, nonatomic) MinionView* myMinionView;


@property (assign, nonatomic) UIView* gameContainer;
@property (assign, nonatomic) UIDynamicAnimator* animator;
@property (assign, nonatomic) UICollisionBehavior* collision;
@property (assign, nonatomic) UIGravityBehavior* gravity;
@property (assign, nonatomic) UIDynamicItemBehavior *animationOptions;


- (void)removeAsteroid:(AsteroidView*)aster;
- (void)newGameWithLevel:(int)level;

@end
