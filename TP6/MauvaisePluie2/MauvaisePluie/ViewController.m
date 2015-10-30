//
//  ViewController.m
//  MauvaisePluie
//
//  Created by ilyas TOUMLILT on 26/10/2015.
//  Copyright (c) 2015 ilyas TOUMLILT. All rights reserved.
//

#import "ViewController.h"
#import "MainView.h"

@interface ViewController () {
    MainView* myView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /************ MainView setup ****************/
    myView = [[MainView alloc] initWithFrame:self.view.frame];
    
    /* Je veux répondre aux buttons de la mainView */
    [myView.scoreButton addTarget:self
                           action:@selector(onClickScoreButton:)
                 forControlEvents:UIControlEventTouchDown];
    [myView.gameButton addTarget:self
                          action:@selector(onClickGameButton:)
                forControlEvents:UIControlEventTouchDown];
    [myView.prefButton addTarget:self
                          action:@selector(onClickPrefButton:)
                forControlEvents:UIControlEventTouchDown];
    
    /**************** PrefView setup ******************/
    _myPrefView = [[PrefViewController alloc] init];
    _myPrefView.delegate = self;
    [_myPrefView hideView];
    
    /************* GameView setup *****************/
    _myGameVC = [[GameViewController alloc] initWithLevel:_myPrefView.level];
    _myGameVC.delegate = self;
    [_myGameVC hideView];
    
    /************* ScoreView setup *****************/
    _myScoreView = [[ScoreViewController alloc] init];
    _myScoreView.delegate = self;
    [_myScoreView hideView];
    
    /* adding and releasing stuff */
    [self.view addSubview:myView];      [myView release];
    [self.view addSubview:_myGameVC.view];
    [self.view addSubview:_myScoreView.view];
    [self.view addSubview:_myPrefView.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onClickScoreButton:(id)sender
{
    [myView hideSubviews];
    [_myScoreView showView];
}

- (void)onClickGameButton:(id)sender
{
    /* je cache les bouttons de la mainView */
    [myView hideSubviews];
    _myGameVC.level = _myPrefView.level;
    [_myGameVC startNewGame];
    [_myGameVC showView];
}

- (void)onClickPrefButton:(id)sender
{
    /* je vire les bouttons de la mainView */
    [myView hideSubviews];
    [_myPrefView showView];
}

- (void)endedPrefAction
{
    [_myPrefView hideView];
    [myView showSubviews];
}

- (void)endScoreAction
{
    [_myScoreView hideView];
    [myView showSubviews];
}

- (void)gameEndedWithScore:(int)score
{
    [_myGameVC hideView];
    [_myScoreView addNewScore:score];
    [_myScoreView showView];
}

- (void)dealloc
{
    [_myGameVC release];
    [_myPrefView release];
    [_myScoreView release];
    
    [super dealloc];
}

@end
