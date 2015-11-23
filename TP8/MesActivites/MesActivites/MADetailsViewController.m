//
//  MADetailsViewController.m
//  MesActivites
//
//  Created by m2sar on 23/11/2015.
//  Copyright (c) 2015 ilyas TOUMLILT. All rights reserved.
//

#import "MADetailsViewController.h"

#import "MaTask.h"

@interface MADetailsViewController ()

@end

@implementation MADetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateDetailsViewWithTask:(MaTask *)task
{
    
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
    [_splitVC release];
    
    [super dealloc];
}

@end
