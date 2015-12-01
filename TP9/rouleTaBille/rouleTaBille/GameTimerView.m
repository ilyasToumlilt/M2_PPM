//
//  GameTimerView.m
//  rouleTaBille
//
//  Created by m2sar on 30/11/2015.
//  Copyright (c) 2015 Ilyas Toumlilt - Adrien Ferreira. All rights reserved.
//

#import "GameTimerView.h"

@interface GameTimerView ()

@property (nonatomic, retain) NSTimer* myTimer;

@end

@implementation GameTimerView

/*************************************************************************************
 * Setup
 ************************************************************************************/
- (instancetype)initWithFrame:(CGRect)frame andTime:(int)seconds
{
    self = [super initWithFrame:frame];
    
    if( self ){
        //self.backgroundColor = [UIColor redColor];
        
        /* timer */
        _remainingTime = seconds;
        
        /* timeLabel */
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self updateTimeLabel];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.font = [_timeLabel.font fontWithSize:35.0];
        
        [self addSubview:_timeLabel];
        
        [_timeLabel release];
    }
    
    return self;
}

/*************************************************************************************
 * Timer Handling
 ************************************************************************************/
- (void)startTimer
{
    [self updateTimeLabel];
    _myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                target:self
                                              selector:@selector(timerHandler:)
                                              userInfo:nil
                                               repeats:YES];
}

/**
 * Methode appelée par le NSTimer, toutes les secondes
 */
- (void)timerHandler:(NSTimer*)timer
{
    _remainingTime--;
    [self updateTimeLabel];
    if(!_remainingTime){
        [_myTimer invalidate];
        _myTimer = nil;
        [_delegate retain];
        if([_delegate respondsToSelector:@selector(gameTimerEndNotification)])
            [_delegate gameTimerEndNotification];
        [_delegate release];
    }
}

- (void)updateTimeLabel
{
    _timeLabel.text = [NSString stringWithFormat:@"%02d:%02d",
                       _remainingTime/60, _remainingTime%60];
}

@end
