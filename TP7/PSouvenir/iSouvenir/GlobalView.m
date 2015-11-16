//
//  GlobalView.m
//  
//
//  Created by ilyas TOUMLILT on 16/11/2015.
//
//

#import "GlobalView.h"

@implementation GlobalView

#define TOOLBAR_HEIGHT 70

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self){
        
        /* myPToolbar */
        _myPToolbar = [[PToolbarView alloc] initWithFrame:CGRectMake(0,
                                                                     self.frame.size.height - TOOLBAR_HEIGHT,
                                                                     self.frame.size.width,
                                                                     TOOLBAR_HEIGHT)];
        
        [self drawSubviews];
        
        [self addSubview:_myPToolbar];

    }
    
    return self;
}

- (void)drawSubviews
{
    
    /* myPToolbar */
    /*_myPToolbar.view.frame = CGRectMake(0,
                                        self.frame.size.height - TOOLBAR_HEIGHT,
                                        self.frame.size.width,
                                        TOOLBAR_HEIGHT);
    */
}

- (void)dealloc
{
    [_myPToolbar release];
    
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
