//
//  LMSplitViewController.m
//  Localise-Moi
//
//  Created by m2sar on 07/12/2015.
//  Copyright (c) 2015 Ilyas Toumlilt - Adrien Ferreira. All rights reserved.
//

#import "LMSplitViewController.h"

@interface LMSplitViewController ()

@end

@implementation LMSplitViewController

- (instancetype)init
{
    self = [super init];
    
    if( self ){
        _masterVC = [[LMMasterViewController alloc] init];
        _masterVC.splitVC = self;
        
        _detailsVC = [[LMDetailsViewController alloc] init];
        _detailsVC.splitVC = self;
        
        _masterVC.detailsVC = _detailsVC;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
