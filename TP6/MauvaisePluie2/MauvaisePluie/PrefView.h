//
//  PrefView.h
//  
//
//  Created by ilyas TOUMLILT on 26/10/2015.
//
//

#import <UIKit/UIKit.h>

@interface PrefView : UIView

@property (retain, nonatomic) UIPickerView* levelsPickerView;
@property (retain, nonatomic) UIButton*     doneButton;

- (void)drawSubviews:(CGSize)frame;

@end
