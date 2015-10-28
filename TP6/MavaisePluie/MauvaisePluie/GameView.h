//
//  GameView.h
//  
//
//  Created by ilyas TOUMLILT on 26/10/2015.
//
//

#import <UIKit/UIKit.h>

#import "MinionView.h"

@interface GameView : UIView

@property (retain, nonatomic) UILabel* levelLabel;
@property (retain, nonatomic) UILabel* scoreLabel;

@property (retain, nonatomic) UIButton* leftButton;
@property (retain, nonatomic) UIButton* rightButton;

@property (assign, nonatomic) MinionView* myMinionView;

@end
