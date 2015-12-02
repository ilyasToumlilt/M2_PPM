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

@interface MAMasterViewController ()
@end

@implementation MAMasterViewController

BOOL fermerDVC;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    fermerDVC = YES;
    [[self navigationItem] setTitle:@"Historique"];
        
    self.historyTableView = [[UITableView alloc] init];
    [self.historyTableView setDelegate:self];
    [self.historyTableView setDataSource:self];
    [self.historyTableView setEditing:NO animated:YES];
    [self drawTasksTableView];
    [self.view addSubview:self.historyTableView];
    
    self.detailsVC.delegate = self;
    self.historyData =[[NSMutableArray alloc]init];

}

- (void)drawTasksTableView
{
    CGSize size = [[[[self navigationController] topViewController] view] frame].size;
    self.historyTableView.frame = CGRectMake(0,
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [[self.historyData objectAtIndex:indexPath.row]valueForProperty:MPMediaItemPropertyTitle];
    
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.historyData count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.detailsVC playHistoryEntry:(MPMediaItem*) [self.historyData objectAtIndex:indexPath.row]];
}

//todo release delegate
- (void)addSongToHistory:(MPMediaItem*)curSong{
    [self.historyData addObject:curSong];
    [self.historyTableView reloadData];
}


/**
 * Releasing stuff
 */
- (void)dealloc
{
    //[_tasksTableView release];
    //[_tasksData release]; /* TODO il faut aussi release les tableaux et les taches à chaque cell */
    [_detailsVC release];
    [_splitVC release];
    
    [super dealloc];
}




@end
