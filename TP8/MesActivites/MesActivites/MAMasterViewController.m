//
//  MAMasterViewController.m
//  MesActivites
//
//  Created by m2sar on 23/11/2015.
//  Copyright (c) 2015 ilyas TOUMLILT. All rights reserved.
//

#import "MAMasterViewController.h"
#import "MASplitViewController.h"

@interface MAMasterViewController ()

@end

@implementation MAMasterViewController

BOOL fermerDVC;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    fermerDVC = YES;
    [[self navigationItem] setTitle:@"Master"];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    _tasksTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    [_tasksTableView setDelegate:self];
    [_tasksTableView setDataSource:self];
    [self.view addSubview:_tasksTableView];
    
    _tasksData = [[NSMutableArray alloc] initWithObjects:@"Bleu", @"Blanc", @"Rouge", nil];
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

/************************************************************************************************
 * UISplitViewControllerDelegate Methods
 ***********************************************************************************************/
- (void)splitViewController:(UISplitViewController *)svc
    willChangeToDisplayMode:(UISplitViewControllerDisplayMode)displayMode
{
    if(displayMode == UISplitViewControllerDisplayModePrimaryHidden) {
        // On va vers un affichage de la vue de détail seulement
        [[[[[_splitVC detailsVC] navigationController] topViewController] navigationItem] setLeftBarButtonItem:[svc displayModeButtonItem]];
    }
    if(displayMode == UISplitViewControllerDisplayModeAllVisible) {
        // On va vers un affichage de deux vues
        [[[[[_splitVC detailsVC] navigationController] topViewController] navigationItem] setLeftBarButtonItem:nil];
    }
}

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController
{
    return fermerDVC;
}

- (UISplitViewControllerDisplayMode)targetDisplayModeForActionInSplitViewController:(UISplitViewController *)svc
{
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UISplitViewControllerDisplayModeAllVisible;
    } else {
        return UISplitViewControllerDisplayModePrimaryOverlay;
    }
}

/************************************************************************************************
 * TableViewDelegate Methods
 ***********************************************************************************************/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    return [_tasksData count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        
    }
    
    cell.textLabel.text = [_tasksData objectAtIndex:indexPath.row];
    
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"prio-%d", (int)indexPath.row]];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if( indexPath.row == 0 )
        _detailsVC.view.backgroundColor = [UIColor blueColor];
    if( indexPath.row == 1 )
        _detailsVC.view.backgroundColor = [UIColor whiteColor];
    if( indexPath.row == 2 )
        _detailsVC.view.backgroundColor = [UIColor redColor];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone &&
        [[UIScreen mainScreen] scale] != 3.0) {
        [[self navigationController] pushViewController:_detailsVC animated:YES];
    }
}

/**
 * Releasing stuff
 */
- (void)dealloc
{
    [_tasksTableView release];
    [_tasksData release];
    [_detailsVC release];
    [_splitVC release];
    
    [super dealloc];
}

@end
