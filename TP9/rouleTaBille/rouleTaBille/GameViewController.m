//
//  GameViewController.m
//  rouleTaBille
//
//  Created by m2sar on 30/11/2015.
//  Copyright (c) 2015 Ilyas Toumlilt - Adrien Ferreira. All rights reserved.
//

#import "GameViewController.h"

@implementation GameViewController

/*************************************************************************************
 * Setup
 ************************************************************************************/
- (instancetype)init
{
    self = [super init];
    
    if(self){
        /* Nothing To Do pour le moment */
    }
    
    return self;
}

/*************************************************************************************
 * View's Setup
 ************************************************************************************/
#define DEFAULT_TIME 60 /* en secondes */

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
    
    /* adding my cool subviews */
    [self.view addSubview:_myView];
    [self.view addSubview:_myTimerView];
    
    /* releasing stuff */
    [_myView release];
    [_myTimerView release];
}

/*************************************************************************************
 * GameTimerViewDelegate Methods
 ************************************************************************************/
- (void)gameTimerEndNotification
{
    NSLog(@"Game Ended");
}

/*************************************************************************************
 * Memory Setup
 ************************************************************************************/
- (void)dealloc
{
    
    [super dealloc];
}

@end
