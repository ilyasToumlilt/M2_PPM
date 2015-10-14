//
//  View.m
//  NuancierRVBGeek
//
//  Created by ilyas TOUMLILT on 13/10/2015.
//  Copyright (c) 2015 ilyas TOUMLILT. All rights reserved.
//

#import "View.h"

@implementation View

const CGFloat V_BORDERLINE = 20.0;
const CGFloat H_BORDERLINE = 30.0;
const int     PADDING      = 10;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        /* myButtonPrec */
        _myButtonPrec = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_myButtonPrec setTitle:@"" forState:UIControlStateNormal];
        
        /* myLabelPrec */
        _myLabelPrec = [[UILabel alloc] init];
        _myLabelPrec.text = @"Précédent";
        _myLabelPrec.textAlignment = NSTextAlignmentRight;
        
        /* myButtonPenu */
        _myButtonPenu = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_myButtonPenu setTitle:@"" forState:UIControlStateNormal];
        
        /* myLabelPenu */
        _myLabelPenu = [[UILabel alloc] init];
        _myLabelPenu.text = @"Pénultième";
        _myLabelPenu.textAlignment = NSTextAlignmentRight;
        
        /* myActualLabel */
        _myActualLabel = [[UILabel alloc] init];
        _myActualLabel.text = @"Actuel";
        _myActualLabel.textAlignment = NSTextAlignmentCenter;
        
        /* myActualColorView */
        _myActualColorView = [[UILabel alloc] init];
        
        /* mySaveButton */
        _mySaveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_mySaveButton setTitle:@"Save" forState:UIControlStateNormal];
        
        /* myResetButton */
        _myResetButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_myResetButton setTitle:@"Raz" forState:UIControlStateNormal];
        
        /* mySwitch */
        _mySwitch = [[UISwitch alloc] init];
        _mySwitch.on = false;
        
        /* myWebLabel */
        _myWebLabel = [[UILabel alloc] init];
        _myWebLabel.text = @"Web";
        _myWebLabel.textAlignment = NSTextAlignmentCenter;
        
        /* myRLabel */
        _myRLabel = [[UILabel alloc] init];
        _myRLabel.text = @"R: 50%";
        _myRLabel.textAlignment = NSTextAlignmentLeft;
        
        /* myRSlider */
        _myRSlider = [[UISlider alloc] init];
        _myRSlider.minimumValue = 0.0;
        _myRSlider.maximumValue = 100.0;
        
        /* myVLabel */
        _myVLabel = [[UILabel alloc] init];
        _myVLabel.text = @"V: 50%";
        _myVLabel.textAlignment = NSTextAlignmentLeft;
        
        /* myVSlider */
        _myVSlider = [[UISlider alloc] init];
        _myVSlider.minimumValue = 0.0;
        _myVSlider.maximumValue = 100.0;
        
        /* myBLabel */
        _myBLabel = [[UILabel alloc] init];
        _myBLabel.text = @"B: 50%";
        _myBLabel.textAlignment = NSTextAlignmentLeft;
        
        /* myBSlider */
        _myBSlider = [[UISlider alloc] init];
        _myBSlider.minimumValue = 0.0;
        _myBSlider.maximumValue = 100.0;
        
        
        [self drawElements:frame];
        
        /* releasing objects */
        [self addSubview:_myButtonPrec]; [_myButtonPrec  release];
        [self addSubview:_myLabelPrec];  [_myLabelPrec   release];
        [self addSubview:_myButtonPenu]; [_myButtonPenu  release];
        [self addSubview:_myLabelPenu];  [_myLabelPenu   release];
        [self addSubview:_myActualLabel];[_myActualLabel release];
        [self addSubview:_mySaveButton]; [_mySaveButton  release];
        [self addSubview:_myResetButton];[_myResetButton release];
        [self addSubview:_myWebLabel];   [_myWebLabel    release];
        [self addSubview:_mySwitch];     [_mySwitch      release];
        [self addSubview:_myRLabel];     [_myRLabel      release];
        [self addSubview:_myRSlider];    [_myRSlider     release];
        [self addSubview:_myVLabel];     [_myVLabel      release];
        [self addSubview:_myVSlider];    [_myVSlider     release];
        [self addSubview:_myBLabel];     [_myBLabel      release];
        [self addSubview:_myBSlider];    [_myBSlider     release];
        [self addSubview:_myActualColorView];
        [_myActualColorView release];
    }
    return self;
}

