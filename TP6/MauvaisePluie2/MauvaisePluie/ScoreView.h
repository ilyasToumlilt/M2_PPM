//
//  ScoreView.h
//
//
//  Created by ilyas TOUMLILT on 26/10/2015.
//
//

#import <UIKit/UIKit.h>

@interface ScoreView : UIView
@property (retain, nonatomic) UIVisualEffectView*   blurBkg;
@property (nonatomic, strong) NSMutableArray*       scoresLabels;
@property (nonatomic, strong) UILabel*              bestScLab;
@property (nonatomic, strong) UILabel*              yourScore;
@property (nonatomic, strong) UILabel*              yourScoreVal;
@property (nonatomic, strong) UIButton*             doneBtn;
@property (nonatomic, strong) UITextField*          typeName;

-(void)clearPlaceHolderTypeName;
-(void)drawScores:(NSMutableArray*)scores;
-(void)setCurrentScore:(NSInteger)curScore;

- (void)showInputStuff;
- (void)hideInputStuff;

- (void)centerTextField;
- (void)endCenterTextField;

@end