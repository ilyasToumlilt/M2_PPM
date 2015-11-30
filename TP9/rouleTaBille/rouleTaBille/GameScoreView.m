//
//  GameScoreView.m
//  rouleTaBille
//
//  Created by m2sar on 30/11/2015.
//  Copyright (c) 2015 Ilyas Toumlilt - Adrien Ferreira. All rights reserved.
//

#import "GameScoreView.h"

@implementation GameScoreView

/*************************************************************************************
 * Setup
 ************************************************************************************/
- (instancetype)initWithFrame:(CGRect)frame andScore:(int)score
{
    self = [super initWithFrame:frame];
    
    if( self ){
        
        _score = score;
        
        /* scoreLabel */
        _scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width/2, 0, frame.size.width/2, frame.size.height)];
        _scoreLabel.textColor = [UIColor whiteColor];
        _scoreLabel.textAlignment = NSTextAlignmentCenter;
        [self updateScoreLabel];
        
        /* scoreImageView */
        _scoreImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width/2, frame.size.height)];
        _scoreImageView.image = [UIImage imageNamed:@"etoile-96"];
        
        /* adding my cool subviews */
        [self addSubview:_scoreLabel];
        [self addSubview:_scoreImageView];
        
        /* releasing stuff */
        [_scoreLabel release];
        [_scoreImageView release];
    }
    
    return self;
}

/**
 * Mise à jour du scoreLabel avec la valeur actuelle de score
 */
- (void)updateScoreLabel
{
    _scoreLabel.text = [NSString stringWithFormat:@"%02d", _score];
}

/**
 * Incrémente le score et met à jour le scoreLabel
 */
- (void)incrementScore
{
    _score++;
    [self updateScoreLabel];
}

@end
