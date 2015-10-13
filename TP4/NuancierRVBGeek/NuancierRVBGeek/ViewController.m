//
//  ViewController.m
//  NuancierRVBGeek
//
//  Created by ilyas TOUMLILT on 13/10/2015.
//  Copyright (c) 2015 ilyas TOUMLILT. All rights reserved.
//

#import "ViewController.h"
#import "View.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    myView = [[View alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [[self view] addSubview:myView];
    [myView release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
