//
//  MaTask.m
//  
//
//  Created by ilyas TOUMLILT on 23/11/2015.
//
//

#import "MaTask.h"

@implementation MaTask

- (instancetype)init
{
    self = [super init];
    
    if(self){
        _title = [[NSMutableString alloc] initWithString:@"Nouvelle tache"];
        _subtitle = [[NSMutableString alloc] initWithString:@"..."];
        _prio = 0;
        _picture = nil;
        _idSection = 0;
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
