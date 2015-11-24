//
//  MAMasterViewController.m
//  MesActivites
//
//  Created by m2sar on 23/11/2015.
//  Copyright (c) 2015 ilyas TOUMLILT. All rights reserved.
//

#import "MAMasterViewController.h"
#import "MASplitViewController.h"
#import "MADetailsViewController.h"

#define DEF_T_IND_SECT 3
#define DEF_T_SECT_NAMES @[@"Vacances",@"Personnel",@"Urgent",@"Aujourd'hui"]

#define EDIT_MODE_YES_TEXT @"Terminer"
#define EDIT_MODE_NO_TEXT @"Modifier"


@interface MAMasterViewController ()
@property (nonatomic,retain)NSArray*sectsName;
@property (nonatomic,retain)UIBarButtonItem*addTask;
@property (nonatomic,retain)UIBarButtonItem*editTask;
@property (nonatomic,retain)MaTask*selectedTask;
@end

@implementation MAMasterViewController

BOOL fermerDVC;
BOOL editingMode;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    fermerDVC = YES;
    editingMode = NO;
    [[self navigationItem] setTitle:@"Liste de Tâches"];
        
    _tasksTableView = [[UITableView alloc] init];
    [_tasksTableView setDelegate:self];
    [_tasksTableView setDataSource:self];
    [_tasksTableView setEditing:NO animated:YES];
    [self drawTasksTableView];
    [self.view addSubview:_tasksTableView];
    
    self.detailsVC.delegate = self;
    
    self.editTask = [[UIBarButtonItem alloc]initWithTitle:EDIT_MODE_NO_TEXT style:UIBarButtonItemStylePlain target:self action:@selector(editTaskAction)];
    [[self navigationItem]setLeftBarButtonItem:self.editTask];
    
    self.addTask = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewTaskAction)];
    [[self navigationItem]setRightBarButtonItem:self.addTask];
    
    self.sectsName=DEF_T_SECT_NAMES;
    self.tasksData =[[NSMutableArray alloc]initWithCapacity:[self.sectsName count]];
    
    
    for(int i=0; i<[self.sectsName count]; i++)
        [self.tasksData setObject:[[NSMutableArray alloc]init] atIndexedSubscript:i];
    
    [self.tasksTableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fond-alu"]] ];
    
    /*TODO pourquoi pas updated ???
    self.selectedTask = [self addNewTaskAction];
    [self.splitVC.detailsVC updateDetailsViewWithTask:self.selectedTask];
     */
}

- (void)drawTasksTableView
{
    CGSize size = [[[[self navigationController] topViewController] view] frame].size;
    _tasksTableView.frame = CGRectMake(0,
                                 0,
                                 size.width,
                                 size.height);
}

- (void)viewDidLayoutSubviews
{
    [self drawTasksTableView];
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.backgroundView = [[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"bg-tableview-cell"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0] ];
    cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"bg-tableview-cell-sel"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0] ];
    cell.textLabel.text = [[arrayCurSect objectAtIndex:indexPath.row] title];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Priorité actuelle : %d", [[arrayCurSect objectAtIndex:indexPath.row] prio]];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"prio-%d", [[arrayCurSect objectAtIndex:indexPath.row] prio]]];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray*arrayCurSect;
    arrayCurSect = [self.tasksData objectAtIndex:indexPath.section];
    self.selectedTask = [arrayCurSect objectAtIndex:indexPath.row];
    
    [self.splitVC.detailsVC updateDetailsViewWithTask:self.selectedTask];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone &&
        [[UIScreen mainScreen] scale] != 3.0) {
        [[self navigationController] pushViewController:_detailsVC animated:YES];
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray*arrayCurSect;
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        arrayCurSect = [self.tasksData objectAtIndex:indexPath.section];
        [arrayCurSect removeObjectAtIndex:indexPath.row];
        [self didUpdateDetails];
    }
}

/*
- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    return nil;
}*/

-(MaTask*)addNewTaskAction{
    NSMutableArray*arrayDefCat;
    MaTask *newTask;

    newTask = [[MaTask alloc]init];
    arrayDefCat = [self.tasksData objectAtIndex:DEF_T_IND_SECT];
    [arrayDefCat addObject:newTask];
    [self didUpdateDetails];
    return newTask;
}

-(void)editTaskAction{
    editingMode=!editingMode;
    [self.tasksTableView setEditing:editingMode animated:YES];
    self.editTask.title = editingMode?EDIT_MODE_YES_TEXT:EDIT_MODE_NO_TEXT;
}

- (void)didUpdateDetails{
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
