//
//  ViewController.m
//  Humeur
//
//  Created by m2sar on 05/12/2015.
//  Copyright (c) 2015 m2sar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property NSNetService* moodNS;
@property NSMutableArray* myPairs;
@end

#define MOOD_CHOICE_TEXT @[@{@"mood_name":@"Happy",@"mood_color":[UIColor yellowColor]}, @{@"mood_name":@"Sad",@"mood_color":[UIColor purpleColor]}, @{@"mood_name":@"Blues",@"mood_color":[UIColor blueColor]},@{@"mood_name":@"Angry",@"mood_color":[UIColor redColor]}]

#define NET_SERVICE_TYPE @"_humeur._tcp."

#define HORIZONTAL_GUIDELINE 20

#define VERTICAL_GUIDELINE 20

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.utbv = [[UITableView alloc ]init];
    self.utbv.frame = CGRectMake(
        0,
        HORIZONTAL_GUIDELINE,
        self.view.frame.size.width - (2*VERTICAL_GUIDELINE),
        (self.view.frame.size.height-(2* HORIZONTAL_GUIDELINE))/2
    );
    
    [self.utbv setDelegate:self];
    [self.utbv setDataSource:self];
    [self.view addSubview:self.utbv];
    [self.utbv release];
    
    //NSLog(@"Propriete : %@",[[NSUserDefaults standardUserDefaults]stringForKey:@"pseudo_preference"]);
    
    self.upv = [[UIPickerView alloc] init];
    self.upv.frame = CGRectMake(VERTICAL_GUIDELINE, (self.view.frame.size.height-(2* HORIZONTAL_GUIDELINE))/2, self.view.frame.size.width - (2*VERTICAL_GUIDELINE), (self.view.frame.size.height-(2* HORIZONTAL_GUIDELINE))/2);
    [self.view addSubview:self.upv];
    [self.upv setDelegate:self];
    [self.upv setDataSource:self];
    [self.upv release];
    
    
    self.myPairs = [[NSMutableArray alloc]init];
    
    NSString* serverName = [[UIDevice currentDevice] name];
    self.moodNS = [[NSNetService alloc] initWithDomain:@"local."
                                                 type:NET_SERVICE_TYPE
                                                 name:serverName
                                                 port:9090
                                ];

    [self.moodNS setDelegate:self];
    [self.moodNS publish];
    
    NSNetServiceBrowser* browser = [[NSNetServiceBrowser alloc] init];
    [browser setDelegate:self];
    [browser searchForServicesOfType:NET_SERVICE_TYPE inDomain:@"local."];
    
    
    NSString*m=@"Adrien";
    NSString*m2=@"Happy";
    NSData*d = [m dataUsingEncoding:NSUTF8StringEncoding];
    NSData*d2 = [m2 dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary*dd = [NSDictionary dictionaryWithObjects:@[d,d2] forKeys:@[@"name",@"mood"]];
    NSData*r=[NSNetService dataFromTXTRecordDictionary:dd];
    [self.moodNS setTXTRecordData:r];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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

        if(!alreadyFound /*&&  À décommenter [netService.name compare: [[UIDevice currentDevice] name]] != NSOrderedSame*/)
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
    
    if(dd){
        NSDictionary *y = [NSNetService dictionaryFromTXTRecordData:dd];
        NSData*v= [y objectForKey:@"name"];
        NSDictionary *y2 = [NSNetService dictionaryFromTXTRecordData:dd];
        NSData*v2= [y2 objectForKey:@"mood"];
        if(v){
            mdata = [[NSString alloc]initWithData:v encoding:NSUTF8StringEncoding];
            cell.textLabel.text = mdata;
            mdata = [[NSString alloc]initWithData:v2 encoding:NSUTF8StringEncoding];
            cell.detailTextLabel.text =mdata;
        }
    }
    
    NSLog(@"cellForRowAtIndexPath");

    return cell;
    
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)netServiceBrowser didRemoveService:(NSNetService *)netService moreComing:(BOOL)moreServicesComing{
    [self.myPairs removeObject:netService];//safe comparaison d'adresse ??
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"numberOfRowsInSection");
    
    return [self.myPairs count];
}

- (void)pickerView:(UIPickerView *)pV didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"%ld",(long)row);
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [MOOD_CHOICE_TEXT count];
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title = [[MOOD_CHOICE_TEXT objectAtIndex:row] objectForKey:@"mood_name"];
    
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title
                                                                    attributes:@{NSForegroundColorAttributeName:[[MOOD_CHOICE_TEXT objectAtIndex:row] objectForKey:@"mood_color"]}];

    
    
    return attString;
}


@end
