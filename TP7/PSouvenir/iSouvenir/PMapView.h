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

@interface PMapView : UIView<MKMapViewDelegate>

@property (assign, nonatomic) id<PMapViewDelegate> delegate;

@property (assign,nonatomic) MKMapView *mv;
@property (assign,nonatomic) UIImageView *iv;
@property (assign,nonatomic) UISegmentedControl *scv;

- (void)hideImage;
- (void)showImage:(NSString*)urlImage;
- (void)setElementsSize:(CGSize)size;


- (void)putPin:(NSString*)labelPin;

- (void)drawSubviews:(CGSize)size;

/**** TODO ****/

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
- (int)removeSelectedPin;

@end

@protocol PMapViewDelegate <NSObject>

- (void)didSelectPin:(Contact*)c;
- (void)didDiselectPin;

@end
