//
//  GameView.m
//  rouleTaBille
//
//  Created by m2sar on 30/11/2015.
//  Copyright (c) 2015 Ilyas Toumlilt - Adrien Ferreira. All rights reserved.
//

#import "GameView.h"

@interface GameView () {
    int collisionCounter;
    BOOL xLock;
}

@end

@implementation GameView

#define BILLE_SIZE 60

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if( self ){
        xLock = YES;
    }
    
    return self;
}

- (void)newGame
{
    collisionCounter = 0;
    
    self.hidden = NO;
    
    /* billeView */
    _billeView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width/2 - (BILLE_SIZE/2),
                                                          self.frame.size.height/2 - (BILLE_SIZE/2),
                                                          BILLE_SIZE,
                                                          BILLE_SIZE)];
    /*  imageBackground de billeView */
    UIImage* img = [UIImage imageNamed:@"bille"];
    UIGraphicsBeginImageContextWithOptions(_billeView.frame.size, NO, 0.0);
    [img drawInRect:CGRectMake(0, 0, _billeView.frame.size.width, _billeView.frame.size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    _billeView.backgroundColor = [UIColor colorWithPatternImage:newImage];
    
    /* l'étoile de met */
    _etoileView = [[UIView alloc] initWithFrame:CGRectMake(-BILLE_SIZE,
                                                           -BILLE_SIZE,
                                                           BILLE_SIZE,
                                                           BILLE_SIZE)];
    /*  imageBackground de billeView */
    UIImage* img2 = [UIImage imageNamed:@"etoile-96"];
    UIGraphicsBeginImageContextWithOptions(_etoileView.frame.size, NO, 0.0);
    [img2 drawInRect:CGRectMake(0, 0, _etoileView.frame.size.width, _etoileView.frame.size.height)];
    UIImage *newImage2 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    _etoileView.backgroundColor = [UIColor colorWithPatternImage:newImage2];
    
    /* adding my cool subviews */
    [self addSubview:_billeView];
    [self addSubview:_etoileView];
    
    /* dynamicBehavior */
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
    
    /* I hate physics */
    _itemBehaviour = [[UIDynamicItemBehavior alloc] initWithItems:@[_billeView, _etoileView]];
    //_itemBehaviour.density = 1.0;
    //_itemBehaviour.resistance = 1.0;
    //_itemBehaviour.angularResistance = 0.0;
    [_animator addBehavior:_itemBehaviour];

    
    /* gravity */
    _gravity = [[UIGravityBehavior alloc] initWithItems:@[_billeView]];
    [_animator addBehavior:_gravity];
    
    /* collision */
    _collision = [[UICollisionBehavior alloc] initWithItems:@[_billeView, _etoileView]];
    _collision.translatesReferenceBoundsIntoBoundary = YES;
    //[_collision setCollisionMode:UICollisionBehaviorModeBoundaries];
    [_animator addBehavior:_collision];
    
    /* audio */
    _myPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"midnight-ride-01a" ofType:@".mp3"]] error:nil];
    _myPlayer.numberOfLoops = -1;
    [_myPlayer play];
    
    /* audio Etoile */
    _myEtoilePlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"son-etoile" ofType:@".mp3"]] error:nil];
    _myEtoilePlayer.numberOfLoops = 0;
    
    /* audio Son */
    _mySonPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"son" ofType:@".mp3"]] error:nil];
    _mySonPlayer.numberOfLoops = 0;
    
    /* audio Squeeze*/
    _mySqueezePlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"squeeze-toy-1" ofType:@".mp3"]] error:nil];
    _mySqueezePlayer.numberOfLoops = 0;
    
    /* releasing stuff */
    [_billeView release];
    [_etoileView release];
}

- (void)stopGame
{
    self.hidden = YES;
    [_myEtoilePlayer play];
    [_myPlayer stop];
}

- (void)restartGame
{
    collisionCounter = 0;
    
    self.hidden = NO;
}

- (void)drawNewEtoileWithId:(int)identifier
{
    if (xLock) {
        if ( collisionCounter )
            [_collision removeAllBoundaries];
        if( identifier == collisionCounter ){
            collisionCounter++;
            _etoileView.frame = CGRectMake(arc4random()%((int)self.frame.size.width-BILLE_SIZE),
                                           arc4random()%((int)self.frame.size.height-BILLE_SIZE),
                                           BILLE_SIZE,
                                           BILLE_SIZE);
            [_animator updateItemUsingCurrentState:_etoileView];
            [_collision addBoundaryWithIdentifier:@"etoileView" forPath:[UIBezierPath bezierPathWithRoundedRect:CGRectMake(_etoileView.frame.origin.x, _etoileView.frame.origin.y , _etoileView.frame.size.width, _etoileView.frame.size.height) cornerRadius:0.0]];
            [_mySqueezePlayer play];
        }
    }
    
}

- (void)sonMur
{
    [_mySonPlayer play];
}

- (void)dealloc
{
    [_gravity release];
    [_collision release];
    [_itemBehaviour release];
    [_animator release];
    
    [super dealloc];
}


@end
