//
//  GameTimerView.h
//  rouleTaBille
//
//  Created by m2sar on 30/11/2015.
//  Copyright (c) 2015 Ilyas Toumlilt - Adrien Ferreira. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GameTimerViewDelegate;

@interface GameTimerView : UIView

@property (assign, nonatomic) id<GameTimerViewDelegate> delegate;

@property (nonatomic, retain) UILabel* timeLabel;
@property (nonatomic, assign) int remainingTime;

- (instancetype)initWithFrame:(CGRect)frame andTime:(int)seconds;

@end

@protocol GameTimerViewDelegate <NSObject>

- (void)gameTimerEndNotification;

@end
