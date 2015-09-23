//
//  ViewController.m
//  CouleurObjC
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

// La palette de couleurs :
NSArray* myColors;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    myColors = [NSArray arrayWithObjects:
                [UIColor grayColor],
                [UIColor orangeColor],
                [UIColor redColor],
                [UIColor blueColor],
                [UIColor greenColor],
                [UIColor blackColor],
                nil];
    [_myStepper setMinimumValue:0.0];
    [_myColorView setBackgroundColor:myColors[0]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onChangeMyStepper:(id)sender {
    [_myColorView setBackgroundColor:myColors[(int)_myStepper.value]];
}
@end
