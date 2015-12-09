//
//  LMLocation.h
//  
//
//  Created by ilyas TOUMLILT on 08/12/2015.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LMLocation : NSObject

@property (nonatomic, assign) int number;
@property (nonatomic, retain) NSString* desc;
@property (nonatomic, assign) CLLocationCoordinate2D coord;

- (instancetype)initWithNumber:(int)number
                andDescription:(NSString*)desc
                 andCoordinate:(CLLocationCoordinate2D)coord;
@end
