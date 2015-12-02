//
//  GameScoreView.h
//  rouleTaBille
//
//  Created by m2sar on 30/11/2015.
//  Copyright (c) 2015 Ilyas Toumlilt - Adrien Ferreira. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameScoreView : UIView

@property (nonatomic, assign) int score;
@property (nonatomic, retain) UILabel* scoreLabel;
@property (nonatomic, retain) UIImageView* scoreImageView;

- (instancetype)initWithFrame:(CGRect)frame andScore:(int)score;

- (void)incrementScore;
- (void)updateScoreLabel;

@end
