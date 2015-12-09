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
            [_mapView setDelegate:self];
            
            /* locationLanager */
            _locationManager = [[CLLocationManager alloc] init];
            [_locationManager setDistanceFilter:1.0];
            [_locationManager setDelegate:self];
            [_locationManager requestAlwaysAuthorization];
            
            /* searchTextfield */
            _searchTextField = [[UITextField alloc] init];
            [_searchTextField addTarget:self
                                action:@selector(searchTextFieldDidReturn:)
                      forControlEvents:UIControlEventEditingDidEnd];
            [_searchTextField setBorderStyle:UITextBorderStyleRoundedRect];
            [_searchTextField setClearButtonMode:UITextFieldViewModeAlways];
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignOnTap:)];
            [singleTap setNumberOfTapsRequired:1];
            [singleTap setNumberOfTouchesRequired:1];
            [self addGestureRecognizer:singleTap];
            [singleTap release];
            
            /* setupButton */
            _setupButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            _setupButton.backgroundColor = [UIColor whiteColor];
            [_setupButton addTarget:self
                             action:@selector(switchSegmentedControlView)
                   forControlEvents:UIControlEventTouchDown];
            // Round button corners
            CALayer *btnLayer = [_setupButton layer];
            [btnLayer setMasksToBounds:YES];
            [btnLayer setCornerRadius:15.0f];
            // Apply a 1 pixel, black border
            //[btnLayer setBorderWidth:1.0f];
            //[btnLayer setBorderColor:[[UIColor grayColor] CGColor]];
            // button image
            [_setupButton setTintColor:[UIColor grayColor]];
            [_setupButton setImage:[UIImage imageNamed:@"Settings"]
                         forState:UIControlStateNormal];
            
            /* maptypeSC */
            _mapTypeSC = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Carte", @"Satellite", @"Hybride", nil]];
            _mapTypeSC.tintColor = [UIColor grayColor];
            _mapTypeSC.backgroundColor = [UIColor whiteColor];
            _mapTypeSC.selectedSegmentIndex = 0;
            [_mapTypeSC addTarget:self
                           action:@selector(mapTypeSCValueDidChanged:)
                 forControlEvents:UIControlEventValueChanged];
            
            [self addSubview:_mapView];
            [self addSubview:_searchTextField];
            [self addSubview:_setupButton];
            [self addSubview:_mapTypeSC];
            
            [self drawSubviews:self.frame];
            
            [_mapView release];
            [_searchTextField release];
            [_setupButton release];
            [_mapTypeSC release];
        } else {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Erreur" message:@"Localisation désactivée" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }
    
    return self;
}

/************************************************************************************************
 * Managing Subviews
 ***********************************************************************************************/
- (void)drawSubviews:(CGRect)frame
{
    self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
    self.backgroundColor = [UIColor redColor];
    
    _mapView.frame = CGRectMake(0,
                                0,
                                self.frame.size.width,
                                self.frame.size.height);
    
    _searchTextField.frame = CGRectMake(55, 30, frame.size.width - 65, 40);
    
    _setupButton.frame = CGRectMake(10, 30, 40, 40);
    
    _mapTypeSC.frame = CGRectMake(55, 30, frame.size.width - 65, 40);
    _mapTypeSC.hidden = YES;
    
}

/************************************************************************************************
 * Config Button
 ***********************************************************************************************/
- (void)switchSegmentedControlView
{
    _mapTypeSC.hidden = !_mapTypeSC.hidden;
}

/************************************************************************************************
 * UISegmentedControl setup
 ***********************************************************************************************/
- (void)showSatelliteSegment
{
    [_mapTypeSC setEnabled:YES forSegmentAtIndex:1];
}

- (void)hideSatelliteSegment
{
    [_mapTypeSC setEnabled:NO forSegmentAtIndex:1];
}

/************************************************************************************************
 * Location services
 ***********************************************************************************************/
- (void)goToLocation:(CLLocationCoordinate2D)location
{
    [_mapView setRegion:MKCoordinateRegionMakeWithDistance(location, 500, 500) animated:YES];
}

/************************************************************************************************
 * searchTextField & UITextFieldDelegate Methods
 ***********************************************************************************************/
- (void)searchTextFieldDidReturn:(UITextField*)sender
{
    [_delegate retain];
    [_delegate searchAddress:[NSString stringWithString:sender.text]];
    [_delegate release];
}

- (void)resignOnTap:(id)iSender {
    [_searchTextField resignFirstResponder];
}

/************************************************************************************************
 * UISegmentedCotnrol Methods
 ***********************************************************************************************/
- (void)mapTypeSCValueDidChanged:(UISegmentedControl*)sender
{
    /* On met à jour la priorité de la tache */
    //[_currentTask setPrio:(int)sender.selectedSegmentIndex];
    switch (sender.selectedSegmentIndex) {
        case 0:
            [_mapView setMapType:MKMapTypeStandard];
            break;
        case 1:
            [_mapView setMapType:MKMapTypeSatellite];
            break;
        case 2:
            [_mapView setMapType:MKMapTypeHybrid];
            break;
            
    }
}

/************************************************************************************************
 * Memory Care Center
 ***********************************************************************************************/
- (void)dealloc
{
    [_locationManager release];
    
    [super dealloc];
}

@end
