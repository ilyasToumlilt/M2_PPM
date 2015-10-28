//
//  PrefView.m
//  
//
//  Created by ilyas TOUMLILT on 26/10/2015.
//
//

#import "PrefView.h"

@implementation PrefView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self) {
        
        [self drawSubviews:frame.size];
    }
    
    return self;
}

- (void)drawSubviews:(CGSize)frame
{
    self.frame = CGRectMake(0, 0, frame.width, frame.height);
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
