//
//  EndGameAlertView.m
//  
//
//  Created by ilyas TOUMLILT on 01/12/2015.
//
//

#import "EndGameAlertView.h"

@interface EndGameAlertView ()

@property (nonatomic, retain) UILabel* congratsLabel;
@property (nonatomic, retain) UILabel* scoreLabel;
@property (nonatomic, retain) UIButton* restartButton;

@end

@implementation EndGameAlertView

/* view bounds */
#define V_HEIGHT 180
#define V_WIDTH  280

/*************************************************************************************
 * Setup
 ************************************************************************************/
- (instancetype)init
{
    CGRect frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2 - (V_WIDTH/2),
                              [UIScreen mainScreen].bounds.size.height/2 - (V_WIDTH/2),
                              V_WIDTH,
                              V_HEIGHT);
    self = [super initWithFrame:frame];
    
    if( self ){
        
        /* backgroundColor */
        self.backgroundColor = [UIColor grayColor];
        
        /* congratsLabel */
        _congratsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, V_WIDTH, 20)];
        _congratsLabel.textAlignment = NSTextAlignmentCenter;
        _congratsLabel.textColor = [UIColor whiteColor];
        _congratsLabel.text = [NSString stringWithFormat:@"Bravo !"];
        
        /* scoreLavel */
        _scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, V_WIDTH, 30)];
        _scoreLabel.textAlignment = NSTextAlignmentCenter;
        _scoreLabel.textColor = [UIColor whiteColor];
        _scoreLabel.font = [_scoreLabel.font fontWithSize:30];
        _scoreLabel.text = [NSString stringWithFormat:@"Score : 0"];
        
        /* restartButton */
        _restartButton = [[UIButton alloc] initWithFrame:CGRectMake(V_WIDTH/2 - 25, 100, 50, 50)];
        [_restartButton addTarget:self
                           action:@selector(restartButtonTouchedDown)
                 forControlEvents:UIControlEventTouchDown];
        
        /*  imageBackground du boutton */
        UIImage* img = [UIImage imageNamed:@"refresh"];
        UIGraphicsBeginImageContextWithOptions(_restartButton.frame.size, NO, 0.0);
        [img drawInRect:CGRectMake(0, 0, _restartButton.frame.size.width, _restartButton.frame.size.height)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        _restartButton.backgroundColor = [UIColor colorWithPatternImage:newImage];
        
        /* adding my cool subviews */
        [self addSubview:_congratsLabel];
        [self addSubview:_scoreLabel];
        [self addSubview:_restartButton];
        
        /* releasing stuff */
        [_congratsLabel release];
        [_scoreLabel release];
        [_restartButton release];
        
        /* de base la vue est hidden */
        self.hidden = YES;
    }
    
    return self;
}

/**
 * Affiche la vue
 */
- (void)showViewWithScore:(int)score
{
    _scoreLabel.text = [NSString stringWithFormat:@"Score : %d", score];
    self.hidden = NO;
}

/**
 * Handler au click sur le boutton refresh
 */
- (void)restartButtonTouchedDown
{
    self.hidden = YES;
    [_delegate retain];
    if([_delegate respondsToSelector:@selector(restartNewGameEvent)])
        [_delegate restartNewGameEvent];
    [_delegate release];
}

@end
