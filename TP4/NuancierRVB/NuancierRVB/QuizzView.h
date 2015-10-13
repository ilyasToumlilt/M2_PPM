#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface QuizzView:UIView
    @property (retain, nonatomic) UIButton *myButtonPrec;
    @property (retain, nonatomic) UILabel *myLabelPrec;

    @property (retain, nonatomic) UIButton *myButtonPenu;
    @property (retain, nonatomic) UILabel *myLabelPenu;

    @property (retain, nonatomic) UILabel *myLabelActuel;

    @property (retain, nonatomic) UIView *myActualColorView;


    @property (retain, nonatomic) UILabel *myRLabel;
    @property (retain, nonatomic) UISlider *myRSlider;

    @property (retain, nonatomic) UILabel *myVLabel;
    @property (retain, nonatomic) UISlider *myVSlider;


    @property (retain, nonatomic) UILabel *myBLabel;
    @property (retain, nonatomic) UISlider *myBSlider;

    @property (retain, nonatomic) UIButton *myButtonSave;
    @property (retain, nonatomic) UIButton *myButtonRaz;

    @property (retain, nonatomic) UISwitch *mySwitch;

@end