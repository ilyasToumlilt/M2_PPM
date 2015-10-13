//
//  View.h
//  NuancierRVBGeek
//
//  Created by ilyas TOUMLILT on 13/10/2015.
//  Copyright (c) 2015 ilyas TOUMLILT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface View : UIView {
    
}

@property (retain, nonatomic) UIButton* myButtonPrec;
@property (retain, nonatomic) UIButton* myButtonPenu;

@property (retain, nonatomic) UILabel  *myLabelPrec;
@property (retain, nonatomic) UILabel  *myLabelPenu;

@property (retain, nonatomic) UILabel* myActualLabel;
@property (retain, nonatomic) UIView*  myActualColorView;

@property (retain, nonatomic) UILabel*  myRLabel;
@property (retain, nonatomic) UISlider* myRSlider;

@property (retain, nonatomic) UILabel*  myVLabel;
@property (retain, nonatomic) UISlider* myVSlider;

@property (retain, nonatomic) UILabel*  myBLabel;
@property (retain, nonatomic) UISlider* myBSlider;

@property (retain, nonatomic) UIButton* mySaveButton;
@property (retain, nonatomic) UIButton* myResetButton;
@property (retain, nonatomic) UISwitch* mySwitch;
@property (retain, nonatomic) UILabel*  myWebLabel;

@end
