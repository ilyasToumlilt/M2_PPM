//
//  ViewController.m
//  Dizainier
//
//  Created by m2sar on 26/09/2015.
//  Copyright (c) 2015 m2sar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self updateAll:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)updateAll:(int)newValue {
    _myStepper.value = newValue;
    _mySlider.value = newValue;
    _mySegmentedUnites.selectedSegmentIndex = newValue % 10;
    _mySedmentedDizaines.selectedSegmentIndex = newValue / 10;
    [self updateLabel:newValue];
}

- (void)updateLabel:(int)newValue {
    _myLabel.text = [NSString stringWithFormat:((_mySwitch.isOn) ? @"%X" : @"%d"), newValue];
    _myLabel.textColor = (newValue != 42) ? [UIColor blackColor] : [UIColor redColor];
}

- (IBAction)onClickMyStepper:(UIStepper *)sender {
    [self updateAll:_myStepper.value];
}

- (IBAction)onClickMySwitch:(UISwitch *)sender {
    [self updateLabel:_myStepper.value];
}

- (IBAction)onClickSegmentedCtrl:(UISegmentedControl *)sender {
    [self updateAll:((int)_mySedmentedDizaines.selectedSegmentIndex*10)+(int)_mySegmentedUnites.selectedSegmentIndex];
}

- (IBAction)onClickSlider:(UISlider *)sender {
    [self updateAll:(int)_mySlider.value];
}

- (IBAction)onTouchUpRaZ:(UIButton *)sender {
    [self updateAll:0];
}
@end
