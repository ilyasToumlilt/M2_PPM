//
//  AsteroidView.m
//  
//
//  Created by ilyas TOUMLILT on 28/10/2015.
//
//

#import "AsteroidView.h"

@interface AsteroidView () {
    UIImageView* backgroundImage;
}

@end

@implementation AsteroidView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self) {
        
        const NSArray* imagesArray = [NSArray arrayWithObjects:@"asteroide-100-01", @"asteroide-100-02", @"asteroide-100-03", @"asteroide-100-04", @"asteroide-120-01", @"asteroide-120-02", @"asteroide-120-03",
                                      @"asteroide-120-04", nil];
        
        /* setting background Image */
        backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imagesArray[(arc4random()%(int)(imagesArray.count-1))]]];
        backgroundImage.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        
        /* drawing my cool stuff */
        //[self drawSubviews];
        
        /* adding and releasing subviews */
        [self addSubview:backgroundImage]; [backgroundImage release];
        
        /* déplacement */
        /*[UIView animateWithDuration:3.0
                              delay:0.0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{self.frame = CGRectMake(self.frame.origin.x, 400, self.frame.size.width, self.frame.size.height);}
                         completion:^(BOOL fin){if(fin) [self removeFromSuperview]; }];*/
        
        /* rotation */
        [UIView animateWithDuration:3.0
                              delay:0.0
                            options:UIViewAnimationOptionRepeat
                         animations:^{self.transform = CGAffineTransformMakeRotation(M_PI);}
                         completion:nil];
    }
    
    return self;
}

- (void)killMe
{
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
