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

@interface LMMapView : UIView<CLLocationManagerDelegate, CLLocationManagerDelegate, MKMapViewDelegate>

@property (nonatomic, retain) CLLocationManager* locationManager;
@property (nonatomic, retain) MKMapView* mapView;

@end
