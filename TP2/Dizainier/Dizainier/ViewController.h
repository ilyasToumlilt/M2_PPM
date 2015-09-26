//
//  ViewController.h
//  Dizainier
//
//  Created by m2sar on 26/09/2015.
//  Copyright (c) 2015 m2sar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIStepper *myStepper;
@property (weak, nonatomic) IBOutlet UISwitch *mySwitch;
@property (weak, nonatomic) IBOutlet UISegmentedControl *mySedmentedDizaines;
@property (weak, nonatomic) IBOutlet UISegmentedControl *mySegmentedUnites;
@property (weak, nonatomic) IBOutlet UILabel *myLabel;
@property (weak, nonatomic) IBOutlet UISlider *mySlider;

- (IBAction)onClickMyStepper:(UIStepper *)sender;
- (IBAction)onClickMySwitch:(UISwitch *)sender;
- (IBAction)onClickSegmentedCtrl:(UISegmentedControl *)sender;
- (IBAction)onClickSlider:(UISlider *)sender;
- (IBAction)onTouchUpRaZ:(UIButton *)sender;

@end

