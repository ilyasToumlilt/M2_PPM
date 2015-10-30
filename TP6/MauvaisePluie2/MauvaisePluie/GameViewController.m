//
//  GameViewController.m
//  
//
//  Created by ilyas TOUMLILT on 26/10/2015.
//
//

#import "GameViewController.h"
#import "GameView.h"

@interface GameViewController ()<UICollisionBehaviorDelegate> {
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
    self = [super init];
    
    if(self) {
        _score = 0;
        _level = level;
    }
    
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

- (void)startNewGame
{
    [myView newGameWithLevel:_level];
    
    /* j'init le level */
    [myView.levelLabel setText:[NSString stringWithFormat:@"Niveau: %d", _level]];
    _score = 0;
    
    /* je handle les collisions */
    myView.collision.collisionDelegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showView
{
    [self.view setHidden:NO];
}

- (void)hideView
{
    [self.view setHidden:YES];
}

- (void)onClickLeftButton:(id)sender
{
    [myView.myMinionView moveLeft];
    [myView.animator updateItemUsingCurrentState:myView.myMinionView];
    [self updateMinionsCollisionBoundaries];
}

- (void)onClickRightButton:(id)sender
{
    [myView.myMinionView moveRight];
    [myView.animator updateItemUsingCurrentState:myView.myMinionView];
    [self updateMinionsCollisionBoundaries];
}

- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item
   withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p {
    NSString* tmp = [NSString stringWithFormat:@"%@", identifier];
    if( [tmp isEqualToString:@"myMinionView"]) {
        [self endOfGame];
    }
    else if ( [tmp isEqualToString:@"gravityLimit"]) {
        [myView removeAsteroid:(AsteroidView*)item];
        [myView.scoreLabel setText:[NSString stringWithFormat:@"Score: %d", ++_score]];
    }
}

- (void)updateMinionsCollisionBoundaries
{
    [myView.collision removeBoundaryWithIdentifier:@"myMinionView"];
    CGPoint rightEdge = CGPointMake(myView.myMinionView.frame.origin.x + myView.myMinionView.frame.size.width, myView.myMinionView.frame.origin.y);
    [myView.collision addBoundaryWithIdentifier:@"myMinionView"
                                fromPoint:myView.myMinionView.frame.origin
                                  toPoint:rightEdge];
}

- (void)endOfGame
{
    [myView.gameContainer removeFromSuperview];
    myView.gameContainer = nil;
    /* je notifie le chef */
    [_delegate retain];
    if([_delegate respondsToSelector:@selector(gameEndedWithScore:)]){
        [_delegate gameEndedWithScore:_score];
    }
    [_delegate release];
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
