//
//  ViewController.h
//  NuancierRVB
//
//  Created by m2sar on 26/09/2015.
//  Copyright (c) 2015 m2sar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISwitch *mySwitch;
@property (weak, nonatomic) IBOutlet UILabel *myBLabel;
@property (weak, nonatomic) IBOutlet UISlider *myBSlider;
@property (weak, nonatomic) IBOutlet UILabel *myVLabel;
@property (weak, nonatomic) IBOutlet UISlider *myVSlider;
@property (weak, nonatomic) IBOutlet UILabel *myRLabel;
@property (weak, nonatomic) IBOutlet UISlider *myRSlider;
@property (weak, nonatomic) IBOutlet UIButton *myButtonPrec;
@property (weak, nonatomic) IBOutlet UIButton *myButtonPenu;
@property (weak, nonatomic) IBOutlet UIView *myActualColorView;


- (IBAction)onClickPrecPenu:(UIButton *)sender;
- (IBAction)onChangeSliders:(UISlider *)sender;
- (IBAction)onClickSave:(UIButton *)sender;
- (IBAction)onClickReset:(UIButton *)sender;
- (IBAction)onChangeSwitch:(UISwitch *)sender;


@end

