//
//  ScoreViewController.h
//  
//
//  Created by ilyas TOUMLILT on 26/10/2015.
//
//

#import <UIKit/UIKit.h>

@interface ScoreViewController : UIViewController<UITextFieldDelegate>

- (void)showView;
- (void)hideView;
-(void)addNewScore:(NSInteger)newScore;

@end
