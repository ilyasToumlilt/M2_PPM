//
//  StartGameAlertView.m
//  rouleTaBille
//
//  Created by m2sar on 30/11/2015.
//  Copyright (c) 2015 Ilyas Toumlilt - Adrien Ferreira. All rights reserved.
//

/**
 * Ceci est simplement la première view qui s'affiche pour alerter le début d'une partie
 * elle temporise le démarrage du jeu
 */

#import "StartGameAlertView.h"

@interface StartGameAlertView ()

@property (nonatomic, retain) NSTimer* myTimer;
@property (nonatomic, retain) UILabel* instructionsLabel;
@property (nonatomic, retain) UILabel* counterLabel;
@property (nonatomic, assign) int counter;

@end

@implementation StartGameAlertView

#define DEFAULT_COUNTER 5 /* temps avant début d'une partie */
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
        
        /* instructionsLabel */
        _instructionsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, V_WIDTH, V_HEIGHT / 2)];
        _instructionsLabel.textAlignment = NSTextAlignmentCenter;
        _instructionsLabel.textColor = [UIColor whiteColor];
        _instructionsLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _instructionsLabel.numberOfLines = 3;
        _instructionsLabel.text = [NSString stringWithFormat:@"Ramassez un maximum\nd'étoile en 1 minute\nBonne chance !"];
        
        /* initial counter */
        _counter = DEFAULT_COUNTER;
        
        /* counter Label */
        _counterLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, V_HEIGHT-55, V_WIDTH, 30) ];
        _counterLabel.textAlignment = NSTextAlignmentCenter;
        _counterLabel.textColor = [UIColor whiteColor];
        _counterLabel.font = [_counterLabel.font fontWithSize:30];
        [self updateCounterLabel];
        
        /* NSTimer */
        _myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                    target:self
                                                  selector:@selector(timerHandler:)
                                                  userInfo:nil
                                                   repeats:YES];
        
        /* Adding my amazing subviews */
        [self addSubview:_instructionsLabel];
        [self addSubview:_counterLabel];
        
        /* Releasing Stuff */
        [_instructionsLabel release];
        [_counterLabel release];
    }
    
    return self;
}

- (void)updateCounterLabel
{
    _counterLabel.text = [NSString stringWithFormat:@"%d", _counter];
}

- (void)showView
{
    self.hidden = NO;
}

- (void)hideView
{
    self.hidden = YES;
}

/*************************************************************************************
 * Timer Handling
 ************************************************************************************/
/**
 * Methode appelée par le NSTimer, toutes les secondes
 */
- (void)timerHandler:(NSTimer*)timer
{
    _counter--;
    [self updateCounterLabel];
    if(!_counter){
        [_myTimer invalidate];
        _myTimer = nil;
        [_delegate retain];
        if([_delegate respondsToSelector:@selector(startGameTimerEnded)]){
            [_delegate startGameTimerEnded];
        }
        [_delegate release];
    }
}

@end
