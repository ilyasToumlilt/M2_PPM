//
//  LMMapView.m
//  Localise-Moi
//
//  Created by m2sar on 07/12/2015.
//  Copyright (c) 2015 Ilyas Toumlilt - Adrien Ferreira. All rights reserved.
//

#import "LMMapView.h"

@implementation LMMapView

- (instancetype)initWithFrame:(CGRect)frame
{
    [super initWithFrame:frame];
    
    if ( self ){
        self.backgroundColor = [UIColor whiteColor];
        
        /* si la localisation est activée */
        if([CLLocationManager locationServicesEnabled]){
            /* construction de la map */
            _mapView = [[MKMapView alloc] init];
            [_mapView setScrollEnabled:YES];
            [_mapView setZoomEnabled:YES];
            [self addSubview:_mapView];
            [_mapView setDelegate:self];
            [_mapView release];
            
            /* locationLanager */
            _locationManager = [[CLLocationManager alloc] init];
            [_locationManager setDistanceFilter:1.0];
            [_locationManager setDelegate:self];
            [_locationManager requestAlwaysAuthorization];
            
            [self drawSubviews:self.frame.size];
        } else {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Erreur" message:@"Localisation désactivée" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }
    
    return self;
}

- (void)drawSubviews:(CGSize)size
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
    
    _mapView.frame = CGRectMake(self.frame.origin.x,
                                self.frame.origin.y,
                                size.width,
                                size.height);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc
{
    [_locationManager release];
    
    [super dealloc];
}

@end
