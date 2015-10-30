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
    [myView hideInputStuff];
    
    self->myView.typeName.delegate=self;
    
    [myView.doneBtn addTarget:self
                       action:@selector(onClickDoneButton:)
             forControlEvents:UIControlEventTouchDown];
    
    
    [self.view addSubview:self->myView]; [self->myView release];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showView
{
    [self.view setHidden:false];
}

- (void)hideView
{
    [self.view setHidden:true];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self->myView clearPlaceHolderTypeName];
    [myView centerTextField];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [myView endCenterTextField];
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
        [myView hideInputStuff];
        [textField resignFirstResponder];
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
    else {
        [self->scores addObject:@{[NSNumber numberWithInteger:newScore]:@"???"}];
        self->curIndScore=0;
    }
    
    [self->myView setCurrentScore:newScore];
    [self->myView drawScores:self->scores];
    
        [myView showInputStuff];
    
    
}

- (void)onClickDoneButton:(id)sender
{
    [_delegate retain];
    if([_delegate respondsToSelector:@selector(endScoreAction)]){
        [_delegate endScoreAction];
    }
    [_delegate release];
}

@end