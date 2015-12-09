//
//  PairesTableView.m
//  Humeur
//
//  Created by m2sar on 05/12/2015.
//  Copyright (c) 2015 m2sar. All rights reserved.
//

#import "PairesTableViewController.h"
#import "MoodSplitViewController.h"

#define GO_TO_MOODS_TXT @"Humeurs"

@interface PairesTableViewController()
@property NSNetService* moodNS;
@property NSMutableArray* myPairs;
@property NSNetServiceBrowser* moodBrowser;
@property UIBarButtonItem*moodButton;

@end

@implementation PairesTableViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString*propPseudo = [[NSUserDefaults standardUserDefaults]stringForKey:@"pseudo_preference"];
    NSString*defDevName = [[UIDevice currentDevice] name];
    
    self.utbv = [[UITableView alloc ]init];


    [self.utbv setDelegate:self];
    [self.utbv setDataSource:self];
    [self.view addSubview:self.utbv];
    [self.utbv release];
    
    self.myPairs = [[NSMutableArray alloc]init];
    
    self.moodNS = [[NSNetService alloc] initWithDomain:NET_SERVICE_DOMAIN
                                                  type:NET_SERVICE_TYPE
                                                  name:propPseudo?propPseudo:defDevName
                                                  port:9090
                   ];

    [self.moodNS setDelegate:self];
    [self.moodNS publish];
    
    self.moodBrowser = [[NSNetServiceBrowser alloc] init];
    [self.moodBrowser setDelegate:self];
    [self.moodBrowser searchForServicesOfType:NET_SERVICE_TYPE inDomain:NET_SERVICE_DOMAIN];

    self.moodButton = [[UIBarButtonItem alloc]initWithTitle:GO_TO_MOODS_TXT style:UIBarButtonItemStylePlain target:self action:@selector(goToMoodsAction)];
    [[self navigationItem]setRightBarButtonItem:self.moodButton];
    
    
    [self sendNewMood:IND_DEFAULT_MOOD];

    [self setElementsSize:self.view.frame.size];
}

-(void)setElementsSize:(CGSize)size{
    
    self.view.frame = CGRectMake(0, 0, size.width, size.height);
    
    self.utbv.frame = CGRectMake(
         0,
         HORIZONTAL_GUIDELINE,
         size.width,
         size.height - HORIZONTAL_GUIDELINE
    );
}

-(void)netServiceDidPublish:(NSNetService *)sender{
    NSLog(@"netServiceDidPublish");
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)netServiceBrowser didFindService:(NSNetService *)netService moreComing:(BOOL)moreServicesComing
{
    BOOL alreadyFound= FALSE;
    NSLog(@"netServiceBrowser");
    NSLog(@"%@",netService);
    
    if([netService.type compare:NET_SERVICE_TYPE] == NSOrderedSame)
    {
        for (NSNetService *ns in self.myPairs)
            if([ns.name compare: netService.name] == NSOrderedSame)
                alreadyFound=TRUE;
        
        if(!alreadyFound)
        {
            NSLog(@"Ajout de %@",netService.name);
            [netService setDelegate:self];
            [netService startMonitoring];
            [self.myPairs addObject:netService];
        }
    }
}

- (void)netService:(NSNetService *)sender didUpdateTXTRecordData:(NSData *)data{
    NSLog(@"didUpdateTXTRecordData");
    [self.utbv reloadData];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
    
    NSString *mdata=nil;
    NSNetService*nns=[self.myPairs objectAtIndex:indexPath.row];
    NSData*dd = [nns TXTRecordData];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MyIdentifier"] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if([[self.moodNS name] compare: [[self.myPairs objectAtIndex:indexPath.row]name]] == NSOrderedSame)
        [cell setBackgroundColor:[UIColor yellowColor]];
    else
        [cell setBackgroundColor: [UIColor whiteColor]];
    
    if(dd){
        NSDictionary *y2 = [NSNetService dictionaryFromTXTRecordData:dd];
        NSData*v2= [y2 objectForKey:@"message"];
        if(v2){
            cell.textLabel.text = [[self.myPairs objectAtIndex:indexPath.row]name];
            mdata = [[NSString alloc]initWithData:v2 encoding:NSUTF8StringEncoding];
            cell.detailTextLabel.text =mdata;
        }
        else{
            cell.textLabel.text = @"NoName";
            cell.detailTextLabel.text = @"NoMessage";
        }
    }
    
    return cell;
    
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)netServiceBrowser didRemoveService:(NSNetService *)netService moreComing:(BOOL)moreServicesComing{
    for (NSNetService *n in self.myPairs)
        if([[n name]compare:[netService name] ] == NSOrderedSame)
            [self.myPairs removeObject:n];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.myPairs count];
}

-(void)sendNewMood:(NSUInteger)indMood
{
    NSString*m2=[[MOOD_CHOICE_TEXT objectAtIndex:indMood] objectForKey:@"mood_name"];
    NSData*d = [m2 dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary*dd = [NSDictionary dictionaryWithObjects:@[d] forKeys:@[@"message"]];
    NSData*r=[NSNetService dataFromTXTRecordDictionary:dd];
    [self.moodNS setTXTRecordData:r];
}

- (void)viewWillTransitionToSize:(CGSize)size  withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [self setElementsSize:size];
}

-(void)goToMoodsAction{
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone &&
        [[UIScreen mainScreen] scale] != 3.0) {
        [[self navigationController] pushViewController:[self.splitVC detailsVC] animated:YES];
    }
}

@end
