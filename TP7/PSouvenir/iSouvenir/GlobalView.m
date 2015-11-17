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
        
        /* myPMap */
        _myPMap = [[PMapView alloc] initWithFrame:CGRectMake(0,
                                                             0,
                                                             self.frame.size.width,
                                                             self.frame.size.height - TOOLBAR_HEIGHT)];
        
        /* myPToolbar */
        _myPToolbar = [[PToolbarView alloc] initWithFrame:CGRectMake(0,
                                                                     self.frame.size.height - TOOLBAR_HEIGHT,
                                                                     self.frame.size.width,
                                                                     TOOLBAR_HEIGHT)];
        
        [self addSubview:_myPToolbar];
        [self addSubview:_myPMap];
    }
    
    return self;
}

- (void)dealloc
{
    [_myPToolbar release];
    [_myPMap     release];
    
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
