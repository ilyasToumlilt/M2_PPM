//
//  ViewController.m
//  MesActivites
//
//  Created by ilyas TOUMLILT on 22/11/2015.
//  Copyright (c) 2015 ilyas TOUMLILT. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _tasksTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    [_tasksTableView setDelegate:self];
    [_tasksTableView setDataSource:self];
    [self.view addSubview:_tasksTableView];
    
    _tasksData = [[NSMutableArray alloc] initWithObjects:@"Bleu", @"Blanc", @"Rouge", nil];
    
    _detailsVC = [[UIViewController alloc] init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

    [[self navigationController] pushViewController:_detailsVC animated:YES];
}


- (void)dealloc
{
    [_tasksTableView release];
    [_tasksData release];
    [_detailsVC release];
    
    [super dealloc];
}

@end
