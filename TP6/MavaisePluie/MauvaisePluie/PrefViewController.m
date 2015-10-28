//
//  PrefViewController.m
//  
//
//  Created by ilyas TOUMLILT on 26/10/2015.
//
//

#import "PrefViewController.h"
#import "PrefView.h"

@interface PrefViewController () {
    PrefView* myView;
}

@end

@implementation PrefViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    myView = [[PrefView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:myView]; [myView release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showView
{
    [myView setHidden:false];
}

- (void)hideView
{
    [myView setHidden:true];
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
