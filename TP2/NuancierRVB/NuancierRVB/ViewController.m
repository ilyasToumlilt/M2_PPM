//
//  ViewController.m
//  NuancierRVB
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
    [self switchSetup];
    [self resetSetup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)resetSetup {
    _myRSlider.value = _myVSlider.value = _myBSlider.value =  (_mySwitch.isOn) ? 5 : 50;
    [self updateAll];
    _myButtonPrec.backgroundColor = _myButtonPenu.backgroundColor = _myActualColorView.backgroundColor;
}

- (void)switchSetup {
    if( _mySwitch.isOn ) {
        _myRSlider.value = (int)_myRSlider.value/10;
        _myVSlider.value = (int)_myVSlider.value/10;
        _myBSlider.value = (int)_myBSlider.value/10;
        _myRSlider.maximumValue = _myVSlider.maximumValue = _myBSlider.maximumValue = 10;
    } else {
        _myRSlider.maximumValue = _myVSlider.maximumValue = _myBSlider.maximumValue = 100;
        _myRSlider.value = _myRSlider.value*10;
        _myVSlider.value = _myVSlider.value*10;
        _myBSlider.value = _myBSlider.value*10;
    }
    [self updateAll];
}

- (void)updateAll {
    _myActualColorView.backgroundColor = [UIColor colorWithRed:_myRSlider.value/((_mySwitch.isOn)?10:100) green:_myVSlider.value/((_mySwitch.isOn)?10:100) blue:_myBSlider.value/((_mySwitch.isOn)?10:100) alpha:1];
    _myRLabel.text = [NSString stringWithFormat:@"R: %d%@%%", (int)_myRSlider.value, ((_mySwitch.isOn) ? @"0":@"")];
    _myVLabel.text = [NSString stringWithFormat:@"V: %d%@%%", ((int)_myVSlider.value), ((_mySwitch.isOn) ? @"0":@"")];
    _myBLabel.text = [NSString stringWithFormat:@"B: %d%@%%", ((int)_myBSlider.value), ((_mySwitch.isOn) ? @"0":@"")];
}

- (IBAction)onClickPrecPenu:(UIButton *)sender {
    CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha =0.0;
    [sender.backgroundColor getRed:&red green:&green blue:&blue alpha:&alpha];

    
    _myRSlider.value = (_mySwitch.isOn) ? red*10 : red*100;
    _myVSlider.value = (_mySwitch.isOn) ? green*10 : green*100;
    _myBSlider.value = (_mySwitch.isOn) ? blue*10 : green*100;
    
    [self updateAll];
}

- (IBAction)onChangeSliders:(UISlider *)sender {
    [self updateAll];
}

- (IBAction)onClickSave:(UIButton *)sender {
    _myButtonPenu.backgroundColor = _myButtonPrec.backgroundColor;
    _myButtonPrec.backgroundColor = _myActualColorView.backgroundColor;
}

- (IBAction)onClickReset:(UIButton *)sender {
    [self resetSetup];
}

- (IBAction)onChangeSwitch:(UISwitch *)sender {
    [self switchSetup];
}
@end
