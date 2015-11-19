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

@property(nonatomic, assign) int nunu;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *subtitle;
@property(nonatomic) CLLocationCoordinate2D coordinate;

@property (retain, nonatomic) UIImage *picture;

- (instancetype)initWithNumber:(int)number andName:(NSString*)name;

@end
