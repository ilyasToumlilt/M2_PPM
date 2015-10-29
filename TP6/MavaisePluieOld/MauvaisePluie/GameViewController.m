//
//  GameViewController.m
//  
//
//  Created by ilyas TOUMLILT on 26/10/2015.
//
//

#import "GameViewController.h"
#import "GameView.h"

@interface GameViewController () {
    GameView* myView;
}

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupView];
}

- (GameViewController*)initWithLevel:(int)level
{
    _score = 0;
    _level = level;
    
    return [self init];
}

- (void)setupView {
    myView = [[GameView alloc] initWithFrame:self.view.frame];
    
    /* je m'occupe des boutons de la vue */
    [myView.leftButton addTarget:self
                          action:@selector(onClickLeftButton:)
                forControlEvents:UIControlEventTouchDown];
    [myView.rightButton addTarget:self
                           action:@selector(onClickRightButton:)
                 forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:myView]; [myView release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showView
{
    [myView setHidden:false];
    [myView.scoreLabel setHidden:false];
}

- (void)hideView
{
    [myView setHidden:true];
}

- (void)onClickLeftButton:(id)sender
{
    [myView.myMinionView moveLeft];
}

- (void)onClickRightButton:(id)sender
{
    [myView.myMinionView moveRight];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
