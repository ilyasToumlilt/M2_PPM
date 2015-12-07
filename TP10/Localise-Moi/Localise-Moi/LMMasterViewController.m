//
//  LMMasterViewController.m
//  Localise-Moi
//
//  Created by m2sar on 07/12/2015.
//  Copyright (c) 2015 Ilyas Toumlilt - Adrien Ferreira. All rights reserved.
//

#import "LMMasterViewController.h"

@interface LMMasterViewController ()

@end

@implementation LMMasterViewController

- (instancetype)init
{
    [super init];
    
    if(self){
        /* tabBarItem pour les iphones < 6 */
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone &&
            [[UIScreen mainScreen] scale] != 3.0) {
            self.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemHistory tag:2];
        }
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor redColor];
    
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
