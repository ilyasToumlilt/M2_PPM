//
//  PrefView.m
//  
//
//  Created by ilyas TOUMLILT on 26/10/2015.
//
//

#import "PrefView.h"

@interface PrefView () {
    UILabel* descriptionLabel;
}

@end

@implementation PrefView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self) {
        /* fond gris transparent */
        self.backgroundColor = [[UIColor alloc] initWithRed:1 green:1 blue:1 alpha:0.6];
        
        /* descriptionLabel */
        descriptionLabel = [[UILabel alloc] init];
        [descriptionLabel setText:@"Choisissez votre niveau :"];
        [descriptionLabel setTextAlignment:NSTextAlignmentCenter];
        
        /* levelsPickerView */
        _levelsPickerView = [[UIPickerView alloc] init];
        [_levelsPickerView setTintColor:[UIColor blackColor]];
        
        /* doneButton */
        _doneButton = [[UIButton alloc] init];
        [_doneButton setTitle:@"Done" forState:UIControlStateNormal];
        [_doneButton.titleLabel setTextAlignment:NSTextAlignmentRight];
        [_doneButton setTintColor:[UIColor blueColor]];
        
        [self drawSubviews:frame.size];
        
        [self addSubview:descriptionLabel]; [descriptionLabel  release];
        [self addSubview:_levelsPickerView];[_levelsPickerView release];
        [self addSubview:_doneButton];      [_doneButton       release];
    }
    
    return self;
}

- (void)drawSubviews:(CGSize)frame
{
    self.frame = CGRectMake(0, 0, frame.width, frame.height);
    
    /* descriptionLabel */
    descriptionLabel.frame = CGRectMake(0, 50, frame.width, 30);
    
    /* levelsPickerView */
    _levelsPickerView.frame = CGRectMake(0, 100, frame.width, 180);
    
    /* doneButton */
    _doneButton.frame = CGRectMake(frame.width - 60, 20, 50, 30);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
