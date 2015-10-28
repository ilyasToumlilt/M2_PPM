//
//  GameViewController.h
//  
//
//  Created by ilyas TOUMLILT on 26/10/2015.
//
//

#import <UIKit/UIKit.h>

@interface GameViewController : UIViewController

@property (assign, nonatomic) int score;
@property (assign, nonatomic) int level;

- (GameViewController*)initWithLevel:(int)level;

- (void)showView;
- (void)hideView;

@end
