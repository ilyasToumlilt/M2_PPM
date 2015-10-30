//
//  MinionView.m
//  
//
//  Created by ilyas TOUMLILT on 27/10/2015.
//
//

#import "MinionView.h"

@interface MinionView () {
    UIImageView* backgroundImage;
}

@end

@implementation MinionView

#define MOVING_DT 20

- (instancetype)initWithMovingArea:(CGRect)movingArea
{
    /* je commence par calculer ma frame,
     * c-à-d au centre de la movingArea
     */
    _actualPosition = CGRectMake((movingArea.size.width/2) - (movingArea.size.height/2), movingArea.origin.y, movingArea.size.height, movingArea.size.height);
    _movingArea = movingArea;
    
    self = [super initWithFrame:_actualPosition];
    
    if(self) {
        
        /* setting background Image */
        backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"player"]];
        backgroundImage.frame = CGRectMake(0, 0, _actualPosition.size.width, _actualPosition.size.height);
        
        /* drawing my cool stuff */
        //[self drawSubviews];
        
        /* adding and releasing subviews */
        [self addSubview:backgroundImage]; [backgroundImage release];
        
    }
    
    return self;
}

- (void)drawSubviews
{
    /* background image */
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (BOOL)canMoveLeft
{
    return ( _actualPosition.origin.x - MOVING_DT >= _movingArea.origin.x);
}

- (BOOL)canMoveRight
{
    return ( _actualPosition.origin.x + _actualPosition.size.width + MOVING_DT <= _movingArea.origin.x + _movingArea.size.width);
}

- (void)moveLeft
{
    if([self canMoveLeft]) {
        _actualPosition.origin.x -= MOVING_DT;
        self.frame = _actualPosition;
    }
}

- (void)moveRight
{
    if([self canMoveRight]) {
        _actualPosition.origin.x += MOVING_DT;
        self.frame = _actualPosition;
    }
}

@end
