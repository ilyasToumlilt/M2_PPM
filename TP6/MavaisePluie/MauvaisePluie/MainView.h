//
//  MainView.h
//  
//
//  Created by ilyas TOUMLILT on 26/10/2015.
//
//

#import <UIKit/UIKit.h>

@interface MainView : UIView

@property (retain, nonatomic) UIButton* scoreButton;
@property (retain, nonatomic) UIButton* gameButton;
@property (retain, nonatomic) UIButton* prefButton;

- (void)drawSubviews:(CGSize)frame;
- (void)showSubviews;
- (void)hideSubviews;

@end
