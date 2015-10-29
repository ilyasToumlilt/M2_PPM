//
//  ScoreViewController.m
//  
//
//  Created by ilyas TOUMLILT on 26/10/2015.
//
//

#import "ScoreViewController.h"
#import "ScoreView.h"

@interface ScoreViewController () {
    ScoreView* myView;
    NSMutableArray* scores;
    NSInteger curIndScore;
}

@end

@implementation ScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self->curIndScore = -1;
    self->scores = [[NSMutableArray alloc]initWithCapacity:5];
    self->myView = [[ScoreView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self->myView]; [self->myView release];
    
    self->myView.typeName.delegate=self;
    
    /*UIView *v = [[UIView alloc]initWithFrame:CGRectMake(200, 200, 200, 200)];
    [v setBackgroundColor:[UIColor redColor] ];
    [self.view addSubview:v];*/
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showView
{
    NSLog(@"ScoreViewController.showView");
    [self->myView setHidden:false];
}

- (void)hideView
{
    [self->myView setHidden:true];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self->myView clearPlaceHolderTypeName];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSInteger curScore;
    
    if(self->curIndScore!=-1)
    {
        curScore =(NSInteger)[[self->scores objectAtIndex:(self->curIndScore)] allKeys][0];
        [self->scores insertObject:@{[NSNumber numberWithInteger:curScore]:textField.text} atIndex:self->curIndScore];
        self->curIndScore=-1;
        [self->myView drawScores:self->scores];
    }
    
    return YES;
}

-(void)addNewScore:(NSInteger)newScore
{
    NSUInteger i = [self->scores count];
    
    if(i>0)
    {
        while ((i > 0) && (newScore < [[[self->scores objectAtIndex:(i-1)] allKeys][0]intValue]))
        {
            [self->scores insertObject:[self->scores objectAtIndex:(i-1)] atIndex:(i)];
            i--;
        }
        [self->scores insertObject:@{[NSNumber numberWithInteger:newScore]:@"???"} atIndex:i];
        self->curIndScore= i;
    }
    else
        [self->scores addObject:@{[NSNumber numberWithInteger:newScore]:@"???"}];
    
    
    [self->myView setCurrentScore:newScore];
    [self->myView drawScores:self->scores];
}

@end
