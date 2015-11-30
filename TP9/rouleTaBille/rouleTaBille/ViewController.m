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
 * View's methods
 ************************************************************************************/
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /* mainView */
    _myView = [[MainView alloc] initWithFrame:self.view.frame];
    
    /* adding my cool subviews */
    [self.view addSubview:_myView];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*************************************************************************************
 * Responder
 ************************************************************************************/
#pragma mark - Shake methods
- (BOOL)canBecomeFirstResponder
{
    return YES;
}

-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake )
    {
        [_myView displayNextBackgroundImage];
    }
}


- (void)dealloc
{
    
    [super dealloc];
}

@end
