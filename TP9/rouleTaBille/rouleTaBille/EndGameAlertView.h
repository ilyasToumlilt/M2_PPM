//
//  EndGameAlertView.h
//  
//
//  Created by ilyas TOUMLILT on 01/12/2015.
//
//

#import <UIKit/UIKit.h>

@protocol EndGameAlertViewDelegate;

@interface EndGameAlertView : UIView

@property (nonatomic, assign) id<EndGameAlertViewDelegate> delegate;

- (void)showViewWithScore:(int)score;

@end

@protocol EndGameAlertViewDelegate <NSObject>

- (void)restartNewGameEvent;

@end