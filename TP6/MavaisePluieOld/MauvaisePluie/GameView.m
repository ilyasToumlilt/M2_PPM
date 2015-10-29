//
//  GameView.m
//  
//
//  Created by ilyas TOUMLILT on 26/10/2015.
//
//

#import "GameView.h"

@interface GameView () {
    UIView* gameContainer;
}

@end

@implementation GameView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self) {
        
        [self setHidden:YES];
        
        /* levelLabel */
        _levelLabel = [[UILabel alloc] init];
        [_levelLabel setText:@"Niveau: X"];
        [_levelLabel setTextAlignment:NSTextAlignmentLeft];
        [_levelLabel setTextColor:[UIColor whiteColor]];
        
        /* scoreLabel */
        _scoreLabel = [[UILabel alloc] init];
        [_scoreLabel setText:@"Score: 0"];
        [_scoreLabel setTextAlignment:NSTextAlignmentRight];
        [_scoreLabel setTextColor:[UIColor whiteColor]];
        
        /* leftButton */
        _leftButton = [[UIButton alloc] init];
        [_leftButton setTitle:@"<<<" forState:UIControlStateNormal];
        [_leftButton.titleLabel setTextAlignment:NSTextAlignmentLeft];
        [_leftButton.titleLabel setTextColor:[UIColor whiteColor]];
        
        /* rightButton */
        _rightButton = [[UIButton alloc] init];
        [_rightButton setTitle:@">>>" forState:UIControlStateNormal];
        [_rightButton.titleLabel setTextAlignment:NSTextAlignmentRight];
        [_rightButton.titleLabel setTextColor:[UIColor whiteColor]];
        
        /* gameContainer */
        gameContainer = [[UIView alloc] init];
        
        [self drawSubviews:frame.size];
        
        _myMinionView = [[MinionView alloc] initWithMovingArea:CGRectMake(0, gameContainer. frame.size.height - 60, gameContainer.frame.size.width, 50)];
        
        /* adding and releasing subviews */
        [self addSubview:_levelLabel]; [_levelLabel  release];
        [self addSubview:_scoreLabel]; [_scoreLabel  release];
        [self addSubview:_leftButton]; [_leftButton  release];
        [self addSubview:_rightButton];[_rightButton release];
        
        //gameContainer.backgroundColor = [UIColor whiteColor];
        
        [gameContainer addSubview:_myMinionView];
        [_myMinionView release];
        [self addSubview:gameContainer];[gameContainer release];
    }
    
    return self;
}

- (void)drawSubviews:(CGSize)frame
{
    const CGFloat V_BORDERLINE = 10;
    const CGFloat H_BORDERLINE = 20;
    
    self.frame = CGRectMake(0, 0, frame.width, frame.height);
    
    /* levelLabel */
    _levelLabel.frame = CGRectMake(V_BORDERLINE, H_BORDERLINE, 100, 20);
    
    /* scoreLabel */
    _scoreLabel.frame = CGRectMake(frame.width - V_BORDERLINE - 150, H_BORDERLINE, 150, 20);
    
    /* leftButton */
    _leftButton.frame = CGRectMake(V_BORDERLINE,
                                   frame.height - H_BORDERLINE - 30, 50, 30);
    
    /* rightButton */
    _rightButton.frame = CGRectMake(frame.width - V_BORDERLINE - 50,
                                    frame.height - H_BORDERLINE - 30,
                                    50, 30);
    
    /* setting gameContainer area */
    gameContainer.frame = CGRectMake(V_BORDERLINE + _leftButton.frame.size.width,
                               0,
                               frame.width - (2*V_BORDERLINE + _leftButton.frame.size.width +
                                              _rightButton.frame.size.width),
                               frame.height);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
