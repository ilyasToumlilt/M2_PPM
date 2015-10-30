//
//  MainView.m
//  
//
//  Created by ilyas TOUMLILT on 26/10/2015.
//
//

#import "MainView.h"

@interface MainView () {
    UIImageView* backgroundImage;
}

@end

@implementation MainView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self) {
        /* Background image */
        backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fond-mauvaise-pluie"]];
        
        /* ScoreButton */
        _scoreButton = [[UIButton alloc] init];
        [_scoreButton setTitle:@"Scores" forState:UIControlStateNormal];
        [_scoreButton.titleLabel setTextAlignment:NSTextAlignmentLeft];
        
        /* GameButton */
        _gameButton = [[UIButton alloc] init];
        [_gameButton setTitle:@"Jouer" forState:UIControlStateNormal];
        [_gameButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
        
        /* PrefButton */
        _prefButton = [[UIButton alloc] init];
        [_prefButton setTitle:@"Préférences" forState:UIControlStateNormal];
        [_prefButton.titleLabel setTextAlignment:NSTextAlignmentRight];
        
        /* drawing my cool stuff */
        [self drawSubviews:frame.size];
        
        /* Adding and releasing subviews */
        [self addSubview:backgroundImage]; [backgroundImage release];
        [self addSubview:_scoreButton];    [_scoreButton    release];
        [self addSubview:_gameButton];     [_gameButton     release];
        [self addSubview:_prefButton];     [_prefButton     release];
    }
    
    return self;
}

- (void)drawSubviews:(CGSize)frame
{
    const CGFloat V_BORDERLINE = 10;
    const CGFloat H_BORDERLINE = 20;
    
    self.frame = CGRectMake(0, 0, frame.width, frame.height);
    
    // un petit produit en croix par rapport à la largeur
    // pour adapter la frame de l'image.
    backgroundImage.frame = CGRectMake(0, 0, frame.width,
                                       (backgroundImage.image.size.height * frame.width / backgroundImage.image.size.width));
    
    /* scoreButton */
    _scoreButton.frame = CGRectMake(V_BORDERLINE, H_BORDERLINE, 80, 20);
    
    /* gameButton */
    _gameButton.frame = CGRectMake((frame.width / 2)-25, H_BORDERLINE, 50, 20);
    
    /* prefButton */
    _prefButton.frame = CGRectMake(frame.width - V_BORDERLINE - 100, H_BORDERLINE, 100, 20);
}

- (void)showSubviews
{
    [_scoreButton setHidden:NO];
    [_gameButton setHidden:NO];
    [_prefButton setHidden:NO];
}

- (void)hideSubviews
{
    [_scoreButton setHidden:YES];
    [_gameButton setHidden:YES];
    [_prefButton setHidden:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
