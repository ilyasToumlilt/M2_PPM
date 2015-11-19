//
//  PMapView.h
//
//
//  Created by ilyas TOUMLILT on 16/11/2015.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Contact.h"

@protocol PMapViewDelegate;

@interface PMapView : UIView<MKMapViewDelegate, CLLocationManagerDelegate>

@property (assign, nonatomic) id<PMapViewDelegate> delegate;

@property (assign,nonatomic) MKMapView *mv;
@property (assign,nonatomic) UIImageView *iv;
@property (assign,nonatomic) UISegmentedControl *scv;

- (void)setElementsSize:(CGSize)size;

- (void)drawSubviews:(CGSize)size;

/**
 * doit remplacer putPin
 * Contact est déjà un MKAnnotation
 * il suffit de modifier sa prop coordinates
 * et de le rajouter à la mapView.
 * ne pas le release.
 */
- (void)addNewPin:(Contact*)c;

/**
 * - le VC est assez intelligent pour n'appeler cette
 * méthode que si un pin est sélectionné, mais on
 * testera quand même.
 * - supprime le pin selectionné.
 * - pas de release
 * - retourne le number du pin selectionné ( prop contact )
 */
- (void)removeSelectedPin;

- (void)updateSelectedPin:(NSString*)newTitle;


- (CLLocationCoordinate2D) getCurrentPosition;
- (void)gotToCurrentPosition;

-(void)hideImage;
-(void)showImage:(UIImage*)image;

@end

@protocol PMapViewDelegate <NSObject>

- (void)didSelectPin:(NSString*)title;
- (void)didDiselectPin;

@end
