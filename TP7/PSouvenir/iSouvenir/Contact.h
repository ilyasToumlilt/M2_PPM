//
//  Contact.h
//  
//
//  Created by ilyas TOUMLILT on 16/11/2015.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface Contact : NSObject<MKAnnotation>

@property (assign, nonatomic) int number;
@property (assign, nonatomic) NSString *name;
@property (retain, nonatomic) UIImage *picture;
@property(nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (instancetype)initWithNumber:(int)number andName:(NSString*)name;

@end
