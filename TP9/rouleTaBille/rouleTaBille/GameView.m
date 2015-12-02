//
//  GameView.m
//  rouleTaBille
//
//  Created by m2sar on 30/11/2015.
//  Copyright (c) 2015 Ilyas Toumlilt - Adrien Ferreira. All rights reserved.
//

#import "GameView.h"

@interface GameView ()

@end

@implementation GameView

#define BILLE_SIZE 60

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if( self ){
        
    }
    
    return self;
}

- (void)newGame
{
    /* releasing old stuff */
    [_billeView removeFromSuperview];
    _billeView = nil;
    [_animator release];
    _animator = nil;
    [_gravity release];
    _gravity = nil;
    [_collision release];
    _collision = nil;
    
    /* billeView */
    _billeView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width/2 - (BILLE_SIZE/2),
                                                          self.frame.size.height/2 - (BILLE_SIZE/2),
                                                          BILLE_SIZE,
                                                          BILLE_SIZE)];
    _billeView.backgroundColor = [UIColor grayColor];
    
    /* adding my cool subviews */
    [self addSubview:_billeView];
    
    /* dynamicBehavior */
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
    
    /* gravity */
    _gravity = [[UIGravityBehavior alloc] initWithItems:@[_billeView]];
    [_animator addBehavior:_gravity];
    
    /* collision */
    _collision = [[UICollisionBehavior alloc] initWithItems:@[_billeView]];
    _collision.translatesReferenceBoundsIntoBoundary = YES;
    [_animator addBehavior:_collision];
    
    /* releasing stuff */
    [_billeView release];
}

- (void)dealloc
{
    [_gravity release];
    [_collision release];
    [_animator release];
    
    [super dealloc];
}


@end
