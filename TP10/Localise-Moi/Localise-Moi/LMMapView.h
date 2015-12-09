//
//  LMMapView.h
//  Localise-Moi
//
//  Created by m2sar on 07/12/2015.
//  Copyright (c) 2015 Ilyas Toumlilt - Adrien Ferreira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManagerDelegate.h>
#import <MapKit/MapKit.h>

@protocol LMMapViewDelegate;

@interface LMMapView : UIView<CLLocationManagerDelegate, CLLocationManagerDelegate, MKMapViewDelegate>

@property (nonatomic, retain) CLLocationManager* locationManager;
@property (nonatomic, retain) MKMapView* mapView;
@property (nonatomic, retain) UITextField* searchTextField;
@property (nonatomic, retain) UIButton* setupButton;
@property (nonatomic, retain) UISegmentedControl* mapTypeSC;

@property (nonatomic, assign) id<LMMapViewDelegate> delegate;

- (void)drawSubviews:(CGRect)size;
- (void)goToLocation:(CLLocationCoordinate2D)location;

@end

@protocol LMMapViewDelegate <NSObject>

- (void)searchAddress:(NSString*)adr;

@end