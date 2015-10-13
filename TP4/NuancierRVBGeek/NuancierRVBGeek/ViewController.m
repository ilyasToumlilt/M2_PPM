//
//  ViewController.m
//  NuancierRVBGeek
//
//  Created by ilyas TOUMLILT on 13/10/2015.
//  Copyright (c) 2015 ilyas TOUMLILT. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    myView = [[View alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [[self view] addSubview:myView];
    [myView release];
    
    /* actions */
    [myView.myButtonPrec addTarget:self action:@selector(onClickPrecPenu:) forControlEvents:UIControlEventTouchDown];
    [myView.myButtonPenu addTarget:self action:@selector(onClickPrecPenu:) forControlEvents:UIControlEventTouchDown];
    [myView.myRSlider addTarget:self action:@selector(onChangeSliders:) forControlEvents:UIControlEventValueChanged];
    [myView.myVSlider addTarget:self action:@selector(onChangeSliders:) forControlEvents:UIControlEventValueChanged];
    [myView.myBSlider addTarget:self action:@selector(onChangeSliders:) forControlEvents:UIControlEventValueChanged];
    [myView.mySaveButton addTarget:self action:@selector(onClickSave:) forControlEvents:UIControlEventTouchDown];
    [myView.myResetButton addTarget:self action:@selector(onClickReset:) forControlEvents:UIControlEventTouchDown];
    [myView.mySwitch addTarget:self action:@selector(onChangeSwitch:) forControlEvents:UIControlEventValueChanged];
    
    [self switchSetup];
    [self resetSetup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)resetSetup {
    myView.myRSlider.value = myView.myVSlider.value = myView.myBSlider.value =  (myView.mySwitch.isOn) ? 5 : 50;
    [self updateAll];
    myView.myButtonPrec.backgroundColor = myView.myButtonPenu.backgroundColor = myView.myActualColorView.backgroundColor;
}

- (void)switchSetup {
    if( myView.mySwitch.isOn ) {
        myView.myRSlider.value = (int)myView.myRSlider.value/10;
        myView.myVSlider.value = (int)myView.myVSlider.value/10;
        myView.myBSlider.value = (int)myView.myBSlider.value/10;
        myView.myRSlider.maximumValue = myView.myVSlider.maximumValue = myView.myBSlider.maximumValue = 10;
    } else {
        myView.myRSlider.maximumValue = myView.myVSlider.maximumValue = myView.myBSlider.maximumValue = 100;
        myView.myRSlider.value = myView.myRSlider.value*10;
        myView.myVSlider.value = myView.myVSlider.value*10;
        myView.myBSlider.value = myView.myBSlider.value*10;
    }
    [self updateAll];
}

- (void)updateAll {
    myView.myActualColorView.backgroundColor = [UIColor colorWithRed:myView.myRSlider.value/((myView.mySwitch.isOn)?10:100) green:myView.myVSlider.value/((myView.mySwitch.isOn)?10:100) blue:myView.myBSlider.value/((myView.mySwitch.isOn)?10:100) alpha:1];
    myView.myRLabel.text = [NSString stringWithFormat:@"R: %d%@%%", (int)myView.myRSlider.value, ((myView.mySwitch.isOn) ? @"0":@"")];
    myView.myVLabel.text = [NSString stringWithFormat:@"V: %d%@%%", ((int)myView.myVSlider.value), ((myView.mySwitch.isOn) ? @"0":@"")];
    myView.myBLabel.text = [NSString stringWithFormat:@"B: %d%@%%", ((int)myView.myBSlider.value), ((myView.mySwitch.isOn) ? @"0":@"")];
}

- (void)onClickPrecPenu:(UIButton *)sender {
    CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha =0.0;
    [sender.backgroundColor getRed:&red green:&green blue:&blue alpha:&alpha];
    
    
    myView.myRSlider.value = (myView.mySwitch.isOn) ? red*10 : red*100;
    myView.myVSlider.value = (myView.mySwitch.isOn) ? green*10 : green*100;
    myView.myBSlider.value = (myView.mySwitch.isOn) ? blue*10 : green*100;
    
    [self updateAll];
}

- (void)onChangeSliders:(UISlider *)sender {
    [self updateAll];
}

- (void)onClickSave:(UIButton *)sender {
    myView.myButtonPenu.backgroundColor = myView.myButtonPrec.backgroundColor;
    myView.myButtonPrec.backgroundColor = myView.myActualColorView.backgroundColor;
}

- (void)onClickReset:(UIButton *)sender {
    [self resetSetup];
}

- (void)onChangeSwitch:(UISwitch *)sender {
    [self switchSetup];
}

@end
