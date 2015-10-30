//
//  MinionView.h
//  
//
//  Created by ilyas TOUMLILT on 27/10/2015.
//
//

#import <UIKit/UIKit.h>

@interface MinionView : UIView

- (instancetype)initWithMovingArea:(CGRect)movingArea;

@property (assign, nonatomic) CGRect movingArea;
@property (assign, nonatomic) CGRect actualPosition;

- (BOOL)canMoveLeft;
- (BOOL)canMoveRight;

- (void)moveLeft;
- (void)moveRight;

@end
