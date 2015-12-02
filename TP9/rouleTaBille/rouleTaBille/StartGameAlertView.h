//
//  StartGameAlertView.h
//  rouleTaBille
//
//  Created by m2sar on 30/11/2015.
//  Copyright (c) 2015 Ilyas Toumlilt - Adrien Ferreira. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StartGameAlertViewDelegate;

@interface StartGameAlertView : UIView

@property (nonatomic, assign) id<StartGameAlertViewDelegate> delegate;

- (void)showView;
- (void)hideView;

@end

@protocol StartGameAlertViewDelegate <NSObject>

- (void)startGameTimerEnded;

@end