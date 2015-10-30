//
//  ScoreViewController.h
//
//
//  Created by ilyas TOUMLILT on 26/10/2015.
//
//

#import <UIKit/UIKit.h>

@protocol ScoreViewControllerDelegate;

@interface ScoreViewController : UIViewController<UITextFieldDelegate>

@property (assign, nonatomic) id<ScoreViewControllerDelegate> delegate;

- (void)showView;
- (void)hideView;
- (void)addNewScore:(NSInteger)newScore;

@end

@protocol ScoreViewControllerDelegate <NSObject>

- (void)endScoreAction;

@end