- (void)drawElements:(CGRect)frame
{
    
    /* draw point */
    CGPoint dp = CGPointMake(V_BORDERLINE, H_BORDERLINE);

    /****** Iphones en portrait *********/
    if( frame.size.width < frame.size.height ) {
        /* myLabelPrec */
        [_myLabelPrec setFrame:CGRectMake(frame.size.width - V_BORDERLINE - 90, H_BORDERLINE, 90, 40)];
        /* myButtonPrec */
        [_myButtonPrec setFrame:CGRectMake(dp.x, dp.y, frame.size.width-(2*V_BORDERLINE)-100, 40)];
    
        dp.y += (40 + PADDING);
    
        /* myButtonPrec */
        [_myButtonPenu setFrame:CGRectMake(dp.x, dp.y, frame.size.width-(2*V_BORDERLINE)-100, 40)];
        /* myLabelPrec */
        [_myLabelPenu setFrame:CGRectMake(frame.size.width-V_BORDERLINE-90, dp.y, 90, 40)];
    
        dp.y += ( 40 + PADDING);
    
        /* myActualLabel */
        [_myActualLabel setFrame:CGRectMake(dp.x, dp.y, frame.size.width-(2*V_BORDERLINE), 20)];
    
        dp.y += ( 20 + PADDING );

        /* Les elements du bas sont pareils pour toutes les vues
         * cf. doc de la methode */
        CGPoint dp2 = [self drawBottomElements:frame];
    
        /* myActualColorView */
        [_myActualColorView setFrame:CGRectMake(dp.x, dp.y, frame.size.width - (2*V_BORDERLINE), dp2.y - dp.y)];
    } else {
        /* myButtonPrec */
        [_myButtonPrec setFrame:CGRectMake(dp.x, dp.y, 80, 35)];
        
        dp.x += ( 80 + PADDING );
        
        /* myButtonPenu */
        [_myButtonPenu setFrame:CGRectMake(dp.x, dp.y, 80, 35)];
        
        dp.x += ( 80 + PADDING );
        
        /* myActualColorView */
        [_myActualColorView setFrame:CGRectMake(dp.x, dp.y, frame.size.width - (2*V_BORDERLINE) - (2*(80+PADDING)), 35)];
    }
}

/**
 * Comme les elements du bas auront la même disposition pour tous les
 * d'affichages et terminaux, je factorise leur code dans cette
 * méthode.
 * Les elements du bas sont, les sliders et leurs UILabels et tous
 * les autres obutons en dessous.
 * @param frame toute la surface de dessin de l'ecran, je dessine
 *              automatiquement à partir du bas de cette surface.
 * @return CGPoint le point ou le dessin s'est arrete, histoire
 *                  de permettre a l'appellant de savoir ou est-ce
 *                  que le dessin s'arrette.
 */
- (CGPoint)drawBottomElements:(CGRect)frame
{
    /* draw point, ici on part du bas */
    CGPoint dp = CGPointMake(V_BORDERLINE, frame.origin.y + frame.size.height - 20);
    
    /* mySaveButton */
    [_mySaveButton setFrame:CGRectMake(dp.x, dp.y - 20, 50, 20)];
    
    /* myResetButton */
    [_myResetButton setFrame:CGRectMake((frame.size.width / 2)-20, dp.y-20, 40, 20)];
    
    /* mySwitch */
    [_mySwitch setFrame:CGRectMake(frame.size.width - V_BORDERLINE - 50, dp.y - 25, 50, 25)];
    
    /* myWebLabel */
    [_myWebLabel setFrame:CGRectMake(frame.size.width - V_BORDERLINE - 50 - 50, dp.y - 20, 40, 25)];
    
    dp.y -= ( 25 + PADDING );
    
    /* myBSlider */
    [_myBSlider setFrame:CGRectMake(dp.x, dp.y - 20, frame.size.width - (2*V_BORDERLINE), 20)];
    
    dp.y -= ( 20 + PADDING);
    
    /* myBLabel */
    [_myBLabel setFrame:CGRectMake(dp.x, dp.y - 20, frame.size.width - (2*V_BORDERLINE), 20)];
    
    dp.y -= ( 25 + PADDING );
    
    /* myVSlider */
    [_myVSlider setFrame:CGRectMake(dp.x, dp.y - 20, frame.size.width - (2*V_BORDERLINE), 20)];
    
    dp.y -= ( 20 + PADDING);
    
    /* myVLabel */
    [_myVLabel setFrame:CGRectMake(dp.x, dp.y - 20, frame.size.width - (2*V_BORDERLINE), 20)];
    
    dp.y -= ( 25 + PADDING );
    
    /* myRSlider */
    [_myRSlider setFrame:CGRectMake(dp.x, dp.y - 20, frame.size.width - (2*V_BORDERLINE), 20)];
    
    dp.y -= ( 20 + PADDING);
    
    /* myRLabel */
    [_myRLabel setFrame:CGRectMake(dp.x, dp.y - 20, frame.size.width - (2*V_BORDERLINE), 20)];
    
    dp.y -= ( 25 + PADDING);
    
    return dp;
}


 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
/*
 - (void)drawRect:(CGRect)rect {
     [self drawElements:[[UIScreen mainScreen] bounds]];
 }
*/

@end
