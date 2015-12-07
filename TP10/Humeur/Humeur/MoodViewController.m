//
//  MoodViewController.m
//  Humeur
//
//  Created by m2sar on 07/12/2015.
//  Copyright (c) 2015 m2sar. All rights reserved.
//

#import "MoodViewController.h"

@implementation MoodViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.upv = [[UIPickerView alloc] init];
    [self.view addSubview:self.upv];
    [self.upv setDelegate:self];
    [self.upv setDataSource:self];
    [self.upv release];

    [self setElementsSize:self.view.frame.size];
}

-(void)setElementsSize:(CGSize)size{
    
    self.view.frame = CGRectMake(0, 0, size.width, size.height);
    
    self.upv.frame = CGRectMake(
        VERTICAL_GUIDELINE,
        HORIZONTAL_GUIDELINE,
        size.width - (2*VERTICAL_GUIDELINE),
        size.height-(2* HORIZONTAL_GUIDELINE)
    );
}

- (void)pickerView:(UIPickerView *)pV didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
     [self.delegate retain];
     if( [self.delegate respondsToSelector:@selector(sendNewMood:)] )
        [self.delegate sendNewMood:row];
     [self.delegate release];
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
