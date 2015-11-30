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
    
    /* adding my cool subviews */
    [self.view addSubview:_myView];
    [self.view addSubview:_myGameVC.view];
    
    /* releasing stuff */
    [_myView release];
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
