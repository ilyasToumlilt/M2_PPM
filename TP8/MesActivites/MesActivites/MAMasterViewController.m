//
//  MAMasterViewController.m
//  MesActivites
//
//  Created by m2sar on 23/11/2015.
//  Copyright (c) 2015 ilyas TOUMLILT. All rights reserved.
//

#import "MAMasterViewController.h"
#import "MASplitViewController.h"

#define DEF_T_IND_SECT 3
#define DEF_T_SECT_NAMES @[@"Vacances",@"Personnel",@"Urgent",@"Aujourd'hui"]


@interface MAMasterViewController ()
@property (nonatomic,retain)NSArray*sectsName;
@property (nonatomic,retain)UIBarButtonItem*addTask;

@end

@implementation MAMasterViewController

BOOL fermerDVC;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    fermerDVC = YES;
    [[self navigationItem] setTitle:@"Master"];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    _tasksTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 300,self.view.frame.size.height)];
    [_tasksTableView setDelegate:self];
    [_tasksTableView setDataSource:self];
    [_tasksTableView setEditing:YES animated:YES];
    [self.view addSubview:_tasksTableView];
    
    self.addTask = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewTask)];
    [[self navigationItem]setRightBarButtonItem:self.addTask];
    
    self.sectsName=DEF_T_SECT_NAMES;
    self.tasksData =[[NSMutableArray alloc]initWithCapacity:[self.sectsName count]];
    
    for(int i=0; i<[self.sectsName count]; i++)
        [self.tasksData setObject:[[NSMutableArray alloc]init] atIndexedSubscript:i];
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
    NSMutableArray*arrayCurSect;
    arrayCurSect = [self.tasksData objectAtIndex:section];
    return [arrayCurSect count];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.sectsName count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.sectsName[section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray*arrayCurSect;
    arrayCurSect = [self.tasksData objectAtIndex:indexPath.section];
    
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [[arrayCurSect objectAtIndex:indexPath.row] title];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"prio-%d", [[arrayCurSect objectAtIndex:indexPath.row] prio]]];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray*arrayCurSect;
    arrayCurSect = [self.tasksData objectAtIndex:indexPath.section];
    
    [self.splitVC.detailsVC updateDetailsViewWithTask:[arrayCurSect objectAtIndex:indexPath.row]];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone &&
        [[UIScreen mainScreen] scale] != 3.0) {
        [[self navigationController] pushViewController:_detailsVC animated:YES];
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"canMoveRowAtIndexPath");
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSMutableArray*arraySourceCat;
    NSMutableArray*arrayDestinationCat;
    MaTask* taskSource;
    
    arraySourceCat = [self.tasksData objectAtIndex:sourceIndexPath.section];
    arrayDestinationCat = [self.tasksData objectAtIndex:destinationIndexPath.section];
    
    taskSource = [arraySourceCat objectAtIndex:sourceIndexPath.row];

    [arrayDestinationCat insertObject:taskSource atIndex:destinationIndexPath.row];
    [arraySourceCat removeObjectAtIndex:sourceIndexPath.row];
}

/*
- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    return nil;
}*/

-(void)addNewTask{
    NSMutableArray*arrayDefCat;
    arrayDefCat = [self.tasksData objectAtIndex:DEF_T_IND_SECT];
    [arrayDefCat addObject:[[MaTask alloc]init]];
    [self.tasksTableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
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
