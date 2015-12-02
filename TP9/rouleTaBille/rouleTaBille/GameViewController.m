//
//  GameViewController.m
//  rouleTaBille
//
//  Created by m2sar on 30/11/2015.
//  Copyright (c) 2015 Ilyas Toumlilt - Adrien Ferreira. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()<NSLocking> {
    NSLock* myLock;
}

@property (atomic, assign) BOOL upLock;


@end

@implementation GameViewController

/*************************************************************************************
 * Setup
 ************************************************************************************/
- (instancetype)init
{
    self = [super init];
    
    if(self){
        _upLock = NO;
        myLock = [[NSLock alloc] init];
    }
    
    return self;
}

/*************************************************************************************
 * View's Setup
 ************************************************************************************/
#define DEFAULT_TIME 60 /* en secondes */
#define DEFAULT_SCORE 0

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /* mainView */
    _myView = [[GameView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    /* GameTimerView */
    _myTimerView = [[GameTimerView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 50,
                                                                   20,
                                                                   100,
                                                                   50)
                                                andTime:DEFAULT_TIME];
    _myTimerView.delegate = self;
    
    /* GameScoreView */
    _myScoreView = [[GameScoreView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 70,
                                                                   20,
                                                                   60,
                                                                   30)
                                               andScore:DEFAULT_SCORE];
    
    /* motionManager */
    _motionManager = [[CMMotionManager alloc] init];
    _motionManager.accelerometerUpdateInterval = .05;
    [_motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData  *accelerometerData, NSError *error) {
        [self gravityUpdated:accelerometerData.acceleration];
        if(error){
            NSLog(@"%@", error);
        }
    }];
    
    /* adding my cool subviews */
    [self.view addSubview:_myView];
    [self.view addSubview:_myTimerView];
    [self.view addSubview:_myScoreView];
    
    /* releasing stuff */
    [_myView release];
    [_myTimerView release];
    [_myScoreView release];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [_motionManager stopAccelerometerUpdates];
}

/*************************************************************************************
 * Game Setup
 ************************************************************************************/
- (void)startGame
{
    _myScoreView.score = DEFAULT_SCORE;
    [_myScoreView updateScoreLabel];
    _myTimerView.remainingTime = DEFAULT_TIME;
    [_myTimerView startTimer];
    [_myView newGame];
    _myView.collision.collisionDelegate = self;
    [_myView drawNewEtoileWithId:0];
}

- (void)restartGame
{
    _myScoreView.score = DEFAULT_SCORE;
    [_myScoreView updateScoreLabel];
    _myTimerView.remainingTime = DEFAULT_TIME;
    [_myTimerView startTimer];
    [_myView restartGame];
    _myView.collision.collisionDelegate = self;
    [_myView drawNewEtoileWithId:0];
}

/*************************************************************************************
 * GameTimerViewDelegate Methods
 ************************************************************************************/
- (void)gameTimerEndNotification
{
    [_delegate retain];
    if([_delegate respondsToSelector:@selector(gameEndedWithScore:)]){
        [_myView stopGame];
        [_delegate gameEndedWithScore:_myScoreView.score];
    }
    [_delegate release];
}

/********************************************************************************************
 * UICollisionBehaviorDelegate
 *******************************************************************************************/
- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item
   withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p {
    @synchronized(myLock){
        NSString* tmp = [NSString stringWithFormat:@"%@", identifier];
        if(item == _myView.billeView ){
            if([tmp isEqualToString:@"etoileView"]){
                /* collision avec l'étoile */
                [_myScoreView incrementScore];
                [_myView drawNewEtoileWithId:_myScoreView.score];
            } else {
                /* collision avec les bordures */
                [_myView sonMur];
            }
        }
    }
}

/********************************************************************************************
 * MotionManager
 *******************************************************************************************/
- (void)gravityUpdated:(CMAcceleration)acceleration
{
    CGFloat x = (CGFloat)acceleration.x * 1.0;
    CGFloat y = (CGFloat)acceleration.y * -1.0;
    
    
    CGVector v = CGVectorMake(x, y);

    _myView.gravity.gravityDirection = v;
}

/********************************************************************************************
 * NSLock
 *******************************************************************************************/
- (void)lock
{
    [myLock lock];
}

- (void)unlock
{
    [myLock unlock];
}

/*************************************************************************************
 * Memory Setup
 ************************************************************************************/
- (void)dealloc
{
    [_motionManager release];
    [myLock release];
    
    [super dealloc];
}

@end
