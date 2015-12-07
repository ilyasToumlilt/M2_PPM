//
//  LMDetailsViewController.m
//  Localise-Moi
//
//  Created by m2sar on 07/12/2015.
//  Copyright (c) 2015 Ilyas Toumlilt - Adrien Ferreira. All rights reserved.
//

#import "LMDetailsViewController.h"

@interface LMDetailsViewController ()

@end

@implementation LMDetailsViewController

- (instancetype)init
{
    [super init];
    
    if(self){
        /* tabBarItem pour les iphones < 6 */
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone &&
            [[UIScreen mainScreen] scale] != 3.0) {
            self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Localisation" image:[UIImage imageNamed:@"icone-terre"] tag:1];
        }
        /* titre de la navigationBar */
        self.navigationItem.title = [NSString stringWithFormat:@"Localisation"];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /* myLMMapView */
    _myLMMapView = [[LMMapView alloc] initWithFrame:self.view.frame];
    
    /* Adding my cool subviews */
    [self.view addSubview:_myLMMapView];
    
    /* releasing stuff */
    [_myLMMapView release];
}

- (void)drawSubviews:(CGSize)size
{
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, size.width, size.height);
    
    [_myLMMapView drawSubviews:CGRectMake(0, self.navigationController.navigationBar.frame.size.height, size.width, size.height)];
}

- (void)viewDidLayoutSubviews
{
    [self drawSubviews:[[[[self navigationController] topViewController] view] frame].size];
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
