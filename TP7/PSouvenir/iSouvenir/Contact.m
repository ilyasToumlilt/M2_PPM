//
//  Contact.m
//  
//
//  Created by ilyas TOUMLILT on 16/11/2015.
//
//

#import "Contact.h"

@implementation Contact

- (instancetype)initWithNumber:(int)number andName:(NSString*)name
{
    self = [self init];
    if(self){
        _number  = number;
        _name    = name;
        _picture = nil;
    }
    return self;
}

- (void)dealloc
{
    [_picture release];
    [super dealloc];
}

@end
