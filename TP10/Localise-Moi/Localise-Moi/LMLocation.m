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

/************************************************************************************************
 * NSCoding Protocol
 ***********************************************************************************************/
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:[NSNumber numberWithInt:_number] forKey:@"number"];
    [aCoder encodeObject:_desc forKey:@"desc"];
    [aCoder encodeDouble:_coord.latitude forKey:@"latitude"];
    [aCoder encodeDouble:_coord.longitude forKey:@"longitude"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    _number = [[aDecoder decodeObjectForKey:@"number"] intValue];
    _desc = [[aDecoder decodeObjectForKey:@"desc"] copy];
    _coord.latitude = [aDecoder decodeDoubleForKey:@"latitude"];
    _coord.longitude = [aDecoder decodeDoubleForKey:@"longitude"];
    
    return self;
}

@end
