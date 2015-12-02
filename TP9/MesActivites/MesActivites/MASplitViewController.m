//
//  MASplitViewController.m
//  MesActivites
//
//  Created by m2sar on 23/11/2015.
//  Copyright (c) 2015 ilyas TOUMLILT. All rights reserved.
//

#import "MASplitViewController.h"

@interface MASplitViewController ()

@end

@implementation MASplitViewController

- (instancetype)init
{
    self = [super init];
    
    if( self ){
        _masterVC = [[MAMasterViewController alloc] init];
        _masterVC.splitVC = self;
        
        _detailsVC = [[MADetailsViewController alloc] init];
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

/**
 * Releasing stuff
 */
- (void)dealloc
{
    [_masterVC release];
    [_detailsVC release];
    
    [super dealloc];
}

@end
