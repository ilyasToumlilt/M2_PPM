//
//  LMLocation.m
//  
//
//  Created by ilyas TOUMLILT on 08/12/2015.
//
//

#import "LMLocation.h"

@implementation LMLocation

- (instancetype)initWithNumber:(int)number
                andDescription:(NSString*)desc
                 andCoordinate:(CLLocationCoordinate2D)coord
{
    self = [self init];
    
    if(self){
        _number = number;
        _desc = [NSString stringWithString:desc];
        _coord = coord;
    }
    
    return self;
}

- (void)dealloc
{
    [_desc release];
    
    [super dealloc];
}

@end
