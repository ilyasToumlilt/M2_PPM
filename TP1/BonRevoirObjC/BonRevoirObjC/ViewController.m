//
//  ViewController.m
//  BonRevoirObjC
//
//  Created by m2sar on 19/09/2015.
//
//  @author Ilyas  Toumlilt - <ilyas.toumlilt@etu.upmc.fr>
//  @author Adrien Ferreira - <adrien.ferreira@etu.upmc.fr>
//
//  Copyright (c) 2015 m2sar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _myLabel.text = @"";
    [_myButton setTitle:@"Dis Bonjour !" forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClickMyButton:(id)sender {
    if ([_myButton.titleLabel.text isEqualToString:@"Dis Bonjour !"] ){
        [_myLabel setText:@"Bonjour!!!"];
        [_myButton setTitle:@"Dis Au Revoir !" forState:UIControlStateNormal];
    } else {
        [_myLabel setText:@"Au Revoir!!!"];
        [_myButton setTitle:@"Dis Bonjour !" forState:UIControlStateNormal];
    }
}
@end
