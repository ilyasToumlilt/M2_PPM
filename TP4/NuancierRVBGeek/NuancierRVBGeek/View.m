//
//  View.m
//  NuancierRVBGeek
//
//  Created by ilyas TOUMLILT on 13/10/2015.
//  Copyright (c) 2015 ilyas TOUMLILT. All rights reserved.
//

#import "View.h"

@implementation View

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

const CGFloat V_BORDERLINE = 20.0;
const CGFloat H_BORDERLINE = 30.0;
const int     PADDING      = 10;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        /* myButtonPrec */
        myButtonPrec = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [myButtonPrec setTitle:@"" forState:UIControlStateNormal];
        [myButtonPrec setBackgroundColor:[UIColor grayColor]];
        [self addSubview:myButtonPrec];
        
        /* myLabelPrec */
        myLabelPrec = [[UILabel alloc] init];
        myLabelPrec.text = @"Précédent";
        myLabelPrec.textAlignment = NSTextAlignmentRight;
        [self addSubview:myLabelPrec];
        
        /* myButtonPenu */
        myButtonPenu = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [myButtonPenu setTitle:@"" forState:UIControlStateNormal];
        [myButtonPenu setBackgroundColor:[UIColor grayColor]];
        [self addSubview:myButtonPenu];
        
        /* myLabelPenu */
        myLabelPenu = [[UILabel alloc] init];
        myLabelPenu.text = @"Pénultième";
        myLabelPenu.textAlignment = NSTextAlignmentRight;
        [self addSubview:myLabelPenu];
        
        /* myActualLabel */
        myActualLabel = [[UILabel alloc] init];
        myActualLabel.text = @"Actuel";
        myActualLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:myActualLabel];
        
        /* mySaveButton */
        mySaveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [mySaveButton setTitle:@"Save" forState:UIControlStateNormal];
        [self addSubview:mySaveButton];
        
        /* myResetButton */
        myResetButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [myResetButton setTitle:@"Raz" forState:UIControlStateNormal];
        [self addSubview:myResetButton];
        
        /* mySwitch */
        mySwitch = [[UISwitch alloc] init];
        mySwitch.on = false;
        [self addSubview:mySwitch];
        
        [self drawElements:frame];
        
        /* releasing objects */
        [myButtonPrec release];
        [myLabelPrec release];
        [myButtonPenu release];
        [myLabelPenu release];
        [myActualLabel release];
        [mySaveButton release];
        [myResetButton release];
    }
    return self;
}

- (void)drawElements:(CGRect)frame
{
    /* draw point */
    CGPoint dp = CGPointMake(V_BORDERLINE, H_BORDERLINE);

    /* myLabelPrec */
    [myLabelPrec setFrame:CGRectMake(frame.size.width - V_BORDERLINE - 90, H_BORDERLINE, 90, 40)];
    /* myButtonPrec */
    [myButtonPrec setFrame:CGRectMake(dp.x, dp.y, frame.size.width-(2*V_BORDERLINE)-100, 40)];
    
    dp.y += (40 + PADDING);
    
    /* myButtonPrec */
    [myButtonPenu setFrame:CGRectMake(dp.x, dp.y, frame.size.width-(2*V_BORDERLINE)-100, 40)];
    /* myLabelPrec */
    [myLabelPenu setFrame:CGRectMake(frame.size.width-V_BORDERLINE-90, dp.y, 90, 40)];
    
    dp.y += ( 40 + PADDING);
    
    /* myActualLabel */
    [myActualLabel setFrame:CGRectMake(dp.x, dp.y, frame.size.width-(2*V_BORDERLINE), 20)];

    /* Les elements du bas sont pareils pour toutes les vues
     * cf. doc de la methode */
    [self drawBottomElements:frame];
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
    /* draw point */
    CGPoint dp = CGPointMake(V_BORDERLINE, frame.origin.y + frame.size.height - 20);
    
    /* mySaveButton */
    [mySaveButton setFrame:CGRectMake(dp.x, dp.y - 20, 50, 20)];
    
    /* myResetButton */
    [myResetButton setFrame:CGRectMake((frame.size.width / 2)-20, dp.y-20, 40, 20)];
    
    /* mySwitch */
    
    return dp;
}

@end
