//
//  MaTask.m
//  
//
//  Created by ilyas TOUMLILT on 23/11/2015.
//
//

#import "MaTask.h"
#define DEF_T_TITLE @"Nouvelle tâche"
#define DEF_T_SUBT @"..."
#define DEF_T_PRIO 0


@implementation MaTask

- (instancetype)init
{
    self = [super init];
    
    if(self){
        _title = [[NSMutableString alloc] initWithString:DEF_T_TITLE];
        _subtitle = [[NSMutableString alloc] initWithString:DEF_T_SUBT];
        _prio = DEF_T_PRIO;
        _picture = nil;
    }
    
    return self;
}

- (void)dealloc
{
    [_title release];
    [_subtitle release];
    [_picture release];
    
    [super dealloc];
}

@end
