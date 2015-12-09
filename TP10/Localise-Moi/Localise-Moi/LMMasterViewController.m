//
//  LMMasterViewController.m
//  Localise-Moi
//
//  Created by m2sar on 07/12/2015.
//  Copyright (c) 2015 Ilyas Toumlilt - Adrien Ferreira. All rights reserved.
//

#import "LMMasterViewController.h"
#import "LMLocation.h"

@interface LMMasterViewController ()


@property (nonatomic,retain)UIBarButtonItem* saveItem;
@property (nonatomic,retain)UIBarButtonItem* editCell;

@property (nonatomic, retain) UIAlertView* notificationAlert;

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
        
        /* titre de la navigationBar */
        self.navigationItem.title = [NSString stringWithFormat:@"History"];
        
        /* locationDataArray */
        _locationDataArray = [[NSMutableArray alloc] init];
        [self loadLocationDataArray];
        
        /* notificationAlert */
        _notificationAlert = nil;
    }
    
    return self;
}

/************************************************************************************************
 * View Setup
 ***********************************************************************************************/
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /* localisationTableView */
    _localisationTV = [[UITableView alloc] init];
    _localisationTV.delegate = self;
    _localisationTV.dataSource = self;
    [_localisationTV setEditing:NO animated:YES];
    
    /* drawing my cool views */
    [self drawSubviews:[[[[self navigationController] topViewController] view] frame].size];

    /* adding my cool subviews */
    [self.view addSubview:_localisationTV];
    
    /* adding edit button */
    self.editCell = [[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editCellAction)];
    [[self navigationItem]setLeftBarButtonItem:self.editCell];
    
    /* adding save button */
    self.saveItem = [[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveItemAction)];
    [[self navigationItem]setRightBarButtonItem:self.saveItem];
    
    /* releasing memory */
    [_localisationTV release];
}

- (void)viewDidAppear:(BOOL)animated
{
    UIUserNotificationSettings* autorisation = [[UIApplication sharedApplication] currentUserNotificationSettings];
    if(autorisation.types == UIUserNotificationTypeNone){
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Problème"
                                                        message:@"Notifications désactivées"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        
        [alert show];
    }
}

/************************************************************************************************
 * Managing Views
 ***********************************************************************************************/
- (void)drawSubviews:(CGSize)size
{
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, size.width, size.height);
    
    _localisationTV.frame = CGRectMake(0,
                                       0,
                                       size.width,
                                       size.height);
}

- (void)viewDidLayoutSubviews
{
    [self drawSubviews:[[[[self navigationController] topViewController] view] frame].size];
}

/************************************************************************************************
 * Notifications
 ***********************************************************************************************/
- (void)pushNewNotificationWithDescription:(NSString*)desc
{
    UIApplication* app = [UIApplication sharedApplication];
    UILocalNotification* n = [[UILocalNotification alloc] init];
    
    [n setAlertAction:@"Alerte de Localise-Moi"];
    [n setAlertBody:desc];
    [n setApplicationIconBadgeNumber:[app applicationIconBadgeNumber]+1];
    [n setUserInfo:[[NSDictionary alloc] initWithObjectsAndKeys:@"Localise-Moi", @"IDkey", nil]];
    [n setSoundName:UILocalNotificationDefaultSoundName];
    [app presentLocalNotificationNow:n];
}

/************************************************************************************************
 * LMDetailsViewControllerDelegate
 ***********************************************************************************************/
- (void)addLocation:(CLLocationCoordinate2D)location withRequest:(NSString *)request
{
    LMLocation* newLocation = [[LMLocation alloc] initWithNumber:(int)_locationDataArray.count
                                                  andDescription:[NSString stringWithString:request]
                                                   andCoordinate:location];
    [_locationDataArray addObject:newLocation];
    
    [_localisationTV performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    
    [self pushNewNotificationWithDescription:request];
}

/************************************************************************************************
 * LMLocationData
 ***********************************************************************************************/
- (void)updateDataNumbers
{
    int i;
    LMLocation* tmp;
    for(i=0; i<_locationDataArray.count; i++){
        tmp = _locationDataArray[i];
        tmp.number = i;
    }
}

/************************************************************************************************
 * UITableViewDelegate & UITableViewDataSource
 ***********************************************************************************************/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    LMLocation* tmp = [_locationDataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"Adresse %d", tmp.number+1];
    cell.detailTextLabel.text = [NSString stringWithString:tmp.desc];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _locationDataArray.count;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSString *stringToMove = [_locationDataArray objectAtIndex:sourceIndexPath.row];
    [_locationDataArray removeObjectAtIndex:sourceIndexPath.row];
    [_locationDataArray insertObject:stringToMove atIndex:destinationIndexPath.row];
    
    [self updateDataNumbers];
    
    [_localisationTV performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LMLocation* tmp = [_locationDataArray objectAtIndex:(int)indexPath.row];
    [_detailsVC.myLMMapView goToLocation:tmp.coord];
    [_detailsVC.myLMMapView.searchTextField setText:[tmp.desc copy]];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone &&
        [[UIScreen mainScreen] scale] != 3.0) {
        self.tabBarController.selectedIndex = 0;
    }
}

/************************************************************************************************
 * Buttons actions
 ***********************************************************************************************/
- (void)editCellAction
{
    [_localisationTV setEditing:!_localisationTV.editing animated:YES];
    _editCell.title = (_localisationTV.editing) ? @"Done" : @"Edit";
}

- (void)saveItemAction
{
    [self saveLocationDataArray];
}

/************************************************************************************************
 * Persistant Data Store
 ***********************************************************************************************/
- (void)saveLocationDataArray
{
    // Get path to documents directory
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    
    if ([paths count] > 0)
    {
        // Path to save array data
        NSString  *arrayPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"array.out"];
        
        // Write array
        //[_locationDataArray writeToFile:arrayPath atomically:YES];
        BOOL result = [NSKeyedArchiver archiveRootObject:_locationDataArray toFile:arrayPath];
        if (!result) NSLog(@"NOO");
        
    } else NSLog(@"NO paths");
}

-(void)loadLocationDataArray
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    if ([paths count] > 0)
    {
        // Path to save array data
        NSString  *arrayPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"array.out"];
        
        //NSArray* tmp = [NSArray arrayWithContentsOfFile:arrayPath];
        
        NSArray* tmp = [[NSKeyedUnarchiver unarchiveObjectWithFile:arrayPath] copy];
        [_locationDataArray removeAllObjects];
        [_locationDataArray addObjectsFromArray:tmp];
        [_localisationTV performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    } else NSLog(@"No file to retrieve");
    
    [self updateDataNumbers];
}

/************************************************************************************************
 * Memory Care Center
 ***********************************************************************************************/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_locationDataArray release];
    _detailsVC = nil;
    
    [super dealloc];
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
