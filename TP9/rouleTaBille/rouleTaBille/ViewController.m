//
//  ViewController.m
//  rouleTaBille
//
//  Created by m2sar on 30/11/2015.
//  Copyright (c) 2015 Ilyas Toumlilt - Adrien Ferreira. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

/*************************************************************************************
 * View's Setup
 ************************************************************************************/
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /* mainView */
    _myView = [[MainView alloc] initWithFrame:self.view.frame];
    
    /* GameVC */
    _myGameVC = [[GameViewController alloc] init];
    _myGameVC.delegate = self;
    
    /* startGameAlertView */
    _startGameAlertV = [[StartGameAlertView alloc] init];
    _startGameAlertV.delegate = self;
    
    /* endGameAlertView */
    _endGameAlertV = [[EndGameAlertView alloc] init];
    _endGameAlertV.delegate = self;
    
    /* adding my cool subviews */
    [self.view addSubview:_myView];
    [self.view addSubview:_myGameVC.view];
    [self.view addSubview:_startGameAlertV];
    [self.view addSubview:_endGameAlertV];
    
    /* releasing stuff */
    [_myView release];
    [_startGameAlertV release];
    [_endGameAlertV release];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:NO];
    
    /* rattraper les événements */
    [self becomeFirstResponder];
}

-(void)viewDidDisappear:(BOOL)animated {
    [self resignFirstResponder];
    [super viewDidDisappear:NO];
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (NSUInteger) supportedInterfaceOrientations {
    // Return a bitmask of supported orientations. If you need more,
    // use bitwise or (see the commented return).
    return UIInterfaceOrientationMaskPortrait;
    // return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown;
}

- (UIInterfaceOrientation) preferredInterfaceOrientationForPresentation {
    // Return the orientation you'd prefer - this is what it launches to. The
    // user can still rotate. You don't have to implement this method, in which
    // case it launches in the current orientation
    return UIInterfaceOrientationPortrait;
}

/*************************************************************************************
 * Responder
 ************************************************************************************/
#pragma mark - Shake methods
- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake )
    {
        [_myView displayNextBackgroundImage];
    }
}

/*************************************************************************************
 * I am a GameTimerViewDelegate :-)
 ************************************************************************************/
- (void)startGameTimerEnded
{
    [_startGameAlertV hideView];
    [_myGameVC startGame];
}

/*************************************************************************************
 * I am a GameViewControllerDelegate :-)
 ************************************************************************************/
- (void)gameEndedWithScore:(int)score
{
    [_endGameAlertV showViewWithScore:score];
}

/*************************************************************************************
 * I am a EndGameAlertViewDelegate :-)
 ************************************************************************************/
- (void)restartNewGameEvent
{
    [_myGameVC restartGame];
}

/*************************************************************************************
 * I love Memory
 ************************************************************************************/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_myGameVC release];
    
    [super dealloc];
}

@end
