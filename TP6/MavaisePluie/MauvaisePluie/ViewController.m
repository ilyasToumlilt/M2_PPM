//
//  ViewController.m
//  MauvaisePluie
//
//  Created by ilyas TOUMLILT on 26/10/2015.
//  Copyright (c) 2015 ilyas TOUMLILT. All rights reserved.
//

#import "ViewController.h"
#import "MainView.h"
#import "ScoreViewController.h"


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
    
    /************* GameView setup *****************/
    //_myGameVC = [[GameViewController alloc] initWithLevel:1];
    
    /* adding and releasing stuff */
    [self.view addSubview:myView];      [myView release];
    //[self.view addSubview:_myGameVC.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onClickScoreButton:(id)sender
{
    NSLog(@"ViewController.onClickScoreButton");
    self.myScoreVC = [[ScoreViewController alloc]init];
    [self.view addSubview:self.myScoreVC.view];
    [self.myScoreVC.view release];
    [self.myScoreVC showView];

    [self.myScoreVC addNewScore:2];
    [self.myScoreVC addNewScore:10];
    [self.myScoreVC addNewScore:3];
    [self.myScoreVC addNewScore:55];
}



- (void)onClickGameButton:(id)sender
{
    NSLog(@"onClickGameButton !!!");
    /* je cache les bouttons de la mainView */
    [myView hideSubviews];
    
    /* Je lance une nouvelle gameView s'il le faut. */
    /* TODO Ne lancer une nouvelle partie que si une ancienne
     n'existe plus, ou que le level a changé ! */
    _myGameVC = [[GameViewController alloc] initWithLevel:1];
    [self.view addSubview:_myGameVC.view];
    [_myGameVC showView];
}

- (void)onClickPrefButton:(id)sender
{
    NSLog(@"onClickPrefButton !!!");
}

- (void)dealloc
{
    [_myGameVC release];

    [super dealloc];
}

@end
