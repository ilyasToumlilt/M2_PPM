//
//  MADetailsViewController.m
//  MesActivites
//
//  Created by m2sar on 23/11/2015.
//  Copyright (c) 2015 ilyas TOUMLILT. All rights reserved.
//

#import "MADetailsViewController.h"

#import "MaTask.h"

@interface MADetailsViewController ()

@end

@implementation MADetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /* titleLabel Setup */
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"Title:";
    
    /* titleTextField Setup */
    _titleTextField = [[UITextField alloc] init];
    
    /* priorityLabel Setup */
    _priorityLabel = [[UILabel alloc] init];
    _priorityLabel.text = @"Priority:";
    
    /* prioritySC Setup */
    _prioritySC = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"0", @"1", @"2", @"3", @"4", nil]];
    _prioritySC.tintColor = [UIColor whiteColor];
    [_prioritySC addTarget:self
                    action:@selector(prioritySCValueDidChanged:)
          forControlEvents:UIControlEventValueChanged];
    
    /* pictureImageview Setup */
    _pictureImageView = [[UIImageView alloc] init];
    
    _currentTask = nil;
    
    [self drawSubviews:self.view.frame.size];
    
    /* adding subviews */
    [self.view addSubview:_titleLabel];
    [self.view addSubview:_titleTextField];
    [self.view addSubview:_priorityLabel];
    [self.view addSubview:_prioritySC];
    [self.view addSubview:_pictureImageView];

    /* releasing stuff */
    [_titleLabel release];
    [_titleTextField release];
    [_priorityLabel release];
    [_prioritySC release];
    [_pictureImageView release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#define V_BORDERLINE 20
#define H_BORDERLINE 90
#define DFLT_PADDING 20
- (void)drawSubviews:(CGSize)frame
{
    self.view.frame = CGRectMake(0,
                                 0,
                                 frame.width,
                                 frame.height);
    
    /* titleLabel */
    _titleLabel.frame = CGRectMake(V_BORDERLINE,
                                   H_BORDERLINE,
                                   48,
                                   20);
    
    /* titleTextField */
    _titleTextField.frame = CGRectMake(V_BORDERLINE + 50,
                                       H_BORDERLINE,
                                       frame.width - (2*V_BORDERLINE) - 50,
                                       20);
    
    /* priorityLabel */
    _priorityLabel.frame = CGRectMake(V_BORDERLINE,
                                      H_BORDERLINE + _titleLabel.frame.size.height + DFLT_PADDING,
                                      70,
                                      20);
    
    /* prioritySC */
    _prioritySC.frame = CGRectMake(V_BORDERLINE,
                                   _priorityLabel.frame.origin.y + _priorityLabel.frame.size.height + DFLT_PADDING,
                                   frame.width - (2*V_BORDERLINE),
                                   30);
    
    /* pictureImageView */
    _pictureImageView.frame = CGRectMake(V_BORDERLINE,
                                         _prioritySC.frame.origin.y + _prioritySC.frame.size.height + DFLT_PADDING,
                                         frame.width - (2*V_BORDERLINE),
                                         frame.height - (_priorityLabel.frame.origin.y + _priorityLabel.frame.size.height + DFLT_PADDING) - 60);
}

- (void)updateDetailsViewWithTask:(MaTask *)task
{
    
}

- (void)prioritySCValueDidChanged:(id)sender
{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/**
 * Releasing stuff
 */
- (void)dealloc
{
    [_splitVC release];
    
    [super dealloc];
}

@end
