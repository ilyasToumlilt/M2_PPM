//
//  PMapView.h
//
//
//  Created by ilyas TOUMLILT on 16/11/2015.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@protocol PMapViewDelegate;

@interface PMapView : UIView<MKMapViewDelegate>

@property (assign, nonatomic) id<PMapViewDelegate> delegate;

@property (assign,nonatomic) MKMapView *mv;
@property (assign,nonatomic) UIImageView *iv;
@property (assign,nonatomic) UISegmentedControl *scv;

-(void)hideImage;
-(void)showImage:(NSString*)urlImage;
-(void)putPin:(NSString*)labelPin;
-(void)setElementsSize:(CGSize)size;
@end

@protocol PMapViewDelegate <NSObject>

/* TODO add delegates methods */;

@end
